* Tropical5 Example
  Use CALL SYMPUT to set macro variables 
  in a data step;

options ls=64 nodate pageno=1;

* Read dataset;
data flowersales;
   infile "c:/datasets/tropical-sales.txt";
   input custid $4. @6 sale_date MMDDYY10. @17 variety $9. quantity;
run;

* Sort dataset;
proc sort data=flowersales;
   by descending quantity;

* Find biggest order and pass custid to a macro variable;
data _null_;
   set flowersales;
   if _n_ = 1 then call SYMPUT("selected_customer", custid);
   else stop;
run;

proc print data=flowersales;
   where custid="&selected_customer";
   format sale_date WORDDATE18.;
   title "Customer &selected_customer Had the Largest Order";
run;

quit;