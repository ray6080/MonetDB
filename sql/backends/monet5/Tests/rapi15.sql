start transaction;

create table "Marketing_Loyalty_4700298d-9862-40b3-9028-b0f15dab9dea" ("Consumer Number" INTEGER,"1-Disloyalty" varchar(250),"2-Age" varchar(250),"3-Amount transferred" INTEGER,"4-Gender" varchar(250),"5-Citiz enship" varchar(250),"6- Profession" varchar(250),"7-City" varchar(250),"8-1 NC Billboard" varchar(250),"8-2 NC Friends" varchar(250),"8-3 NC Magazine" varchar(250),"8-4 NC Others" varchar(250),"9-Score" decimal(18,3),"10- Type of operation" varchar(250),"11-1 Welcoming" INTEGER,"11-2 Waiting time" INTEGER,"11-3 Time to finish request" INTEGER,"11-4 Fees" INTEGER,"11-5 Courtesy of employees" INTEGER,"11-6 Branch layout" INTEGER,"11-7 Attention to special requests" INTEGER,"12- Total time for service" decimal(18,3),"13- Distance from POS" decimal(18,3),"14- Weight" INTEGER);

COPY 233 offset 2 records INTO "Marketing_Loyalty_4700298d-9862-40b3-9028-b0f15dab9dea" FROM stdin USING DELIMITERS ',',E'\n','"' null as '';
,,,,Female ,Citizen,Employee,Suburbs,No,No,No,No,,International,6,5,3,6,6,2,2,10.27,1.5,75,
2,Loyal,[21-30],3,Male ,Resident,Employee,Cities,No,Yes,No,No,9.51,Local,2,6,8,2,2,1,4,10.44,1.8,78,
3,Loyal,[21-30],3,Male,Resident,Employee,Suburbs,Yes,No,Yes,No,6.67,Local,5,2,8,4,7,8,3,14.34,2.2,75,
4,Disloyal,[21-30],3,Male,Citizen,B. Owner,Cities,No,No,No,No,4.74,Local,4,8,3,6,3,4,6,6.92,0.8,81,
5,Disloyal,[21-30],2,Female,Resident,Employee,Capital,No,No,No,Yes,5.20,Local,7,6,3,3,4,6,1,7.91,1.3,78,
6,Loyal,[10-20],3,Male,Resident,Employee,Cities,No,No,Yes,No,6.27,Local,8,7,7,9,4,6,6,10.41,1.1,82,
7,Loyal,[10-20],3,Male,Resident,Employee,Cities,No,Yes,Yes,Yes,7.35,Local,5,2,6,1,3,2,3,11.19,2.0,79,
8,Loyal,> 30,2,Male,Citizen,Employee,Suburbs,No,No,Yes,Yes,6.94,International,7,6,7,9,8,5,7,13.40,1.6,70,
,Loyal,[10-20],2,Male,Resident,Jobless,Capital,No,No,No,Yes,6.94,International,3,7,8,2,6,1,9,11.53,1.7,87,
10,Disloyal,> 30,,Male,Citizen,Employee,Cities,No,No,No,Yes,4.85,Local,7,5,7,7,5,8,9,8.18,1.3,73,
11,Loyal,> 30,1,Female,Citizen,Jobless,Suburbs,Yes,No,Yes,No,,Local,3,3,3,6,6,8,1,14.91,2.2,83,
12,Disloyal,> 30,1,Female,Resident,Employee,Suburbs,No,No,No,Yes,4.87,Local,7,6,7,7,5,4,5,11.86,1.2,72,
13,Disloyal,> 30,3,Male,Citizen,Employee,Cities,No,No,No,No,6.18,Local,5,5,5,5,5,5,4,15.00,0.9,68,
14,Loyal,[21-30],3,Male,Citizen,Employee,Cities,No,No,Yes,No,8.12,Local,5,4,6,8,7,4,3,6.04,2.2,71,
,Loyal,[21-30],3,Male,Resident,Employee,Suburbs,No,No,Yes,Yes,6.11,International,4,7,5,8,2,8,2,13.17,2.3,72,
16,Disloyal,[21-30],1,Female,Resident,Employee,Cities,No,No,Yes,Yes,5.76,Local,6,5,4,6,4,7,6,5.73,1.0,74,
17,Loyal,[10-20],3,Female,Resident,Employee,Cities,No,No,Yes,No,8.49,Local,4,7,5,3,7,6,2,8.25,1.3,87,
18,Loyal,[21-30],3,Male,Resident,G.M,Cities,Yes,No,No,No,6.60,Local,3,6,7,1,2,5,3,18.54,2.4,76,
19,Loyal,[21-30],,Female,Citizen,Employee,Cities,No,No,No,No,,Local,6,1,8,1,1,1,3,12.40,1.9,67,
20,Disloyal,[21-30],3,Male,Citizen,Employee,Cities,No,Yes,Yes,No,7.15,Local,3,7,4,5,7,7,8,9.11,2.4,81,
21,Disloyal,[21-30],3,Female,Citizen,B. Owner,Cities,Yes,Yes,Yes,No,5.73,Local,4,2,2,5,3,1,2,9.08,1.0,78,
22,Loyal,[10-20],3,Male,Resident,Jobless,Cities,No,No,Yes,Yes,7.83,Local,6,5,6,4,1,7,1,11.99,2.4,87,
23,Loyal,> 30,3,Male,Citizen,G.M,Suburbs,No,No,Yes,Yes,5.37,Local,5,5,8,2,3,4,6,11.91,2.2,69,
24,Disloyal,[21-30],3,Male,Citizen,G.M,Suburbs,No,No,Yes,Yes,3.67,Local,6,3,3,4,2,4,3,12.77,1.5,65,
25,Disloyal,[21-30],2,Female,Citizen,Employee,Cities,No,Yes,Yes,Yes,5.81,Local,3,4,3,6,5,6,4,10.82,0.7,82,
26,Disloyal,> 30,2,Female,Citizen,B. Owner,Cities,No,No,No,Yes,,Local,6,6,4,4,6,6,1,13.52,1.8,72,
27,Disloyal,> 30,3,Female,Citizen,G.M,Cities,No,No,Yes,Yes,4.62,Local,7,8,4,8,4,6,7,9.75,1.3,71,
28,Disloyal,> 30,2,Male,Citizen,Employee,Suburbs,No,Yes,No,No,4.86,Local,7,6,7,8,5,6,4,8.87,1.3,74,
29,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,No,Yes,Yes,No,4.38,International,5,2,3,3,3,3,1,8.99,0.9,79,
30,Loyal,[21-30],3,Male,Resident,Employee,Cities,No,No,Yes,Yes,,Local,7,6,7,3,2,2,1,13.37,2.5,77,
31,Disloyal,> 30,3,Female,Resident,Employee,Cities,No,No,Yes,No,6.08,International,2,2,2,2,2,2,2,17.26,1.1,87,
32,Loyal,[21-30],,Female,Resident,Employee,Cities,No,No,Yes,Yes,7.90,Local,4,4,6,7,5,3,4,10.74,2.2,77,
,Disloyal,[21-30],,Female,Resident,Employee,Cities,Yes,No,No,No,5.00,Local,5,7,5,7,5,3,8,7.53,0.4,76,
,Loyal,[21-30],3,Female,Resident,Employee,Cities,No,No,Yes,Yes,6.54,Local,6,4,7,7,1,6,4,13.05,1.9,68,
35,Disloyal,> 30,2,Male,Citizen,Employee,Cities,No,No,Yes,No,6.61,Local,6,4,3,3,2,7,3,10.41,1.3,80,
36,Loyal,[21-30],3,Male,Resident,G.M,Suburbs,No,No,Yes,No,5.35,Local,5,4,4,1,1,1,2,6.73,1.8,81,
37,Disloyal,> 30,2,Female,Citizen,Employee,Suburbs,No,Yes,No,Yes,5.70,International,4,3,7,4,5,5,7,9.32,0.8,89,
38,Loyal,> 30,3,Female,Citizen,Employee,Suburbs,Yes,No,No,No,,Local,7,7,7,1,4,3,5,21.67,1.4,87,
39,Disloyal,[21-30],3,Female,Resident,Employee,Suburbs,No,Yes,No,Yes,2.41,Local,7,7,5,5,3,3,3,10.87,1.3,81,
40,Disloyal,[21-30],3,Female,Resident,Employee,Cities,No,No,Yes,No,4.42,Local,5,4,6,6,6,4,1,12.77,1.0,65,
41,Loyal,> 30,2,Male,Resident,Employee,Suburbs,Yes,No,No,No,7.40,Local,4,3,7,3,4,5,6,15.50,1.6,72,
42,Disloyal,> 30,3,Female,Citizen,Employee,Suburbs,No,Yes,Yes,Yes,4.72,Local,1,1,1,1,1,1,1,11.23,1.5,72,
43,Disloyal,[21-30],,Male,Citizen,Employee,Suburbs,No,Yes,Yes,Yes,5.01,Local,4,6,6,6,5,5,2,10.14,1.5,80,
44,Loyal,[21-30],2,Male,Resident,Employee,Suburbs,Yes,No,Yes,No,,Local,6,8,7,8,4,3,8,18.60,1.7,77,
45,Loyal,[21-30],2,Male,Resident,B. Owner,Cities,Yes,No,Yes,Yes,8.12,Local,7,6,8,2,3,2,9,14.52,0.8,81,
46,Loyal,[10-20],2,Male,Resident,Employee,Cities,Yes,Yes,Yes,Yes,7.97,Local,7,9,9,7,1,1,5,16.44,1.8,83,
,Disloyal,[21-30],3,Male,Resident,Employee,Suburbs,No,No,Yes,No,4.16,Local,6,3,3,5,6,7,7,9.92,1.1,69,
48,Disloyal,[21-30],2,Male,Citizen,Employee,Cities,No,No,Yes,No,5.20,Local,3,6,3,7,1,4,1,12.37,1.2,76,
49,Disloyal,[21-30],2,Female,Resident,Employee,Cities,Yes,No,No,Yes,6.12,Local,7,7,4,3,4,7,3,10.75,1.4,62,
50,Loyal,[21-30],2,Female,Resident,Employee,Cities,No,No,No,No,7.05,Local,8,8,6,4,1,1,4,11.46,1.7,76,
51,Disloyal,[21-30],3,Male,Citizen,Employee,Suburbs,Yes,No,No,No,4.60,Local,8,2,5,5,4,5,8,14.11,1.3,67,
52,Loyal,[21-30],2,Female,Resident,Employee,Cities,Yes,No,Yes,No,6.70,Local,5,7,6,2,6,3,6,14.46,0.8,67,
53,Loyal,> 30,1,Male,Resident,Employee,Cities,Yes,Yes,Yes,Yes,,Local,2,4,7,1,1,1,6,16.92,2.0,65,
54,Disloyal,[21-30],3,Female,Citizen,Employee,Suburbs,No,Yes,No,Yes,4.81,Local,3,3,5,1,4,8,1,11.99,1.4,80,
55,Loyal,> 30,3,Male,Citizen,G.M,Capital,No,Yes,Yes,Yes,5.95,Local,3,3,3,2,3,2,3,10.23,1.7,71,
56,Loyal,[21-30],1,Female,Resident,Jobless,Cities,No,No,Yes,Yes,7.12,Local,8,7,9,1,2,5,7,10.80,2.3,96,
57,Loyal,[21-30],2,Female,Citizen,G.M,Cities,Yes,Yes,Yes,No,5.17,Local,5,6,6,4,5,3,2,15.38,2.2,88,
58,Loyal,[21-30],3,Male,Resident,Employee,Cities,No,No,Yes,Yes,7.03,Local,4,4,3,1,3,7,3,8.86,1.6,75,
59,Loyal,[10-20],,Female,Resident,Employee,Cities,No,No,Yes,Yes,,Local,8,7,4,1,1,2,6,6.36,2.3,80,
60,Loyal,[21-30],3,Female,Resident,Employee,Suburbs,Yes,No,No,Yes,6.96,Local,7,5,6,2,6,4,5,16.45,1.7,62,
,Loyal,[21-30],3,Male,Citizen,Employee,Cities,Yes,No,Yes,No,8.78,Local,3,5,7,4,5,9,1,16.17,2.3,82,
62,Disloyal,[21-30],3,Female,Citizen,B. Owner,Capital,Yes,Yes,Yes,Yes,5.36,Local,7,7,3,3,2,4,2,9.42,1.0,92,
63,Loyal,[10-20],2,Male,Resident,Jobless,Cities,No,Yes,No,Yes,6.45,International,4,6,8,3,1,7,4,11.56,3.3,83,
64,Loyal,[21-30],2,Female,Resident,Employee,Capital,No,No,Yes,Yes,6.73,Local,7,6,6,8,4,7,6,10.41,1.8,66,
65,Loyal,[21-30],1,Male,Resident,G.M,Cities,No,No,No,Yes,5.01,Local,7,3,5,2,1,2,1,10.73,1.4,70,
66,Loyal,[21-30],3,Male,Resident,G.M,Capital,No,No,No,No,5.45,Local,5,7,3,1,1,4,5,10.57,2.1,69,
67,Disloyal,[10-20],3,Female,Citizen,Employee,Suburbs,No,No,Yes,Yes,4.85,Local,6,3,3,1,2,2,1,12.19,1.8,83,
68,Loyal,[21-30],3,Male,Resident,B. Owner,Cities,No,No,No,No,6.98,Local,6,7,3,2,1,1,1,12.26,1.9,88,
69,Loyal,[21-30],3,Female,Resident,B. Owner,Suburbs,Yes,No,Yes,Yes,6.66,Local,5,6,5,2,3,2,5,16.53,0.9,79,
70,Loyal,[10-20],3,Male,Citizen,Jobless,Cities,Yes,Yes,Yes,No,7.45,Local,7,6,8,6,8,9,7,16.98,2.2,86,
71,Disloyal,[21-30],3,Male,Resident,Employee,Cities,No,Yes,No,Yes,5.14,International,6,7,4,5,2,2,1,13.20,0.9,80,
72,Disloyal,[21-30],,Female,Citizen,Employee,Capital,No,No,No,No,4.96,Local,4,1,2,4,2,4,2,7.52,0.7,62,
73,Loyal,[10-20],3,Female,Resident,Employee,Suburbs,No,No,No,No,8.04,International,3,1,6,1,5,1,5,12.56,1.6,86,
74,Disloyal,> 30,1,Female,Resident,Employee,Cities,No,No,Yes,Yes,5.86,Local,3,4,3,6,8,9,5,8.50,1.6,89,
75,Loyal,> 30,3,Male,Resident,G.M,Cities,No,Yes,No,Yes,7.46,Local,8,7,7,7,8,6,8,10.82,1.8,84,
76,Disloyal,> 30,2,Female,Citizen,Employee,Suburbs,Yes,No,No,Yes,5.96,Local,7,1,4,2,3,4,1,10.47,0.4,87,
77,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,No,Yes,Yes,Yes,6.19,Local,1,2,1,4,1,7,1,11.45,1.4,74,
78,Disloyal,[21-30],1,Male,Resident,Employee,Cities,No,No,Yes,No,7.48,Local,7,8,2,7,9,3,1,13.13,1.4,75,
79,Loyal,[21-30],2,Male,Resident,Jobless,Cities,Yes,No,Yes,Yes,7.74,International,6,8,8,2,1,3,8,20.10,2.2,72,
80,Disloyal,[21-30],3,Female,Resident,Employee,Suburbs,Yes,No,No,Yes,5.12,International,2,6,1,6,5,7,1,12.32,1.3,87,
81,Disloyal,[21-30],2,Female,Resident,Employee,Cities,No,No,No,No,3.85,Local,3,1,1,4,1,1,1,11.28,1.3,77,
82,Disloyal,[21-30],2,Female,Resident,G.M,Cities,No,No,Yes,No,5.16,Local,9,5,5,9,8,7,7,11.67,1.2,78,
83,Disloyal,[21-30],3,Female,Resident,Employee,Suburbs,No,Yes,Yes,No,5.00,Local,2,3,5,3,3,8,9,5.43,0.7,70,
84,Loyal,[21-30],3,Female,Resident,Employee,Cities,No,No,No,Yes,6.97,Local,3,4,7,8,1,6,1,13.35,2.0,81,
85,Loyal,[21-30],2,Male,Resident,G.M,Suburbs,No,No,Yes,Yes,8.05,International,1,2,3,1,3,2,1,9.50,1.3,83,
86,Disloyal,[10-20],3,Male,Resident,G.M,Suburbs,Yes,No,Yes,Yes,6.52,Local,6,3,3,7,6,4,1,9.93,1.8,77,
,Loyal,[10-20],2,Male,Resident,Employee,Cities,Yes,Yes,Yes,Yes,5.53,Local,7,6,7,3,1,2,6,13.86,1.2,74,
88,Loyal,[21-30],,Male,Resident,Employee,Cities,Yes,No,No,No,6.80,Local,5,6,7,4,5,7,3,17.13,1.4,72,
89,Loyal,[21-30],3,Female,Resident,G.M,Cities,Yes,No,No,Yes,6.43,Local,4,6,7,1,3,6,2,14.28,2.0,70,
90,Loyal,> 30,3,Female,Resident,Employee,Cities,Yes,Yes,Yes,Yes,6.88,Local,7,8,6,7,2,7,7,19.03,1.8,82,
91,Loyal,[21-30],3,Male,Resident,Employee,Cities,Yes,Yes,Yes,Yes,8.45,International,5,5,4,1,1,1,6,14.64,1.3,80,
92,Disloyal,[21-30],3,Female,Citizen,Employee,Suburbs,Yes,No,Yes,Yes,4.18,Local,5,7,4,6,7,6,4,7.83,0.8,74,
93,Loyal,> 30,2,Female,Resident,Employee,Cities,No,Yes,Yes,No,6.21,Local,7,8,7,8,5,6,6,7.48,2.3,76,
94,Disloyal,[21-30],1,Female,Citizen,Employee,Suburbs,No,No,No,Yes,5.38,Local,4,3,1,1,2,4,2,7.84,1.1,70,
95,Loyal,[21-30],3,Female,Resident,G.M,Cities,Yes,No,No,Yes,6.08,Local,3,3,8,4,2,6,4,14.20,2.2,75,
96,Disloyal,[21-30],2,Female,Citizen,Employee,Cities,Yes,Yes,Yes,No,6.01,Local,8,8,5,7,4,7,2,11.46,1.5,74,
97,Disloyal,[21-30],3,Female,Citizen,Jobless,Suburbs,No,No,Yes,Yes,5.87,International,8,4,5,7,5,6,2,9.78,1.2,71,
98,Disloyal,[21-30],2,Female,Resident,Employee,Cities,No,No,Yes,No,4.67,Local,4,5,6,5,6,3,7,13.26,1.3,82,
99,Disloyal,> 30,3,Male,Citizen,Employee,Suburbs,Yes,No,Yes,Yes,5.51,Local,3,7,3,3,3,7,1,7.66,1.3,87,
100,Loyal,[21-30],2,Female,Citizen,Employee,Cities,No,Yes,No,No,6.78,International,8,7,7,9,4,5,6,11.41,1.4,72,
101,Loyal,[21-30],3,Male,Resident,Employee,Cities,No,No,Yes,Yes,6.67,International,8,8,9,9,3,1,2,11.23,1.3,63,
102,Disloyal,> 30,2,Male,Citizen,Employee,Cities,No,No,No,No,5.07,International,7,7,6,8,6,5,5,8.03,1.6,77,
103,Loyal,[10-20],2,Male,Resident,Employee,Capital,Yes,No,Yes,No,6.13,International,3,7,4,1,3,7,3,15.07,2.0,60,
104,Loyal,[21-30],2,Female,Resident,Employee,Cities,Yes,No,Yes,Yes,7.88,Local,2,3,3,4,3,2,1,17.43,1.8,83,
105,Loyal,> 30,3,Male,Citizen,G.M,Cities,Yes,Yes,Yes,No,8.98,International,9,7,8,8,3,9,4,17.15,2.6,89,
106,Loyal,[21-30],2,Female,Resident,G.M,Cities,No,No,Yes,Yes,8.26,International,6,7,7,4,4,4,8,9.41,2.5,82,
107,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,No,No,Yes,Yes,6.94,Local,4,8,4,5,5,2,3,11.82,2.3,76,
108,Disloyal,[21-30],3,Female,Resident,Jobless,Cities,Yes,No,Yes,No,4.75,Local,6,7,6,6,5,4,7,10.92,1.3,75,
109,Loyal,[10-20],3,Female,Resident,Jobless,Cities,No,No,No,Yes,7.82,International,6,5,8,2,7,8,6,11.12,1.4,74,
110,Loyal,[21-30],3,Male,Resident,Employee,Cities,No,No,No,No,6.73,Local,6,5,8,4,8,2,9,12.86,1.4,69,
111,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,No,Yes,Yes,No,6.18,Local,7,3,2,5,4,7,5,6.01,1.2,75,
112,Loyal,[10-20],3,Male,Resident,Employee,Suburbs,No,No,No,No,7.94,International,3,4,7,2,4,3,2,11.62,1.8,74,
113,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,Yes,No,Yes,No,5.69,International,5,6,5,4,1,6,2,13.00,1.4,95,
114,Loyal,[21-30],3,Male,Citizen,Jobless,Cities,No,No,Yes,No,7.44,Local,5,4,4,2,2,6,7,11.73,1.9,68,
115,Loyal,[21-30],3,Female,Resident,G.M,Cities,No,Yes,Yes,Yes,6.41,Local,5,5,6,5,4,1,2,6.32,1.9,75,
116,Loyal,> 30,2,Male,Resident,Employee,Capital,Yes,Yes,Yes,Yes,6.95,Local,6,7,7,7,5,8,5,13.94,1.6,69,
117,Disloyal,> 30,2,Female,Resident,Employee,Suburbs,No,No,Yes,Yes,6.22,International,4,3,2,2,2,3,1,13.95,0.9,76,
118,Disloyal,[21-30],3,Female,Resident,Employee,Capital,No,No,Yes,Yes,3.15,Local,3,2,1,2,2,1,2,13.09,1.9,70,
119,Loyal,> 30,2,Male,Citizen,Employee,Suburbs,No,No,No,No,6.68,Local,3,8,6,5,3,9,4,10.56,2.4,76,
120,Loyal,[10-20],3,Female,Resident,Jobless,Cities,Yes,No,Yes,Yes,6.59,Local,8,8,9,7,3,1,3,15.11,1.3,80,
121,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,Yes,No,Yes,No,4.69,Local,2,2,3,4,4,4,2,11.94,1.4,83,
122,Loyal,[10-20],3,Male,Resident,B. Owner,Suburbs,No,Yes,Yes,Yes,7.26,Local,6,5,7,8,5,6,5,12.88,1.7,86,
123,Loyal,[21-30],2,Male,Citizen,Employee,Cities,No,Yes,Yes,No,5.80,Local,8,7,5,3,6,9,2,13.72,2.1,84,
124,Loyal,[21-30],1,Male,Resident,Jobless,Suburbs,No,Yes,No,No,8.12,Local,6,5,4,4,3,4,3,12.20,1.0,86,
125,Loyal,[21-30],2,Female,Resident,Employee,Suburbs,No,No,Yes,Yes,6.39,Local,8,8,7,5,6,6,6,12.33,1.8,76,
126,Disloyal,[21-30],3,Male,Resident,Employee,Cities,No,No,Yes,Yes,5.67,Local,6,3,3,6,5,7,4,10.77,1.4,79,
127,Loyal,[21-30],3,Female,Resident,Jobless,Cities,Yes,Yes,Yes,No,6.95,Local,3,2,2,1,6,1,1,14.21,1.7,80,
128,Loyal,[21-30],2,Male,Resident,Jobless,Suburbs,No,No,Yes,Yes,6.69,International,8,6,6,3,3,1,4,10.90,1.8,82,
129,Loyal,[21-30],2,Female,Resident,Employee,Suburbs,Yes,Yes,Yes,No,5.00,International,7,6,7,4,7,4,4,14.33,1.8,91,
130,Disloyal,[21-30],2,Female,Resident,Employee,Cities,No,No,Yes,Yes,5.45,International,7,6,7,5,6,8,8,13.28,2.1,62,
131,Disloyal,[21-30],3,Male,Citizen,Employee,Suburbs,No,No,Yes,Yes,5.05,Local,4,3,1,7,2,1,6,7.57,1.6,79,
132,Loyal,[21-30],2,Female,Resident,G.M,Cities,No,No,Yes,No,7.41,Local,8,9,8,6,4,6,6,12.17,1.8,75,
133,Loyal,> 30,3,Male,Resident,Employee,Cities,Yes,No,Yes,Yes,6.54,Local,4,4,3,4,1,8,7,14.01,1.7,75,
134,Loyal,[10-20],3,Male,Resident,G.M,Cities,No,Yes,Yes,No,7.36,Local,2,5,7,3,7,6,2,10.75,1.3,77,
135,Loyal,[21-30],2,Male,Citizen,Employee,Suburbs,Yes,No,Yes,No,7.39,Local,6,7,6,7,6,6,7,19.01,2.1,78,
136,Loyal,> 30,1,Female,Resident,Employee,Cities,No,Yes,No,Yes,6.38,Local,6,6,8,8,8,8,7,12.12,2.1,69,
137,Disloyal,[21-30],2,Female,Citizen,B. Owner,Suburbs,No,No,Yes,Yes,4.97,Local,4,3,2,1,2,2,2,11.11,0.6,73,
138,Disloyal,[21-30],3,Male,Citizen,Employee,Cities,No,Yes,No,Yes,5.03,Local,6,4,3,4,2,5,2,8.91,1.3,80,
139,Disloyal,> 30,3,Male,Resident,Employee,Cities,No,No,Yes,No,6.55,Local,6,4,3,4,5,3,5,5.77,1.0,70,
140,Loyal,[21-30],2,Female,Resident,G.M,Cities,Yes,No,Yes,No,6.27,Local,7,6,6,5,5,4,3,17.89,2.0,83,
141,Loyal,[10-20],3,Male,Resident,Jobless,Cities,Yes,Yes,Yes,Yes,6.42,Local,7,7,5,1,2,2,8,21.39,1.7,70,
142,Disloyal,> 30,1,Female,Resident,Employee,Cities,Yes,No,Yes,Yes,4.07,Local,4,5,5,5,3,2,2,10.08,1.9,75,
143,Loyal,[21-30],3,Male,Resident,G.M,Cities,Yes,No,Yes,Yes,6.64,International,7,8,7,3,8,2,8,16.44,2.1,73,
144,Loyal,> 30,2,Female,Resident,Employee,Capital,Yes,No,Yes,Yes,7.42,Local,7,8,8,9,4,7,5,15.34,2.4,68,
145,Disloyal,[21-30],3,Male,Citizen,B. Owner,Suburbs,No,No,Yes,No,4.83,Local,7,8,6,8,6,4,5,9.38,1.2,78,
146,Loyal,[21-30],3,Female,Citizen,Jobless,Suburbs,No,No,No,Yes,6.66,Local,5,6,6,1,6,1,6,12.40,2.1,80,
147,Disloyal,[21-30],3,Male,Citizen,Employee,Suburbs,Yes,Yes,Yes,Yes,5.40,International,9,7,2,7,7,2,1,10.85,1.4,82,
148,Loyal,[21-30],2,Male,Citizen,Employee,Suburbs,No,Yes,Yes,Yes,8.28,Local,7,8,4,6,3,3,2,9.81,1.6,82,
149,Loyal,[21-30],2,Female,Citizen,Employee,Cities,No,Yes,Yes,Yes,6.43,Local,3,4,4,2,5,2,4,6.77,1.6,73,
150,Disloyal,[21-30],2,Female,Citizen,Employee,Suburbs,No,No,Yes,Yes,3.92,Local,7,6,3,4,5,4,8,12.36,1.1,74,
151,Loyal,> 30,2,Male,Resident,G.M,Cities,Yes,No,Yes,Yes,7.33,Local,1,1,9,9,5,1,7,14.23,1.9,72,
152,Loyal,[21-30],2,Female,Resident,Jobless,Cities,Yes,Yes,No,Yes,8.03,Local,7,8,4,1,1,3,4,17.69,1.5,76,
153,Disloyal,[21-30],3,Male,Resident,Employee,Suburbs,No,No,Yes,No,4.29,Local,1,1,1,1,1,1,1,8.38,1.7,81,
154,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,Yes,No,Yes,Yes,4.14,Local,6,4,6,7,7,3,1,8.47,1.5,83,
155,Loyal,[21-30],2,Female,Resident,Jobless,Cities,No,No,Yes,Yes,7.74,Local,6,5,5,4,4,5,5,10.42,1.5,70,
156,Disloyal,> 30,3,Female,Resident,G.M,Cities,Yes,No,Yes,No,5.53,International,4,3,2,4,4,3,2,12.19,0.9,71,
157,Disloyal,> 30,3,Male,Citizen,Employee,Capital,No,No,Yes,No,7.79,Local,5,6,6,5,5,4,6,12.17,0.1,77,
158,Disloyal,[21-30],1,Female,Citizen,Employee,Cities,No,No,Yes,Yes,7.16,Local,5,6,1,6,6,6,9,6.03,1.4,77,
159,Loyal,[21-30],3,Female,Citizen,Employee,Suburbs,No,No,Yes,No,8.05,International,7,5,7,8,8,5,9,13.28,1.0,83,
160,Loyal,[21-30],2,Female,Citizen,Employee,Suburbs,No,Yes,Yes,Yes,,International,7,2,6,2,4,1,2,11.73,0.9,72,
161,Disloyal,[21-30],3,Female,Resident,Employee,Suburbs,Yes,No,Yes,No,,Local,4,6,7,7,4,4,8,7.46,1.1,82,
162,Disloyal,[21-30],3,Female,Citizen,Employee,Capital,No,Yes,Yes,Yes,,Local,6,2,4,4,4,3,2,8.24,0.9,72,
163,Disloyal,[21-30],3,Female,Citizen,Jobless,Suburbs,Yes,No,No,Yes,,International,5,6,7,4,4,5,6,8.44,0.8,72,
164,Disloyal,[21-30],2,Female,Citizen,Employee,Cities,No,No,Yes,No,,Local,2,7,4,2,5,7,1,9.61,1.5,71,
165,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,Yes,No,No,Yes,,Local,3,4,3,4,6,6,5,7.48,0.8,81,
166,Disloyal,[21-30],3,Female,Citizen,Employee,Suburbs,Yes,Yes,No,No,,Local,6,5,6,4,4,3,3,11.67,1.5,76,
167,Loyal,> 30,3,Male,Citizen,B. Owner,Suburbs,Yes,Yes,Yes,Yes,,Local,7,6,7,3,2,2,4,16.49,1.5,79,
168,Disloyal,[21-30],3,Male,Resident,Employee,Suburbs,Yes,No,No,Yes,,International,7,3,1,1,3,3,6,9.15,0.7,82,
169,Disloyal,[21-30],3,Male,Citizen,Employee,Cities,Yes,No,Yes,No,,Local,5,6,6,6,4,7,6,8.60,2.0,77,
170,Disloyal,[21-30],2,Female,Citizen,Employee,Suburbs,No,No,No,Yes,5.65,International,4,7,2,6,4,7,2,8.59,0.8,74,
171,Disloyal,[10-20],3,Male,Citizen,Employee,Suburbs,Yes,Yes,No,Yes,4.58,Local,3,3,3,4,6,7,2,9.95,1.0,66,
172,Loyal,[21-30],2,Male,Resident,G.M,Cities,Yes,No,Yes,Yes,6.31,Local,6,6,7,4,3,1,3,16.71,1.9,68,
173,Loyal,[10-20],2,Male,Resident,G.M,Cities,No,Yes,Yes,No,6.57,Local,7,3,4,2,1,1,3,12.86,2.4,66,
174,Disloyal,> 30,3,Female,Citizen,Employee,Suburbs,No,Yes,No,No,5.41,International,5,8,2,5,8,5,1,15.41,1.1,66,
175,Disloyal,> 30,3,Female,Resident,Employee,Cities,Yes,No,Yes,Yes,3.93,Local,5,8,7,3,3,3,4,8.03,1.1,76,
176,Disloyal,[21-30],3,Male,Citizen,Employee,Cities,No,Yes,Yes,Yes,4.09,Local,4,7,7,6,3,2,1,16.45,1.5,80,
177,Disloyal,[21-30],3,Male,Citizen,B. Owner,Suburbs,Yes,Yes,No,Yes,5.29,International,6,3,5,4,5,7,4,13.11,1.5,68,
178,Loyal,> 30,1,Male,Citizen,Employee,Suburbs,No,No,Yes,Yes,7.00,Local,5,4,6,3,3,7,3,12.21,2.2,63,
179,Loyal,[21-30],1,Female,Resident,Employee,Cities,No,No,Yes,No,6.89,Local,3,5,8,1,7,1,4,8.61,2.6,79,
180,Disloyal,[21-30],2,Male,Citizen,Employee,Cities,No,No,Yes,Yes,4.67,Local,7,3,1,4,1,3,1,5.16,1.3,76,
181,Loyal,[21-30],3,Male,Resident,Employee,Suburbs,No,No,No,Yes,8.04,Local,7,2,7,2,8,6,2,12.66,1.4,69,
182,Disloyal,[21-30],2,Female,Citizen,Employee,Cities,Yes,No,Yes,No,6.19,Local,6,6,5,4,3,5,4,12.94,1.5,75,
183,Disloyal,[21-30],3,Female,Resident,G.M,Suburbs,Yes,No,No,Yes,5.31,Local,5,7,3,8,6,7,6,15.07,1.4,71,
184,Loyal,> 30,1,Female,Resident,Employee,Suburbs,Yes,No,Yes,No,6.32,Local,1,4,1,1,1,1,1,16.11,2.1,79,
185,Loyal,[21-30],2,Female,Citizen,Employee,Cities,No,No,No,Yes,7.89,Local,4,4,3,1,8,3,1,13.16,1.6,86,
186,Disloyal,[21-30],1,Female,Citizen,Employee,Cities,No,No,Yes,No,4.25,International,6,7,5,7,4,3,9,7.30,1.7,82,
187,Disloyal,[21-30],3,Male,Citizen,Employee,Suburbs,No,No,Yes,No,4.16,Local,3,5,3,6,5,2,7,14.73,0.7,72,
188,Loyal,[10-20],2,Male,Resident,G.M,Cities,No,No,Yes,Yes,6.27,Local,3,6,4,3,2,8,5,9.82,2.2,77,
189,Loyal,[21-30],3,Female,Resident,Employee,Suburbs,Yes,No,Yes,Yes,6.43,Local,5,5,6,3,1,1,3,13.86,1.6,82,
190,Disloyal,[21-30],2,Female,Resident,Employee,Cities,Yes,Yes,No,Yes,,Local,3,6,1,1,1,2,1,9.13,1.8,75,
191,Disloyal,[10-20],3,Male,Citizen,Employee,Suburbs,Yes,No,Yes,Yes,4.96,Local,2,9,1,6,4,3,8,9.14,1.8,80,
192,Disloyal,[21-30],3,Male,Citizen,Jobless,Suburbs,No,No,Yes,No,4.29,International,3,6,4,5,5,7,7,7.58,1.5,74,
193,Disloyal,[21-30],2,Female,Citizen,Employee,Cities,Yes,No,Yes,Yes,4.43,Local,5,7,1,5,1,7,1,8.85,1.2,73,
194,Loyal,> 30,3,Male,Citizen,G.M,Suburbs,Yes,No,No,No,7.65,Local,7,5,7,8,2,8,5,20.70,1.4,76,
195,Loyal,> 30,2,Male,Resident,Employee,Suburbs,No,Yes,Yes,Yes,5.17,Local,7,8,6,1,2,1,7,7.94,2.0,76,
196,Disloyal,[21-30],2,Female,Citizen,Employee,Cities,No,No,Yes,No,5.40,Local,7,5,4,5,2,6,1,15.45,1.2,85,
197,Disloyal,> 30,1,Female,Resident,Jobless,Suburbs,No,Yes,Yes,Yes,6.45,Local,7,5,5,6,7,6,4,12.22,1.3,85,
198,Loyal,[21-30],3,Female,Resident,Employee,Cities,Yes,No,No,Yes,7.70,Local,7,6,7,5,6,1,2,16.03,1.4,65,
199,Loyal,> 30,3,Female,Citizen,Employee,Suburbs,Yes,Yes,Yes,No,7.85,Local,3,5,7,8,8,7,4,15.37,1.7,75,
200,Loyal,[21-30],2,Male,Resident,Employee,Cities,No,Yes,Yes,Yes,6.87,International,7,8,7,6,1,6,4,12.95,2.3,82,
201,Disloyal,> 30,3,Female,Resident,Employee,Suburbs,No,No,No,No,4.69,Local,5,1,1,1,1,7,5,7.34,0.8,68,
202,Disloyal,> 30,3,Female,Resident,Employee,Suburbs,No,Yes,Yes,No,4.05,Local,4,6,3,4,7,5,8,8.87,0.9,77,
203,Loyal,> 30,1,Male,Citizen,Jobless,Cities,Yes,Yes,No,Yes,7.83,International,5,5,5,8,8,9,6,14.88,1.9,84,
204,Loyal,[10-20],3,Female,Resident,Employee,Cities,Yes,No,Yes,Yes,4.43,Local,2,5,6,3,1,2,3,14.21,1.0,76,
205,Disloyal,[21-30],3,Male,Citizen,Employee,Suburbs,No,Yes,Yes,No,5.85,Local,7,8,3,4,5,3,2,8.12,1.7,69,
206,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,Yes,Yes,Yes,No,3.26,Local,4,3,7,6,7,3,2,10.12,1.0,86,
207,Disloyal,> 30,3,Female,Citizen,B. Owner,Cities,No,No,Yes,Yes,5.15,Local,2,1,5,4,4,3,1,10.01,1.6,76,
208,Disloyal,[21-30],3,Male,Citizen,Employee,Cities,No,No,No,No,5.20,Local,4,6,3,5,6,6,6,12.63,0.7,79,
209,Disloyal,> 30,1,Male,Resident,Employee,Cities,No,No,Yes,Yes,4.83,International,5,6,5,7,6,6,8,8.90,2.0,85,
210,Loyal,[10-20],3,Male,Resident,G.M,Cities,No,No,Yes,Yes,6.82,Local,6,7,5,1,4,9,2,7.48,1.8,79,
211,Disloyal,[21-30],3,Female,Citizen,Employee,Suburbs,Yes,No,Yes,Yes,5.97,Local,8,8,6,6,5,5,3,10.54,0.8,78,
212,Disloyal,[21-30],3,Female,Resident,Employee,Cities,Yes,No,Yes,Yes,4.31,International,6,6,3,5,3,4,2,7.21,0.7,80,
213,Loyal,[21-30],2,Female,Resident,Employee,Suburbs,No,No,Yes,Yes,4.86,International,3,6,6,2,2,3,1,12.92,1.7,80,
214,Disloyal,[21-30],2,Female,Citizen,Employee,Capital,Yes,No,No,Yes,5.01,Local,8,1,2,7,5,7,1,7.08,1.3,74,
215,Loyal,[21-30],3,Female,Resident,Employee,Cities,No,Yes,Yes,Yes,7.72,Local,3,2,2,1,1,1,1,9.81,1.4,69,
216,Disloyal,> 30,2,Male,Citizen,Jobless,Suburbs,No,Yes,No,No,7.26,Local,4,6,5,5,4,7,6,11.73,1.6,77,
217,Disloyal,[21-30],3,Female,Citizen,Employee,Suburbs,No,Yes,Yes,Yes,5.10,Local,3,2,2,4,2,6,1,11.08,1.4,74,
218,Disloyal,[21-30],2,Female,Citizen,Employee,Capital,Yes,No,No,Yes,5.61,Local,7,3,5,4,4,7,6,17.72,1.4,78,
219,Loyal,> 30,2,Female,Citizen,Employee,Cities,No,Yes,Yes,No,5.91,Local,7,8,6,1,5,2,7,9.99,1.3,69,
220,Loyal,[10-20],2,Male,Resident,G.M,Cities,No,Yes,Yes,No,6.43,Local,5,3,3,6,2,1,1,9.52,2.2,67,
221,Loyal,> 30,3,Male,Citizen,G.M,Suburbs,No,No,Yes,Yes,7.68,Local,2,2,4,2,7,6,1,12.03,1.1,73,
222,Disloyal,[21-30],2,Male,Citizen,Employee,Suburbs,No,No,No,No,5.79,Local,5,7,4,6,4,7,1,8.49,0.4,83,
223,Loyal,> 30,3,Male,Citizen,Employee,Suburbs,No,No,Yes,Yes,6.33,Local,7,6,6,1,3,2,4,7.70,1.7,73,
224,Disloyal,[21-30],2,Female,Resident,Jobless,Cities,No,No,Yes,Yes,6.47,Local,6,7,4,6,6,7,8,14.32,1.2,76,
225,Loyal,[21-30],3,Male,Resident,G.M,Cities,Yes,No,Yes,Yes,8.17,Local,5,6,4,1,1,7,5,16.02,2.1,74,
226,Disloyal,[21-30],3,Male,Citizen,G.M,Cities,No,Yes,Yes,No,4.43,Local,4,3,5,6,3,4,1,8.86,0.9,67,
227,Loyal,[10-20],3,Female,Resident,G.M,Cities,No,No,No,Yes,5.06,Local,7,7,6,7,5,6,5,8.48,1.8,72,
228,Disloyal,> 30,2,Female,Citizen,Employee,Suburbs,Yes,No,Yes,Yes,6.47,Local,3,1,2,7,6,6,2,13.32,1.0,67,
229,Loyal,[21-30],3,Female,Citizen,Employee,Capital,No,No,No,No,7.36,Local,3,4,4,2,2,1,1,13.33,1.6,67,
230,Disloyal,[21-30],3,Male,Citizen,Employee,Cities,No,No,No,Yes,3.09,Local,8,8,2,6,3,7,1,11.99,0.5,76,
231,Loyal,[10-20],3,Female,Resident,Jobless,Cities,No,No,No,Yes,8.77,Local,6,7,6,7,9,2,2,11.08,1.8,76,
232,Disloyal,> 30,3,Male,Citizen,Employee,Suburbs,Yes,Yes,Yes,Yes,4.74,Local,2,6,5,7,6,2,7,6.84,1.2,84,
233,Disloyal,[21-30],3,Female,Citizen,Employee,Cities,No,No,Yes,No,3.98,Local,3,4,3,3,4,4,4,11.14,1.1,83,
234,Loyal,[21-30],1,Female,Resident,Employee,Suburbs,No,No,Yes,Yes,4.83,International,7,7,7,4,7,8,7,13.60,1.7,76,

CREATE AGGREGATE "ttest2samples"(arg1 double, arg2 varchar(250)) RETURNS double LANGUAGE R { 
unlist(lapply(split(data.frame(arg1, arg2, stringsAsFactors=F), aggr_group), function(x) {round(t.test(arg1 ~ arg2, data=x)$p.value,2)}))
};
CREATE AGGREGATE "ttest2samplesStatistic"(arg1 double, arg2 varchar(250)) RETURNS double LANGUAGE R { 
unlist(lapply(split(data.frame(arg1, arg2, stringsAsFactors=F), aggr_group), function(x) {round(t.test(arg1 ~ arg2, data=x)$statistic,2)}))
};

update "Marketing_Loyalty_4700298d-9862-40b3-9028-b0f15dab9dea" set "4-Gender"=trim("4-Gender");
select "2-Age","ttest2samplesStatistic"("9-Score", "4-Gender") as "stat", "ttest2samples"("9-Score", "4-Gender") as "pvalue" from "Marketing_Loyalty_4700298d-9862-40b3-9028-b0f15dab9dea"  group by  "2-Age";

rollback;
