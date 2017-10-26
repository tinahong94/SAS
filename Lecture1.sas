data tmp1;
/* the file for the data, tmp = the name of the file */ 

do i=1 to 20;
j=i*2.9;
	output;
	*if we don't do an output here there it won't have column from 1 to 20. Only starts from 21;
end;

run; 

data tmp2;
	set tmp1;
	/* brings the data set you just generated inside */
	keep i k;
	/* drop j; */
	/* delete variable j */
	k=j*i;
run;

data tmp2;
	set tmp1 /*(drop=j)*/;
	/* drop j when it brings in the data */
	/* will incur missing values as the next statement is requiring j times i */
	k=j*i;
run;

data tmp3;
	set tmp1;
	retain sumi;
	/* it keeps the values from the previous observations */

	if _n_ eq 1 then do; 
		sumi=0; 
		jj=1;
	end; /* _n_ equals to row number */
	else jj=47;
	sumi=sumi+i;
run;

data seasons;
	input pmonth t0 t5 t1 t2 t3 t4 t6;
datalines;
run;

%let ngenre=7; /*%LET macro-variable =<value>*/
data targets;
	format t1-t&ngenre $20.0; /* characters or strings that equal to 20 */
	input t1-t&ngenre $; /*allows characters length up to 20*/
datalines;
all_other_sports mlb nba_college_basketball nfl_college_football nhl concerts theaters
;
run;
