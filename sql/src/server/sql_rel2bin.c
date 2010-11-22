/*
 * The contents of this file are subject to the MonetDB Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://monetdb.cwi.nl/Legal/MonetDBLicense-1.1.html
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
 * Copyright August 2008-2010 MonetDB B.V.
 * All Rights Reserved.
 */


#include "sql_config.h"
#include "sql_rel2bin.h"
#include "sql_env.h"
#include <stdio.h>

static stmt * head_column(stmt *st);

static stmt *
tail_column(stmt *st)
{
	switch (st->type) {
	case st_join:
	case st_outerjoin:
	case st_reorder:
		return tail_column(st->op2.stval);

	case st_join2:
	case st_joinN:
		return tail_column(st->op2.stval);
	case st_releqjoin:
		return tail_column(st->op2.lval->h->data);
	case st_reljoin:
		return tail_column(st->op2.lval->t->data);

	case st_select:
	case st_select2:
	case st_selectN:
	case st_uselect:
	case st_uselect2:
	case st_uselectN:
	case st_semijoin:
	case st_limit:

	case st_diff:
	case st_union:

	case st_append:

	case st_unique:
	case st_aggr:
	case st_order:

	case st_alias:

	case st_convert:

		return tail_column(st->op1.stval);

	case st_table_clear:
	case st_column:
	case st_bat:
		return st;

	case st_mirror:
	case st_reverse:
		return head_column(st->op1.stval);
	case st_list:
		return tail_column(st->op1.lval->h->data);

		/* required for shrink_select_ranges() in sql_rel2bin.mx */
	case st_rs_column:
	case st_idxbat:

		/* required for eliminate_semijoin() in sql_rel2bin.mx */
	case st_relselect:

		/* some statements have no column coming from any basetable */
	case st_atom:
	case st_var:
	case st_mark:
	case st_gen_group:
	case st_derive:
	case st_group_ext:
	case st_group:
	case st_basetable:	/* a table is not a column */
	case st_table:		/* a table is not a column */
	case st_temp:
	case st_single:
	case st_unop:
	case st_binop:
	case st_Nop:
	case st_const:
		return NULL;

	default:
		fprintf(stderr, "missing tail column %u: %s\n", st->type, st_type2string(st->type));
		assert(0);
		return NULL;
	}
}

static stmt *
head_column(stmt *st)
{
	switch (st->type) {
	case st_const:
	case st_mark:
	case st_gen_group:
	case st_mirror:

	case st_select:
	case st_select2:
	case st_selectN:
	case st_uselect:
	case st_uselect2:
	case st_uselectN:
	case st_semijoin:
	case st_limit:

	case st_join:
	case st_join2:
	case st_joinN:
	case st_outerjoin:
	case st_diff:
	case st_union:

	case st_append:

	case st_group_ext:
	case st_group:
	case st_unique:
	case st_unop:
	case st_binop:
	case st_Nop:
	case st_aggr:
	case st_order:

	case st_alias:

	case st_convert:

		return head_column(st->op1.stval);

	case st_relselect:
	case st_releqjoin:
		return head_column(st->op1.lval->h->data);
	case st_reljoin:
		return head_column(st->op2.lval->h->data);

	case st_table_clear:
	case st_column:
	case st_bat:
		return st;

	case st_reverse:
		return tail_column(st->op1.stval);

	case st_reorder:
	case st_derive:
		return tail_column(st->op2.stval);

	case st_list:
		return head_column(st->op1.lval->h->data);

		/* required for eliminate_semijoin() in sql_rel2bin.mx */
		/* st_temp has no head column coming from any basetable */
	case st_atom:
	case st_var:
	case st_basetable:
	case st_table:
	case st_temp:
	case st_single:
	case st_idxbat:

	case st_rs_column:
		return NULL;

		/* stmts without head column which also are not expected */
	case st_none:

	case st_dbat:

	case st_append_col:
	case st_update_col:
	case st_append_idx:
	case st_update_idx:
	case st_delete:

	case st_ordered:
	case st_output:
	case st_affected_rows:

	case st_export:
	case st_exception:
	case st_trans:
	case st_catalog:

	case st_while:
	case st_if:
	case st_return:
	case st_assign:
	case st_connection:
		fprintf(stderr, "missing head column %u: %s\n", st->type, st_type2string(st->type));
		assert(0);
		return NULL;
	}
	return NULL;
}

/* basecolum is used by eliminate_semijoins and shrink_ranges to reduce the
 * number of semijoins and selects.
 * There we need too know which columns come from the same basecolumn.
 */
sql_column *
basecolumn(stmt *st)
{
	if (!st)
		return NULL;	/* required for shrink_select_ranges() and eliminate_semijoin() */
	switch (st->type) {
	case st_reverse:
		return basecolumn(head_column(st->op1.stval));

	case st_bat:
		return st->op1.cval;

	/* relational column (result of view etc) has no direct base column */
	case st_column:
		return NULL;

	default:
		return basecolumn(tail_column(st));
	}
}


