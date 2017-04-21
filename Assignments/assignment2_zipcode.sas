/*data a;
	input a @@;
	datalines;
1 3 5 7
;

proc print data = a;
	title 'a data';
run;

data b;
	input b @@;
	datalines;
2 4
;

proc print data = b;
	title 'b data';
run;

data combined;
	 infile 'c:/datasets/quiz3_5.txt';
	 input a @@;
	 output;
	 input b @@;
	 output;
	 /*
     set a;
     output;
     set b;
     output;
*/
/*
proc print data = combined;
	title 'combined';
run;
quit;
*/
/*
data zip;
input origin destination @@;
city_orig=zipcity(origin);
name_orig=zipname(origin);
state_orig=zipstate(origin);

city_dest=zipcity(destination);
state_dest=zipstate(destination);
name_dest=zipname(destination);

subject = zipcity(destination);
distance = zipcitydistance(origin, destination);
datalines;
60622 53713
60614 48201
60126 30135
;
run;

proc print;
run;
*/

data zip;
input origin destination @@;
*city_orig=zipcity(origin);
*name_orig=zipname(origin);
state_orig=zipstate(origin);

*city_dest=zipcity(destination);
*name_dest=zipname(destination);
state_dest=zipstate(destination);

distance = zipcitydistance(origin, destination);
datalines;
60622 53713
60614 48201
60126 30135
;
run;

proc print;
run;
