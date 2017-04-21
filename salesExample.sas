* Sales Example 
  Write a report that totals sales 
  from various cities;

options linesize=75 nodate pageno=1;
data sales;
   infile 'c:/datasets/sales.txt' firstobs=2;
   input city $ 1-11 sales;
   title 'Sales Example';

proc print;

proc sort;
   by city;

data _null_;
   file 'c:/datasets/report.txt' print header=head;
   title 'Sales Example';
   set sales end=eof;
      by city;
   if first.city then salestot = 0;
   salestot + sales;
   if last.city then do;
      grandtot + salestot;
      put @10 city @33 salestot DOLLAR8.;
   end;
   if eof then do;
      put @10 '-------------------------------';
      put @10 'Grand Total:' @31 grandtot DOLLAR10.;
   end;
   return;   
head:
   put //;                     
   put @10 'Region' @30 'Total Sales';
   put @10 '======' @30 '===========';

run;
quit;