static int
cmp_sel2(stmt *sel, st_type *tpe)
{
	(void) tpe;		/* Stefan: unsed, but required for list_select() / type fcmp() */
	if (sel->type == st_select2 || sel->type == st_uselect2) {
		/* for now we don't split anti-selects */
		if ((sel->flag&ANTI) == 0)
			return 0;
	}
	return -1;
}

static int
cmp_sel_oneCol(stmt *sel)
{
	int rtrn = -1;

	if (sel->type >= st_select && sel->type <= st_uselect2) {
		if (sel->op2.stval->nrcols == 0) {
			rtrn = 0;
		}
#ifndef NDEBUG
/*
	} else {
		if (sel->type == st_reverse) {
			printf("= TODO: sql_rel2bin: shrink_select_ranges: handle %s(%s)!\n", st_type2string(sel->type), st_type2string(sel->op1.stval->type));
		} else {
			printf("= TODO: sql_rel2bin: shrink_select_ranges: handle %s!\n", st_type2string(sel->type));
		}
*/
#endif
	}
	return rtrn;
}

static int
cmp_sel_twoCol(stmt *sel)
{
	return !cmp_sel_oneCol(sel);
}

static int
cmp_sel_hasNoBasecol(stmt *sel)
{
	int rtrn = -1;

	if (basecolumn(sel) == NULL) {
		rtrn = 0;
	}
	return rtrn;
}

static int
cmp_sel_hasBasecol(stmt *sel)
{
	int rtrn = -1;

	if (basecolumn(sel) != NULL) {
		rtrn = 0;
	}
	return rtrn;
}

static int
cmp_sel_basecol(stmt *sel, stmt *key)
{
	if (basecolumn(key) == basecolumn(sel)) {
		return 0;
	}
	return -1;
}

static int
cmp_sel_val(stmt *sel, stmt *key)
{
	if (sel->op2.stval == key->op2.stval) {
		return 0;
	}
	return -1;
}

static int
cmp_sel_comp_type(stmt *sel, comp_type *flg)
{
	if ((sel->type == st_select || sel->type == st_uselect) && (comp_type) sel->flag == *flg) {
		return 0;
	}
	return -1;
}

static stmt *
stmt_min(stmt *x, stmt *y)
{
	sql_subtype *t;
	sql_subfunc *f;

	assert(x->nrcols == 0);
	assert(y->nrcols == 0);
	t = tail_type(x);
	assert(t);
/*	assert(t == tail_type(y));	*/
	f = sql_bind_func_result(NULL, "sql_min", t, t, t);
	assert(f);
	return stmt_binop(x, y, f);
}

static stmt *
stmt_max(stmt *x, stmt *y)
{
	sql_subtype *t;
	sql_subfunc *f;

	assert(x->nrcols == 0);
	assert(y->nrcols == 0);
	t = tail_type(x);
	assert(t);
/*	assert(t == tail_type(y));	*/
	f = sql_bind_func_result(NULL, "sql_max", t, t, t);
	assert(f);
	return stmt_binop(x, y, f);
}

