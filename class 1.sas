**********************************;
** class 1 sas code;
**********************************;
options linesize=120 pagesize=55 spool mprint;
%let indir=C:\Users\Tina_\Documents\Fall 2017 SMU\Mod B\MAST6251 Predictive Analytics\Lecture 1\Class 1;
%let dsopt=compress=yes replace=yes reuse=yes;
libname indta "&indir";
*** get the cereal data;
proc import file="&indir.\cereal_cost.xlsx"
 DBMS=xlsx OUT=tmp REPLACE; sheet="sheet1";  
run;
data indta.tmp2; set tmp; run;
ods graphics on;
ods pdf file="&indir.\Graphs.pdf";
/* ods=output delivery system*/
PROC GLM DATA = tmp plots=diagnostics; /*GLM= general linear model*/
	MODEL Sales = Price Ad_Dollars Ad_Frequency Other_price / solution ; /* sales = y variables, while all others are x variables */
	ods output ParameterEstimates=parms;
	estimate "test price and other" price 1 other_price -1; /*test if the price and other prices are the same*/
	output out=test residual = resid; /*creating an output file named test*/
RUN;
* Plot the residuals;
PROC GPLOT;
	PLOT resid*Price;
	PLOT resid*ad_dollars;
RUN;

PROC EXPORT DATA=parms
            OUTFILE= "&path\regress1.csv"
            DBMS=CSV LABEL REPLACE;
     PUTNAMES=YES; /*put variables name in the first row*/
RUN;
ods pdf close;
