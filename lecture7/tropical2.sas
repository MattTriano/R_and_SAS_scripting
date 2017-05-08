* Tropical2 Example
  Define and invoke a macro;

options ls=64 nodate pageno=1;

* Define the macro;
%MACRO print_5_largest_sales;
  proc sort data=flowersales;
     by descending quantity;
  run;
  proc print data=flowersales (obs=5);
     format sale_date WORDDATE18.;
	 title 'Five Largest Sales';
  run;
%MEND print_5_largest_sales;

data flowersales;
   infile "c:/datasets/tropical-sales.txt";
   input custid $4. @6 sale_date MMDDYY10. @17 variety $9. quantity;
run;

* Invoke the macro;
%print_5_largest_sales;

run;
quit;