list *
shrink_select_ranges(mvc *sql, list *oldsels)
{
	/* find minimal ranges for selects per column on one table */
	sql_subfunc *min = NULL;
	sql_subfunc *max = NULL;

	list *newsels, *haveNoBasecol, *haveBasecol, *basecols, *oneColSels, *twoColSels;
	node *bc;

	newsels = list_create((fdestroy) &stmt_destroy);

	/* we skip selects that involve two columns, e.g., R.a < R.b, here */
	twoColSels = list_select(oldsels, (void *) 1L, (fcmp) &cmp_sel_twoCol, (fdup) &stmt_dup);
	oneColSels = list_select(oldsels, (void *) 1L, (fcmp) &cmp_sel_oneCol, (fdup) &stmt_dup);
	assert(list_length(twoColSels) + list_length(oneColSels) == list_length(oldsels));
	list_destroy(oldsels);

	/* some statments (e.g., st_idxbat when checking key constraints during inserts)
	   don't seem to have a basecolumn, hence, we skip them, here */
	haveNoBasecol = list_select(oneColSels, (void *) 1L, (fcmp) &cmp_sel_hasNoBasecol, (fdup) &stmt_dup);
	haveBasecol = list_select(oneColSels, (void *) 1L, (fcmp) &cmp_sel_hasBasecol, (fdup) &stmt_dup);
	assert(list_length(haveNoBasecol) + list_length(haveBasecol) == list_length(oneColSels));
	list_destroy(oneColSels);

	basecols = list_distinct(haveBasecol, (fcmp) &cmp_sel_basecol, (fdup) &stmt_dup);
	for (bc = basecols->h; bc; bc = bc->next) {
		list *colsels = list_select(haveBasecol, bc->data, (fcmp) &cmp_sel_basecol, (fdup) &stmt_dup);
		sql_subtype *tt = tail_type(((stmt *) (colsels->h->data))->op2.stval);
		sql_subtype *tt2 = tt;

		if (list_length(colsels) > 1)
			tt2 = tail_type(((stmt *) (colsels->h->next->data))->op2.stval);

		assert(tt);
		if (list_length(colsels) == 1) {
			stmt *s = stmt_dup(colsels->h->data);
			/* only one select on this column; simply keep it. */
			/* we prefer range selects over simple selects */
			if (s->type == st_uselect2 || s->type == st_select2)
				list_prepend(newsels, s);
			else
				list_append(newsels, s);
		} else if (tt2 != tt ||  tt->type->localtype == TYPE_str || !(min = sql_bind_func_result(sql->session->schema, "sql_min", tt, tt, tt)) || !(max = sql_bind_func_result(sql->session->schema, "sql_max", tt, tt, tt))) {
			/* no "min" and/or "max" available on this data type, hence, we cannot apply the following "tricks" */
			list_merge(newsels, colsels, (fdup) &stmt_dup);
		} else {
			list *sels2, *sels1[cmp_all];
			stmt *bound[4] = { NULL, NULL, NULL, NULL };
			stmt *col[4] = { NULL, NULL, NULL, NULL };
			comp_type ct;
			node *n;
			int flg, len = 0;

			sql_subfunc_destroy(min);
			sql_subfunc_destroy(max);

			/* separate all single-range, equal, notequal, notlike, & like selects and eliminate duplicates
			 * (notequal, notlike, & like selects are saved and re-added at the end) */
			for (ct = cmp_gt; ct < cmp_all; ct++) {
				list *l = list_select(colsels, (void *) &ct, (fcmp) &cmp_sel_comp_type, (fdup) &stmt_dup);

				len += list_length(l);
				sels1[ct] = list_distinct(l, (fcmp) &cmp_sel_val, (fdup) &stmt_dup);
				list_destroy(l);
			}
			/* separate all double-sided range selects */
			sels2 = list_select(colsels, (void *) 1L, (fcmp) &cmp_sel2, (fdup) &stmt_dup);
			len += list_length(sels2);

			/* make sure we didn't miss anything */
			assert(len == list_length(colsels));

			/* split-up each double-sided range select in two single-sided ones
			 * (x<[=]a<[=]y  =>  a>[=]x && a<[=]y) to find the minimal ranges below */
			for (n = sels2->h; n; n = n->next) {
				stmt *sl, *sr, *s = n->data;
				comp_type cl = cmp_all, cr = cmp_all;	/* invalid values; just to pacify compilers */

				switch (s->flag) {
				case 0:
					cl = cmp_gt;
					cr = cmp_lt;
					break;
				case 1:
					cl = cmp_gt;
					cr = cmp_lte;
					break;
				case 2:
					cl = cmp_gte;
					cr = cmp_lt;
					break;
				case 3:
					cl = cmp_gte;
					cr = cmp_lte;
					break;
				default:
					assert(0);
				}
				sl = stmt_uselect(stmt_dup(s->op1.stval), stmt_dup(s->op2.stval), cl);
				sr = stmt_uselect(stmt_dup(s->op1.stval), stmt_dup(s->op3.stval), cr);
				list_append(sels1[cl], sl);
				list_append(sels1[cr], sr);
			}
			list_destroy(sels2);

			/* split-up each equal (point) select in two single-sided ones
			 * (a=x  =>  a>=x && a<=x) to find the minimal ranges below */
			/*
			 * in the "worst case", this gets later re-combined to
			 *      x<=a<=x   which is identical to   a=x
			 *
			 * in case there are other equal (point) or range selects,
			 * this improves optimization, especially empty selections
			 * are detected instantly, e.g.:
			 *      a=x && a=y
			 *  =>  a>=x && a<=x && a>=y && a<=y
			 *  =>  a>=max(x,y) && a<=min(x,y)
			 *  =>  max(x,y)<=a<=min(x,y)
			 * or
			 *      a=x && a<=y
			 *  =>  a>=x && a<=x && a<=y
			 *  =>  a>=x && a<=min(x,y)
			 *  =>  x<=a<=min(x,y)
			 *
			 * in both cases we end up with just a single select
			 * instead of two selects plus a semijoin
			 */
			for (n = sels1[cmp_equal]->h; n; n = n->next) {
				stmt *sl, *sr, *s = n->data;

				sl = stmt_uselect(stmt_dup(s->op1.stval), stmt_dup(s->op2.stval), cmp_gte);
				sr = stmt_uselect(stmt_dup(s->op1.stval), stmt_dup(s->op2.stval), cmp_lte);
				list_append(sels1[cmp_gte], sl);
				list_append(sels1[cmp_lte], sr);
			}
			list_destroy(sels1[cmp_equal]);

			/* minimize all single-sided range selects */
			/*
			 * while
			 *      1) a< x && a< y  =>  a <  min(x,y)
			 *      2) a<=x && a<=y  =>  a <= min(x,y)
			 *      3) a> x && a> y  =>  a >  max(x,y)
			 *      4) a>=x && a>=y  =>  a >= max(x,y)
			 * we cannot do similar simple stuff for
			 *      5) a < x && a <= y
			 * and
			 *      6) a > x && a >= y
			 * TODO:
			 * for the latter two cases, produce code like
			 *      5: if (x<=y) { a < x } else { a <= y }
			 *      6: if (x>=y) { a > x } else { a >= y }
			 */
			for (ct = cmp_gt; ct <= cmp_lt; ct++) {
				if (list_length(sels1[ct]) > 0) {
					col[ct] = stmt_dup(((stmt *) (sels1[ct]->h->data))->op1.stval);
				}
				if (list_length(sels1[ct]) == 1) {
					bound[ct] = stmt_dup(((stmt *) (sels1[ct]->h->data))->op2.stval);
				}
				if (list_length(sels1[ct]) > 1) {
					list *bnds = list_create((fdestroy) &stmt_destroy);

					for (n = sels1[ct]->h; n; n = n->next) {
						list_append(bnds, stmt_dup(((stmt *) (n->data))->op2.stval));
					}
					if (ct <= cmp_gte)
						bound[ct] = (stmt *) list_reduce(bnds, (freduce) &stmt_max, (fdup) &stmt_dup);
					else
						bound[ct] = (stmt *) list_reduce(bnds, (freduce) &stmt_min, (fdup) &stmt_dup);
					list_destroy(bnds);
				}
				list_destroy(sels1[ct]);
			}

			/* pairwise (re-)combine single-sided range selects to double-sided range selects */
			/*
			 *      0) a> x && a< y  =>  x< a< y
			 *      1) a>=x && a< y  =>  x<=a< y
			 *      2) a> x && a<=y  =>  x< a<=y
			 *      3) a>=x && a<=y  =>  x<=a<=y
			 */
			for (flg = 0; flg <= 3; flg++) {
				comp_type cl = cmp_all, cr = cmp_all;	/* invalid values; just to pacify compilers */

				switch (flg) {
				case 0:
					cl = cmp_gt;
					cr = cmp_lt;
					break;
				case 1:
					cl = cmp_gte;
					cr = cmp_lt;
					break;
				case 2:
					cl = cmp_gt;
					cr = cmp_lte;
					break;
				case 3:
					cl = cmp_gte;
					cr = cmp_lte;
					break;
				default:
					assert(0);
				}
				if (bound[cl] && bound[cr]) {
					list_prepend(newsels, stmt_uselect2(stmt_dup(col[cl]), bound[cl], bound[cr], flg));
					bound[cl] = bound[cr] = NULL;
				}
			}

			/* collect remaining single-sided range selects that haven't found a partner */
			for (ct = cmp_gt; ct <= cmp_lt; ct++) {
				if (bound[ct]) {
					list_append(newsels, stmt_uselect(stmt_dup(col[ct]), bound[ct], ct));
				}
				if (col[ct]) {
					stmt_destroy(col[ct]);
				}
			}

			/* finally collect all saved like, notlike, and notequal selects */
			for (ct = cmp_ilike; ct >= cmp_notequal; ct--) {
				list_merge(newsels, sels1[ct], (fdup)&stmt_dup);
				list_destroy(sels1[ct]);
			}
		}
		list_destroy(colsels);
	}
	/* re-add the skipped statements without basecolumn */
	list_merge(newsels, haveNoBasecol, (fdup) &stmt_dup);
	/* re-add the skipped two-column selects */
	list_merge(newsels, twoColSels, (fdup) &stmt_dup);

	list_destroy(twoColSels);
	list_destroy(haveNoBasecol);
	list_destroy(haveBasecol);
	list_destroy(basecols);

	return newsels;
}

