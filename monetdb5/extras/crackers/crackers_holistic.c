/*
 * The contents of this file are subject to the MonetDB Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.monetdb.org/Legal/MonetDBLicense
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Original Code is the MonetDB Database System.
 *
 * The Initial Developer of the Original Code is CWI.
 * Portions created by CWI are Copyright (C) 1997-July 2008 CWI.
 * Copyright August 2008-2012 MonetDB B.V.
 * All Rights Reserved.
 */

#include "monetdb_config.h"
#include "crackers.h"
#include "gdk.h"
#include "mal_exception.h"
#include "opt_pipes.h"
#include "mutils.h"

static FrequencyNode *_InternalFrequencyStructA = NULL;
static FrequencyNode *_InternalFrequencyStructB = NULL;
static MT_Lock frequencylock;
static MT_Id idletime_thread;

int isIdleQuery = 0;
IdleFuncPtr IdleFunc;

str
CRKinitHolistic(int *ret)
{
	IdleFunc=&CRKrandomCrack;
	MT_lock_init(&frequencylock, "FrequencyStruct");
	MT_create_thread(&idletime_thread,(void (*)(void *))HeartbeatCPUload, IdleFunc, MT_THR_JOINABLE);
	*ret = 0;
	return MAL_SUCCEED;
}

/*singleton pattern*/
FrequencyNode *
getFrequencyStruct(char which)
{
	FrequencyNode **theNode = NULL;

	MT_lock_set(&frequencylock, "getFrequencyStruct");
	switch (which) {
                case 'A':
                        theNode = &_InternalFrequencyStructA;
                        break;
                case 'B':
                        theNode = &_InternalFrequencyStructB;
                        break;
                default:
                        assert(0);
         }

        /* GDKzalloc = calloc = malloc + memset(0) */
        if (*theNode == NULL)
                *theNode = GDKzalloc(sizeof(FrequencyNode));
	MT_lock_unset(&frequencylock, "getFrequencyStruct");
	
	return *theNode;
}
/*this function pushes nodes in the list and is used in cost models: 2,4,6,8,10*/
void 
push(int bat_id,FrequencyNode* head)
{
	FrequencyNode* new_node;
	new_node=(FrequencyNode *) GDKmalloc(sizeof(FrequencyNode));
	new_node->bid=bat_id;
	new_node->c=1;
	new_node->f1=0;
	new_node->f2=0;
	new_node->weight=0.0; /*weight=f1*((N/c)-L1)*/
	new_node->next=head->next;
	head->next=new_node; 
}
/*this function pushes nodes in the list and is used in cost models: 1,3,5*/
void 
push_2(int bat_id,FrequencyNode* head,int N,int L1)
{
	FrequencyNode* new_node;
	new_node=(FrequencyNode *) GDKmalloc(sizeof(FrequencyNode));
	new_node->bid=bat_id;
	new_node->c=1;
	new_node->f1=0;
	new_node->f2=0;
	new_node->weight=N-L1;
	new_node->next=head->next;
	head->next=new_node; 
}

FrequencyNode*
pop(FrequencyNode* head)
{
	FrequencyNode* dummy;
	dummy=head->next;
	head->next=head->next->next;
	GDKfree(dummy);
	return head;
}

void 
printFrequencyStruct(FrequencyNode* head)
{
	FrequencyNode* temp;
	double d;
	FILE *ofp1;
	char outputFilename1[] = "/export/scratch2/petraki/experiments_1st_paper/experiments/strategies/distance/out.txt";
	ofp1 = fopen(outputFilename1,"a");

	if (ofp1 == NULL) {
  		fprintf(stderr, "Can't open output file!\n");
  		exit(1);
	}
	temp=head;
	while(temp != NULL)
	{
		/*fprintf(stderr,"Bid=%d c=%d f1=%d f2=%d W=%lf  \n",temp->bid,temp->c,temp->f1,temp->f2,temp->weight);*/
		if(temp->weight>0)
		{
			d=(100000000.0/temp->c) - 8000.0;
			fprintf(ofp1,"%d\t%lf\n",temp->bid,d);
			
		}
		temp=temp->next;
	}
	fclose(ofp1);


}

