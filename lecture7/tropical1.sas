* Tropical1 Example
  Use a macro variable for simple text 
  substitution in a SAS script;
  
%LET flowertype = Ginger;

options ls=64 nodate pageno=1;
data flowersales;
   infile "c:/datasets/tropical-sales.txt";
   input custid $4. @6 sale_date MMDDYY10. @17 variety $9. quantity;
   if variety = "&flowertype";

proc print;
   format sale_date WORDDATE18.;
   title "Sales of &flowertype";
run;
quit;