static int 
sel_find_keycolumn( stmt *s, sql_kc *kc)
{
	s = s->op1.stval;
	if (s && s->type == st_bat && s->op1.cval == kc->c)
		return 0;
	return -1;
}

static stmt *
select_hash_key( mvc *sql, sql_idx *i, list *l ) 
{
	sql_subtype *it, *wrd;
	stmt *h = NULL;
	stmt *bits = stmt_atom_int(1 + ((sizeof(wrd)*8)-1)/(list_length(l)+1));
	node *icn;

	it = sql_bind_localtype("int");
	wrd = sql_bind_localtype("wrd");
        for(icn = i->columns->h; icn; icn = icn->next) {
		sql_kc *kc = icn->data;
		node *n = list_find(l, kc, (fcmp)&sel_find_keycolumn);
		stmt *s;

		assert(n);

		s = stmt_dup(n->data);
		if (h) {
			sql_subfunc *xor = sql_bind_func_result3(sql->session->schema, "rotate_xor_hash", wrd, it, tail_type(s), wrd);

			h = stmt_Nop(stmt_list( list_append( list_append(
				list_append(create_stmt_list(), h), 
				stmt_dup(bits)), 
				stmt_dup(s->op2.stval))), 
				xor);
		} else {
			sql_subfunc *hf = sql_bind_func_result(sql->session->schema, "hash", tail_type(s), NULL, wrd);
			h = stmt_unop(stmt_dup(s->op2.stval), hf);
		}
	}
	stmt_destroy(bits);
	return stmt_uselect(stmt_idxbat(i, RDONLY), h, cmp_equal);
}