FrequencyNode* 
searchBAT(FrequencyNode* head,int bat_id)
{
	FrequencyNode* temp;
	temp=head;
	while((temp->bid != bat_id))
	{
		temp=temp->next;
	}
	return temp;
}
/*this function returns the maximum weight from the list and is used for all the cost models*/
FrequencyNode*
findMax(FrequencyNode* head)
{
	FrequencyNode* temp=NULL;
	FrequencyNode* ret_node=NULL;
	double tmpW;
	//int bat;
	temp=head;
	tmpW=temp->weight;
	//bat=temp->bid;
	while(temp!=NULL)
	{
		if(temp->weight >= tmpW)
		{
			tmpW=temp->weight;
			//bat=temp->bid;
			ret_node=temp;
		}
		temp=temp->next;
	}
	return ret_node;
}

/*this function returns a random node from the list with positive weight*/
FrequencyNode*
pickRandom(FrequencyNode* head)
{
	FrequencyNode* temp;
	FrequencyNode* ret_node=NULL;
	int *batids; /*it stores the number of the node in the list*/
	int random_position;
        int n=0;
	int k=0;
	temp=head->next;
	while(temp!=NULL)
	{
		if(temp->weight > 0)
		{
			n++;			
		}
		temp=temp->next;
	}
	if (n!=0)
	{
		batids=(int *) GDKmalloc(n*sizeof(int));
		n=0;
		temp=head->next;
		while(temp!=NULL)
		{
			if(temp->weight > 0)
			{
				batids[k]=n;
				k++;			
			}
			temp=temp->next;
			n++;
		}
		random_position=rand()%k;
		n=0;
		temp=head->next;
		while(temp!=NULL)
		{
			if(n==batids[random_position])
			{
				ret_node=temp;
			}
			temp=temp->next;
			n++;
		}	
	}
	return ret_node;
}

/*The following function updates the weights in the list*/
/*This cost model takes into consideration only the distance from the optimal index.*/
/*The initial weights are initialized to 0 (ZERO)*/
double
changeWeight_1(FrequencyNode* node,int N,int L1)
{
	int p; /*number of pieces in the index*/
	double Sp; /*average size of each piece*/
	double d; /*distance from optimal piece(L1)*/
	p = node->c;
	Sp =((double)N)/p;	
	d = Sp - L1;
	if (node->f1==0)
	{
		node->weight = 0.0;
	}
	else
	{
		node->weight = d;
	}

	fprintf(stderr,"bid=%d f1=%d f2=%d p=%d Sp=%lf d=%lf W=%lf\n",node->bid,node->f1,node->f2,p,Sp,d,node->weight);
	return node->weight;
}

/*The following function updates the weights in the list*/
/*This cost model takes into consideration both the frequency of the queries that use the index and the distance from the optimal index.*/
/*The initial weights are initialized to 0 (ZERO)*/
double
changeWeight_2(FrequencyNode* node,int N,int L1)
{
	int p; /*number of pieces in the index*/
	double Sp; /*average size of each piece*/
	double d; /*distance from optimal piece(L1)*/
	p = node->c;
	Sp =((double)N)/p;	
	d = Sp - L1;
	if (node->f1==0)
	{
		node->weight = 0;
	}
	else
	{
		node->weight = (double)(node->f1) * d;
	}
	/*fprintf(stderr,"bid=%d f1=%d f2=%d p=%d Sp=%lf d=%lf W=%lf\n",node->bid,node->f1,node->f2,p,Sp,d,node->weight);*/
	return node->weight;
}

/*The following function updates the weights in the list*/
/*This cost model takes into consideration the frequency of the queries that use the index,*/
/* the frequency of the queries that "hit" the range in the index and the distance from the optimal index.*/
/*The initial weights are initialized to 0 (ZERO)*/
double
changeWeight_3(FrequencyNode* node,int N,int L1)
{
	int p; /*number of pieces in the index*/
	double Sp; /*average size of each piece*/
	double d; /*distance from optimal piece(L1)*/
	p = node->c;
	Sp =((double)N)/p;	
	d = Sp - L1;
	if (node->f1==0)
	{
		node->weight = 0;
	}
	else
	{
		node->weight = ((double)(node->f1)-(double)(node->f2)) * d;
	}
	/*fprintf(stderr,"bid=%d f1=%d f2=%d p=%d Sp=%lf d=%lf W=%lf\n",node->bid,node->f1,node->f2,p,Sp,d,node->weight);*/
	return node->weight;

}

