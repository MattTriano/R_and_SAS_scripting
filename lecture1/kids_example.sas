data kids;
	infile "C:/Users/mattt/Dropbox/new school/School/CSC433/data sets/kids.txt" firstObs=2;
	length 	name $ 20; * have to include the $ or SAS interprets 'names' as a number;
	input 	name $ gender $ age;
	label 	name	= "Name of Kid"
			gender 	= "Gender of Kid"
			age 	= "Kids' age"

*proc print;
proc means n min max;

proc sort;
	by gender;

proc means n min max;
	by gender;

proc sort;
	by name;

proc sort out=kidssorted;
	by name;

proc print data=kidssorted;

proc print data=kids (obs=1);
	where gender = 'F';

proc print data=kids (obs=1);
	where gender = 'M';

run;
quit;
* lecture stopped at 1:11:24;