static stmt *
join_hash_key( mvc *sql, list *l ) 
{
	node *m;
	sql_subtype *it, *wrd;
	stmt *h = NULL;
	stmt *bits = stmt_atom_int(1 + ((sizeof(wrd)*8)-1)/(list_length(l)+1));
	stmt *o = NULL;

	it = sql_bind_localtype("int");
	wrd = sql_bind_localtype("wrd");
	for (m = l->h; m; m = m->next) {
		stmt *s = stmt_dup(m->data);

		if (h) {
			sql_subfunc *xor = sql_bind_func_result3(sql->session->schema, "rotate_xor_hash", wrd, it, tail_type(s), wrd);

			h = stmt_Nop(stmt_list( list_append( list_append(
				list_append(create_stmt_list(), h), 
				stmt_dup(bits)), 
				stmt_project(stmt_dup(o), s ))), 
				xor);
		} else {
			sql_subfunc *hf = sql_bind_func_result(sql->session->schema, "hash", tail_type(s), NULL, wrd);
			o = stmt_mark(stmt_reverse(stmt_dup(s)), 40); 
			h = stmt_unop(stmt_mark(s, 40), hf);
		}
	}
	stmt_destroy(bits);
	return stmt_join(stmt_reverse(o), h, cmp_equal);
}


/* TODO find out if the columns have an (hash) index */
static stmt *
releqjoin( mvc *sql, list *l1, list *l2 )
{
	node *n1, *n2;
	stmt *l, *r, *res;

	if (list_length(l1) <= 1) {
		l = stmt_dup(l1->h->data);
		r = stmt_dup(l2->h->data);
		return stmt_join(l, stmt_reverse(r), cmp_equal);
	}
	l = join_hash_key(sql, l1);
	r = join_hash_key(sql, l2);
	res = stmt_join(l, stmt_reverse(r), cmp_equal);
	l = stmt_mark(stmt_reverse(res), 4);
	r = stmt_mark(stmt_dup(res), 4);
	for (n1 = l1->h, n2 = l2->h; n1 && n2; n1 = n1->next, n2 = n2->next) {
		stmt *ld = stmt_dup(n1->data);
		stmt *rd = stmt_dup(n2->data);
		stmt *le = stmt_project(l, ld );
		stmt *re = stmt_project(r, rd );
		/* intentional both tail_type's of le (as re sometimes is a
		   find for bulk loading */
		sql_subfunc *f=sql_bind_func(sql->session->schema, "=", tail_type(le), tail_type(le));

		stmt * cmp;

		assert(f);

		/* TODO use uselect only */
		cmp = stmt_binop(le, re, f);

		cmp = stmt_uselect(cmp, stmt_bool(1), cmp_equal);

		/* TODO the semijoin may break the order!! */
		l = stmt_semijoin(stmt_dup(l), stmt_dup(cmp));
		r = stmt_semijoin(stmt_dup(r), cmp);
	}
	res = stmt_join(stmt_reverse(l), r, cmp_equal);
	return res;
}

static stmt *
_project( stmt *o, stmt *v )
{
	if (v->nrcols == 0)
		return stmt_dup(v);
	return stmt_project(stmt_dup(o), stmt_dup(v));
}

static stmt *
reljoin( mvc *sql, stmt *rj, list *l2 )
{
	node *n = l2->h;
	stmt *l, *r, *res;

	(void)sql;
	if (!rj && list_length(l2) == 1) 
		return stmt_dup(l2->h->data);

	if (rj) {
		l = stmt_mark(stmt_reverse(stmt_dup(rj)), 50);
		r = stmt_mark(stmt_dup(rj), 50);
		stmt_destroy(rj);
	} else {
		res = stmt_dup(n->data);
		l = stmt_mark(stmt_reverse(res), 4);
		r = stmt_mark(stmt_dup(res), 4);
		n = n->next;
	}
	/* TODO also handle joinN */
	for (; n; n = n->next) {
		stmt *j = n->data;
		stmt *ld = stmt_dup(j->op1.stval);
		stmt *o2 = stmt_dup(j->op2.stval);
		stmt *rd = (j->type == st_join)?stmt_reverse(o2):o2;

		if (j->type == st_joinN) {
			stmt *cmp;
			list *ol,*nl = create_stmt_list();
			node *m;

			ol = j->op1.stval->op1.lval;
			for (m = ol->h; m; m = m->next) 
				list_append(nl, _project(l, m->data));
			ol = j->op2.stval->op1.lval;
			for (m = ol->h; m; m = m->next) 
				list_append(nl, _project(r, m->data));
			/* find function */
			cmp = stmt_uselect( stmt_Nop( stmt_list(nl), j->op4.funcval), stmt_bool(1), cmp_equal);
			/* TODO semijoin may break order */
			l = stmt_semijoin(stmt_dup(l), stmt_dup(cmp));
			r = stmt_semijoin(stmt_dup(r), cmp);
		} else if (j->type == st_join2) {
			stmt *le = stmt_project(l, ld );
			stmt *re = stmt_project(r, rd );
			comp_type c1 = j->flag&2 ? cmp_gte : cmp_gt;
			comp_type c2 = j->flag&1 ? cmp_lte : cmp_lt;
			stmt *r2 = stmt_project(stmt_dup(r), stmt_dup(j->op3.stval));
			stmt *cmp1 = stmt_uselect(le, re, c1);
			stmt *cmp2 = stmt_uselect(stmt_dup(le), r2, c2);
		

			stmt *cmp = stmt_semijoin(cmp1, cmp2);
			/* use a single uselect2 ? */
		/*
			stmt *cmp = stmt_uselect2(le, re, r2, (comp_type)j->flag);
		*/

			/* TODO semijoin may break order */
			l = stmt_semijoin(stmt_dup(l), stmt_dup(cmp));
			r = stmt_semijoin(stmt_dup(r), cmp);
		} else {
			stmt *le = stmt_project(l, ld );
			stmt *re = stmt_project(r, rd );
			/* TODO force scan select ? */
			stmt *cmp = stmt_uselect(le, re, (comp_type)j->flag);

			/* TODO semijoin may break order, 
				ie maybe do a mirror + project */
			l = stmt_semijoin(stmt_dup(l), stmt_dup(cmp));
			r = stmt_semijoin(stmt_dup(r), cmp);
		}
	}
	res = stmt_join(stmt_reverse(l), r, cmp_equal);
	return res;
}