void
deleteNode(FrequencyNode* head,int bat_id)
{
	FrequencyNode* temp;
	temp=head;
	while((temp->next != NULL))
	{
		if(temp->next->bid == bat_id)
		{
			temp->next=temp->next->next;	
			break;
		}
		temp=temp->next;
	}

}

str 
CRKinitFrequencyStruct(int *vid,int *bid)
{
	FrequencyNode *fs = getFrequencyStruct('A');
	push(*bid,fs);
	*vid = 0;
	return MAL_SUCCEED;
}


/*this function initializes the list in the first & second experiment(1st & 2nd cost model)*/
str 
CRKinitFrequencyStruct_2(int *vid,int *bid,int* N,int* L1)
{
	FrequencyNode *fs = getFrequencyStruct('A');
	push_2(*bid,fs,*N,*L1);
	*vid = 0;
	return MAL_SUCCEED;
}


/*this function changes the frequencies into 0 in the end of the idle time interval*/
str
CRKzeroFrequency(int *vid)
{
        FrequencyNode *fs = getFrequencyStruct('A');
        FrequencyNode* temp;
	temp=fs;
        while(temp != NULL)
        {
		temp->f1=0;
		temp->f2=0;
                temp=temp->next;
        }
	*vid = 0;
        return MAL_SUCCEED;
}

/*This function is used during idle time for all the cost models*/
str
CRKrandomCrack(int *ret)
{
	int bid=0;
	FrequencyNode* max_node;
	BAT *b;
	int low=0, hgh=0;
	int *t;
	int temp=0;
	oid posl,posh,p;
	FILE *ofp1;
	int dummy = 0;
	char outputFilename1[] = "/export/scratch2/petraki/experiments_1st_paper/experiments/strategies/change_parameters_abcde/a800b50c50d50e50/idle_queries_2";
	
	bit inclusive=TRUE;
	FrequencyNode *fs = getFrequencyStruct('A');	
	isIdleQuery=1;
	ofp1 = fopen(outputFilename1,"a");
	(void) ret;
	max_node=findMax(fs);
	if(max_node!=NULL && max_node->weight > 0)
	{
		bid=max_node->bid;
		b=BATdescriptor(bid);
		t=(int*)Tloc(b,BUNfirst(b));
		posl=BUNfirst(b);
		posh=BUNlast(b) - 1;
		p=(rand()%(posh-posl+1))+posl;
		low=t[p];
		p=(rand()%(posh-posl+1))+posl;
		hgh=t[p];
		if(hgh < low)
		{
			temp=low;
			low=hgh;
			hgh=temp;
		}
	/*fprintf(stderr,"posl = "OIDFMT" posh = "OIDFMT" low = %d hgh = %d inclusive = %d", posl,posh,low,hgh,inclusive );*/
		CRKselectholBounds_int(&dummy, &bid, &low, &hgh, &inclusive, &inclusive);
		fprintf(ofp1,"%d\n",max_node->bid);
		
	}
	
	fclose(ofp1);

	/*printFrequencyStruct(fs);*/
	isIdleQuery=0;


	return MAL_SUCCEED;
}

/*This function is used during idle time for all the cost models*/
str
CRKrandomCrackST(int *ret)
{
        int bid=0;
        FrequencyNode* max_node;
        BAT *b;
        int low=0, hgh=0;
        int *t;
        int temp=0;
        oid posl,posh,p;

        bit inclusive=TRUE;
        FrequencyNode *fs = getFrequencyStruct('A');
        isIdleQuery=1;
        max_node=findMax(fs);
        if(max_node!=NULL && max_node->weight > 0)
	{
                bid=max_node->bid;
                b=BATdescriptor(bid);
                t=(int*)Tloc(b,BUNfirst(b));
                posl=BUNfirst(b);
                posh=BUNlast(b) - 1;
                p=(rand()%(posh-posl+1))+posl;
                low=t[p];
                p=(rand()%(posh-posl+1))+posl;
                hgh=t[p];
                if(hgh < low)
                {
                        temp=low;
                        low=hgh;
                        hgh=temp;
                }
                CRKselectholstBounds_int(ret, &bid, &low, &hgh, &inclusive, &inclusive);
	 }

        isIdleQuery=0;

        *ret = 0;
        return MAL_SUCCEED;
}

