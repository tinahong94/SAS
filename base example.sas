data tmp;

do i=1 to 20;
   j=i*1.76;
   output;
end;
run;

data tmp2;
   set tmp;
   retain sumi;
  * if _n_ eq 1 then sumi=0;
   sumi=sumi+i;
   drop i;
run;

data tmp3;
   set tmp (drop=i);
   retain sumi;
   if _n_ eq 1 then do; sumi=0; end;
   sumi=sumi+i;
run;

data seasons;
  input pmonth t0 t5 t1 t2 t3 t4 t6 ;
datalines ;
   1 1 1 0 2 3 1 1 
   2 1 1 2 2 3 1 1 
   3 1 1 2 2 3 1 1 
   4 1 1 1 3 0 3 1 
   5 1 1 1 3 0 3 1 
   6 1 1 1 3 0 3 1 
   7 1 1 1 0 0 0 1 
   8 1 1 1 0 2 0 1 
   9 1 1 3 0 1 2 1 
   10 1 1 3 1 1 1 1
   11 1 1 3 2 1 1 1
   12 1 1 0 2 1 1 1
;
run;

%let ngenre=7;

data targets;
    format t1-t&ngenre $20.0;
	input t1-t&ngenre $ ;
datalines ;
all_other_sports mlb nba_college_basketba nfl_college_football nhl concerts theater  
;
run;