int
find_unique( stmt *s, void *v)
{
	stmt *c = head_column(s);

	(void)v;
	if (c && c->type == st_bat && c->op1.cval->unique == 1)
		return 0;
	return -1;
}

/* push the semijoin of (select,s) through the select statement (select) */
stmt *
push_semijoin( stmt *select, stmt *s )
{
	if (select->type == st_list){ 
		list *l = create_stmt_list();
		node *n;

		for(n = select->op1.lval->h; n; n = n->next) {
			stmt *a = stmt_dup(n->data), *n;

			if (a->nrcols) {
				n = push_semijoin( a, stmt_dup(s));
				if (n == a) {
					list_destroy(l);
					stmt_destroy(s);
					return select;
				}
				list_append(l, n);
			} else {
				list_append(l, a);
			}
		}
		stmt_destroy(select);
		stmt_destroy(s);
		return stmt_list(l);
	}
	if (select->type == st_convert){ 
		sql_subtype f = select->op3.typeval;
		sql_subtype t = select->op4.typeval;
		stmt *op1 = stmt_dup(select->op1.stval);

		op1 = push_semijoin(op1, s);
		stmt_destroy(select);
		return stmt_convert(op1, &f, &t);
	}
	if (select->type == st_unop){ 
		stmt *op1 = stmt_dup(select->op1.stval);

		op1 = push_semijoin(op1, s);
		op1 = stmt_unop(op1, sql_dup_func(select->op4.funcval));
		stmt_destroy(select);
		return op1;
	}
	if (select->type == st_binop) {
		stmt *op1 = stmt_dup(select->op1.stval);
		stmt *op2 = stmt_dup(select->op2.stval);
		if (op1->nrcols) 
			op1 = push_semijoin(op1, stmt_dup(s));
		if (op2->nrcols) 
			op2 = push_semijoin(op2, stmt_dup(s));
		stmt_destroy(select);
		stmt_destroy(s);
		return stmt_binop(op1, op2, sql_dup_func(select->op4.funcval));
	}
	if (select->type == st_Nop) {
		stmt *ops = stmt_dup(select->op1.stval);
		if (ops->nrcols) 
			ops = push_semijoin(ops, stmt_dup(s));
		stmt_destroy(select);
		stmt_destroy(s);
		return stmt_Nop(ops, sql_dup_func(select->op4.funcval));
	}
	if (select->type == st_diff) {
		stmt *op1 = stmt_dup(select->op1.stval);
		stmt *op2 = stmt_dup(select->op2.stval);

		op1 = push_semijoin(op1, s);
		stmt_destroy(select);
		return stmt_diff(op1, op2);
	}
	if (select->type == st_union) {
		stmt *op1 = stmt_dup(select->op1.stval);
		stmt *op2 = stmt_dup(select->op2.stval);

		op1 = push_semijoin(op1, stmt_dup(s));
		op2 = push_semijoin(op2, s);
		stmt_destroy(select);
		return stmt_union(op1, op2);
	}

	/* semijoin(reverse(semijoin(reverse(x)),s) */
	if (select->type == st_reverse &&
	    select->op1.stval->type == st_semijoin &&
	    select->op1.stval->op1.stval->type == st_reverse) {
		stmt *op1 = stmt_dup( select->op1.stval->op1.stval->op1.stval);
		stmt *op2 = stmt_dup( select->op1.stval->op2.stval);

		op1 = push_semijoin( op1, s );
		stmt_destroy(select);
		return stmt_reverse(stmt_semijoin( stmt_reverse(op1), op2));
	}
	if (select->type != st_select2 && select->type != st_uselect2 &&
	    select->type != st_select && select->type != st_uselect)
		return stmt_semijoin(select, s);

	s = push_semijoin(stmt_dup(select->op1.stval), s);
	if (select->type == st_select2) {
		comp_type cmp = (comp_type)select->flag;
		stmt *op2 = stmt_dup( select->op2.stval);
		stmt *op3 = stmt_dup( select->op3.stval);

		stmt_destroy(select);
		return stmt_select2( s, op2, op3, cmp);
	}

	if (select->type == st_uselect2) {
		comp_type cmp = (comp_type)select->flag;
		stmt *op2 = stmt_dup( select->op2.stval);
		stmt *op3 = stmt_dup( select->op3.stval);

		stmt_destroy(select);
		return stmt_uselect2( s, op2, op3, cmp);
	}

	if (select->type == st_select) {
		comp_type cmp = (comp_type)select->flag;
		stmt *op2 = stmt_dup( select->op2.stval);

		if (cmp == cmp_like || cmp == cmp_notlike ||
		    cmp == cmp_ilike || cmp == cmp_notilike)
		{
			stmt *op3 = stmt_dup(select->op3.stval);

			stmt_destroy(select);
			return stmt_likeselect(s, op2, op3, cmp);
		} else {
			stmt_destroy(select);
			return stmt_select( s, op2, cmp);
		}
	}

	if (select->type == st_uselect) {
		comp_type cmp = (comp_type)select->flag;
		stmt *op2 = stmt_dup( select->op2.stval);

		stmt_destroy(select);
		return stmt_uselect( s, op2, cmp);
	}
	assert(0);
	return NULL;
}

