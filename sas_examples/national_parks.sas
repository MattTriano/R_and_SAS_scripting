* NationalParks Example
  
  Generate reports using proc report
  with various options and features; 

options ls=70 nodate pageno=1;
data national_parks;
   infile 'c:/datasets/national-parks.txt' firstobs=2;
   input Name $ 1-21 Type $ Region $ Museums Camping;

proc print;
run;

proc report data=national_parks nowindows headline;
   title '1. Report with Character and Numeric Variables';
   run;

proc report data=national_parks nowindows headline;
   title '2. Report with Only Numeric Variables';
   column Museums Camping;
   run;

* Report with order variable, missing option, and column header;
proc report data=national_parks nowindows headline missing;
   title '3. National Parks and Monuments Arranged';
   title2 ' by Region and Column Header';
   column Region Name Museums Camping;
   define Region / order;
   define Camping / analysis 'Camp/Grounds';
   run;

* Region and Type as group variables;
proc report data=national_parks nowindows headline;
   title '4. Summary Report with Two Group Variables';
   column Region Type Museums Camping;
   define Region / group;
   define Type / group;
   run;

* Region as group and Type as across with Sums;
proc report data=national_parks nowindows headline;
   title '5. Summary Report with a Group and an Across Variable';
   column Region Type Museums Camping;
   define Region / group;
   define Type / across;
   run;

* Report with breaks;
proc report data=national_parks nowindows headline;
   title '6. Detail Report with Summary Breaks';
   column Name Region Museums Camping;
   define Region / order;
   break after Region / summarize ol skip;
   rbreak after / summarize ol skip;
   run;

* Statistics in column ctatement with two group variables;
proc report data=national_parks nowindows headline;
   title '7. Statistics with Two Group Variables';
   column Region Type n (Museums Camping), mean;
   define Region / group;
   define Type / group;
   run;

* Statistics in Column statement with group and across variables;
proc report data=national_parks nowindows headline;
   title '8. Statistics with a Group and Access Variable';
   column region n Type, (Museums Camping), mean;
   define Region / group;
   define Type / across;
   run;

* Compute new variables that are numeric and character;;
proc report data=national_parks nowindows headline;
   title '9. Report with Two Computed Variables';
   column Name Region Museums Camping Facilities Note;
   define Museums / analysis sum noprint;
   define Camping / analysis sum noprint;
   define Facilities / computed 'Camping/and/Museums';
   define Note / computed;
   compute Facilities;
      Facilities = Museums.sum + Camping.sum;
   endcomp;
   compute Note / char length = 10;
      if Camping.sum = 0 then Note = 'No Camping';
   endcomp;
   run;

quit;
