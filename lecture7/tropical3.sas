* Tropical3 Example
  Define and invoke a macro with parameters;

options ls=64 nodate pageno=1;

* Define the macro;
%MACRO select(customer=, sortvar=);
  proc sort data=flowersales out=salesout;
     by &sortvar;
     where custid="&customer";
  run;

  proc print data=salesout;
     format sale_date WORDDATE18.;
	 title1 "Orders for Customer Number &customer";
     title2 "Sorted by &sortvar";
  run;
%MEND select;

data flowersales;
   infile "c:/datasets/tropical-sales.txt";
   input custid $4. @6 sale_date MMDDYY10. @17 variety $9. quantity;
run;

* Invoke the macro;
%select(customer = 356W, sortvar = quantity);
%select(customer = 240W, sortvar = variety);

run;
quit;