static stmt *
push_select_stmt( mvc *c, list *l, stmt *sel )
{
	node *n;

	for (n = l->h; n; n = n->next) {
		stmt *s = rel2bin(c, n->data);

		sel = push_semijoin(s, sel);
	}
	return sel;
}

static list *
use_ukey( mvc *sql, list *l )
{
	sql_table *t;
	node *n;
	stmt *s;

	for( n = l->h; n; n = n->next) {
		s = n->data;

		/* we can only use hash indices for lookups, not for ranges */
		if (!(PSEL(s) && s->flag == cmp_equal))
			return l;
		/* we only want selects on base columns */
		if (s->op1.stval->type != st_bat)
			return l;
	}

	s = l->h->data;
	if (!s->h || s->h->type != st_basetable)
		return l;
	t = s->h->op1.tval;
	
	if (t->idxs.set) {
		int cnt = 0;
		node *in;
		sql_idx *i;
	   	for(in = t->idxs.set->h; in; in = in->next){
 			i = in->data;
			if (hash_index(i->type) && 
			    list_length(l) == list_length(i->columns)) {
				node *icn;

				cnt = 0;
              			for(icn = i->columns->h; icn; icn = icn->next, cnt++) {
					sql_kc *kc = icn->data;
					node *n = list_find(l, kc, (fcmp)&sel_find_keycolumn);
					if (!n)
						break;
				}
              			if (list_length(i->columns) == cnt) {
					break;
				}
				cnt = 0;
			}
		}
		if (cnt) { /* result can only be one row! */
			stmt *hash = select_hash_key(sql, i, l);
			list_prepend(l, hash);
		}
	}
	return l;
}

