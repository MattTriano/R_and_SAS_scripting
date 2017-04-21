* ProcSort Example
  Show how various sort options 
  to affect the sort order;

options linesize=70 nodate pageno=1;
data addresses;
   input name $ 6. street $18. city $9. state $6.;
   datalines;
Seiki 100 A St.         juneau   alaska
Wong    2 A St.         Honolulu Hawaii
Shaw   10 A St. Apt. 10 Juneau   Alaska
Smith  10 A St. Apt. 2  honolulu hawaii
;

* Sort in street addresses in numeric order;
proc sort data=addresses out=sorted1
          sortseq=linguistic 
          (numeric_collation=on);
   by street;

* Sort states ignoring case;
proc sort data=addresses out=sorted2
          sortseq=linguistic 
          (strength=primary);
   by state;

proc print data=sorted1;
   title 'Addresses sorted by Street';

proc print data=sorted2;
   title 'Addresses sorted by State';

run;
quit;