stmt *
rel2bin(mvc *c, stmt *s)
{
	assert(!(s->optimized < 2 && s->rewritten));
	if (s->optimized >= 2) {
		if (s->rewritten)
			return stmt_dup(s->rewritten);
		else
			return stmt_dup(s);
	}

	switch (s->type) {
		/* first just return those statements which we cannot optimize,
		 * such as schema manipulation, transaction managment, 
		 * and user authentication.
		 */
	case st_none:
	case st_connection:
	case st_rs_column:
	case st_dbat:
	case st_basetable:

	case st_atom:
	case st_export:
	case st_var:
	case st_table_clear:

		s->optimized = 2;
		return stmt_dup(s);

	case st_releqjoin:{

		list *l1 = create_stmt_list();
		list *l2 = create_stmt_list();
		node *n1, *n2;
		stmt *res;

		for (n1 = s->op1.lval->h, n2 = s->op2.lval->h; n1 && n2; n1 = n1->next, n2 = n2->next) {
			list_append(l1, rel2bin(c, n1->data));
			list_append(l2, rel2bin(c, n2->data));
		}
		res = releqjoin(c, l1, l2);
		list_destroy(l1);
		list_destroy(l2);
		s->optimized = res->optimized = 2;
		if (res != s) {
			assert(s->rewritten==NULL);
			s->rewritten = stmt_dup(res);
		}
		return res;
	}

	case st_reljoin:{

		stmt *rj = NULL;
		list *l2 = NULL;
		node *n;
		stmt *res;

		if (s->op1.stval)
			rj = rel2bin(c, s->op1.stval);

		if (s->op2.lval) {
			l2 = create_stmt_list();
			for (n = s->op2.lval->h; n; n = n->next) 
				list_append(l2, rel2bin(c, n->data));
		}
		res = reljoin(c, rj, l2);
		list_destroy(l2);
		s->optimized = res->optimized = 2;
		if (res != s) {
			assert(s->rewritten==NULL);
			s->rewritten = stmt_dup(res);
		}
		return res;
	}

	case st_relselect:{

		stmt *res;
		node *n;

		list *ol, *l = s->op1.lval;

		ol = l;
		assert(list_length(l));
		if (list_length(l) == 1) {
			res = rel2bin(c, l->h->data);
		} else {
			stmt *sel;

			l = list_dup(l, (fdup)&stmt_dup);
			if (!mvc_debug_on(c, 4096)) {
				l = shrink_select_ranges(c, l);
			}
			/* check if we have a unique index */
			l = use_ukey(c, l);
			n = list_find(l, (void*)1, (fcmp) &find_unique);
			if (!n) {
				/* TODO reorder select list 
				   (this is also needed for the unique case) */
				n = l->h;
			}
			sel = stmt_dup(n->data); 
			list_remove_node(l, n);

			sel = push_select_stmt(c, l, sel);
			res = rel2bin(c, sel);
			stmt_destroy(sel);
		}

		if (ol != l)
			list_destroy(l);
		s->optimized = res->optimized = 2;
		if (res != s) {
			assert(s->rewritten==NULL);
			s->rewritten = stmt_dup(res);
		}
		return res;
	}

	case st_semijoin: {
/*
		stmt *res = push_semijoin(rel2bin(c, s->op1.stval), rel2bin(c, s->op2.stval));
		s->optimized = res->optimized = 2;
		if (res != s) {
			assert(s->rewritten==NULL);
			s->rewritten = stmt_dup(res);
		}
		return res;
*/

		/* here we should rewrite semijoins into mirrorjoins */
		/* select(t.a,l1,h1).semijoin(select(t.b,l2,h2)); */
		/* select(t.a,l1,h1).mirror().join(t.b).select(l2,l2); */
		/* in the bin_optimizer we should make sure the 
		   mirror and projection join are pushed through 
		   the 'delta column'. 
		*/
	}
	case st_limit: 
	case st_join:
	case st_join2:
	case st_joinN:

	case st_reverse:
	case st_select:
	case st_select2:
	case st_selectN:
	case st_uselect:
	case st_uselect2: 
	case st_uselectN: 

	case st_temp:
	case st_single:
	case st_diff:
	case st_union:
	case st_outerjoin:
	case st_mirror:
	case st_const:
	case st_mark:
	case st_gen_group:
	case st_group:
	case st_group_ext:
	case st_derive:
	case st_unique:
	case st_order:
	case st_reorder:
	case st_ordered:

	case st_alias:
	case st_column:
	case st_append:
	case st_exception:
	case st_trans:
	case st_catalog:

	case st_aggr:
	case st_unop:
	case st_binop:
	case st_Nop:
	case st_convert:

	case st_affected_rows:

	case st_table:
	case st_while:
	case st_if:
	case st_return:
	case st_assign:

	case st_output: 

		if (s->op1.stval) {
			stmt *os = s->op1.stval;
			stmt *ns = rel2bin(c, os);

			assert(ns != s);
			stmt_destroy(os);
			s->op1.stval = ns;
		}

	case st_append_col:
	case st_update_col:
	case st_append_idx:
	case st_update_idx:
	case st_delete:

		if (s->type != st_convert) {
			if (s->op2.stval) {
				stmt *os = s->op2.stval;
				stmt *ns = rel2bin(c, os);
	
				assert(ns != s);
				stmt_destroy(os);
				s->op2.stval = ns;
			}
			if (s->op3.stval) {
				stmt *os = s->op3.stval;
				stmt *ns = rel2bin(c, os);
	
				assert(ns != s);
				stmt_destroy(os);
				s->op3.stval = ns;
			}
		}
		s->optimized = 2;
		return stmt_dup(s);

	case st_list:{

		stmt *res = NULL;
		node *n;
		list *l = s->op1.lval;
		list *nl = NULL;

		nl = create_stmt_list();
		for (n = l->h; n; n = n->next) {
			stmt *ns = rel2bin(c, n->data);

			list_append(nl, ns);
		}
		res = stmt_list(nl);
		s->optimized = res->optimized = 2;
		if (res != s) {
			assert(s->rewritten==NULL);
			s->rewritten = stmt_dup(res);
		}
		return res;
	}

	case st_bat:

		if (s->flag == RDONLY && 
			!mvc_debug_on(c, 32) &&
			!mvc_debug_on(c, 64) &&
			!mvc_debug_on(c, 8192)) {
			stmt *res = stmt_delta_table_bat( s->op1.cval, stmt_dup(s->h), s->flag);
			assert(s->rewritten==NULL);
			s->rewritten = stmt_dup(res);
			s->optimized = res->optimized = 2;
			return res;
		} else {
			s->optimized = 2;
			return stmt_dup(s);
		}

	case st_idxbat:

		if (s->flag == RDONLY && 
			!mvc_debug_on(c, 32) &&
			!mvc_debug_on(c, 64) &&
			!mvc_debug_on(c, 8192)) {
			stmt *res = stmt_delta_table_idxbat( s->op1.idxval, s->flag);
			assert(s->rewritten==NULL);
			s->rewritten = stmt_dup(res);
			s->optimized = res->optimized = 2;
			return res;
		} else {
			s->optimized = 2;
			return stmt_dup(s);
		}

	default:
		assert(0);	/* these should have been rewriten by now */
	}
	return stmt_dup(s);
}
