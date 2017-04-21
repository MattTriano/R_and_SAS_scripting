* Create dataset;
/*
data quiz_scores;
   input name $ score;
   datalines;
William 95
Jenna   92
Scott   89
Carla   94
;

proc print;

proc contents;

*proc means mean;
*/

/*
data test;
	input x y @@;
	datalines;
1 1  2 3  3 2  4 4
;

proc reg;
	model y = x;

run;
quit;
*/

/* 	Create a SAS dataset without an input statement;
	If you want to enter more than 1 entry, you need output statements
	 or SAS will just overwrite earlier entries
*/
/*
data kids;
	name 	= "Alice";
	gender 	= "F";
	age 	= 11;
	output;
	name 	= "Scott";
	gender 	= "M";
	age 	= 12;
	output;

proc print;
*/

/*
data kids;
	infile "C:/Users/mattt/Dropbox/new school/School/CSC433/data sets/kids.txt" firstObs=2;
	length 	name $ 20; * have to include the $ or SAS interprets 'names' as a number;
	input 	name $ gender $ age;
	label 	name	= "Name of Kid"
			gender 	= "Gender of Kid"
			age 	= "Kids' age"
*/

* Quiz1 Example;
* Compute course scores and final grades;
/*
data quiz;
   infile 'c:/datasets/quiz1.txt' firstobs=3;
   * (1.): informat style;
   input name $ 1-10 (q1-q5) (1.) midterm final; 				*(q1-q5) = (q1,q2,q3,q4,q5), (1.) = 'numeric with 1 digit before a decimal';
   * below: column style ; 
   *input name $ 1-10 q1 11 q2 12 q3 13 q4 14 q5 15 midterm final;
	if final = . then final = 0;
   quiz_ave = mean(q1,q2,q3,q4,q5);
   course_score = quiz_ave * 8.0 + midterm * 0.3 + final * 0.3;
   if course_score >= 90.0 then grade = 'A';
   else if course_score >= 80.0 then grade = 'B';
   else if course_score >= 70.0 then grade = 'C';
   else if course_score >= 60.0 then grade = 'D';
   else grade = 'F';

proc print;
   var name course_score grade;


run;
quit;
*/

* lecture at 2:05:14;




* Quiz2 Example;
* Compute course scores and final grades;
* One line is used for three observations;

options linesize=70 nodate pageno=1;
data quiz;
   infile 'c:/datasets/quiz2.txt' firstobs=3;
   input name $CHAR10. (q1-q5) (1.) midterm final @@;
   if final = . then final = 0;
   quiz_ave = mean(q1,q2,q3,q4,q5);
   course_score = quiz_ave * 8.0 + midterm * 0.3 + final * 0.3;
   if course_score >= 90.0 then grade = 'A';
   else if course_score >= 80.0 then grade = 'B';
   else if course_score >= 70.0 then grade = 'C';
   else if course_score >= 60.0 then grade = 'D';
   else grade = 'F';

proc print;
   var name course_score grade;

run;
quit;



/*
* Quiz3 Example;
* Compute course scores and final grades;
* Three lines are used for one observation;

options linesize=70 nodate pageno=1;
data quiz;
   infile 'c:/datasets/quiz3.txt';
   length name $ 10;
   input name $
      #2 (q1-q5) (1.) 
      #3 midterm final;
   if final = . then final = 0;
   quiz_ave = mean(q1,q2,q3,q4,q5);
   course_score = quiz_ave * 8.0 + midterm * 0.3 + final * 0.3;
   if course_score >= 90.0 then grade = 'A';
   else if course_score >= 80.0 then grade = 'B';
   else if course_score >= 70.0 then grade = 'C';
   else if course_score >= 60.0 then grade = 'D';
   else grade = 'F';

proc print;
   var name course_score grade;

run;
quit;
*/

* Pointer Example;
* Use SAS column and line pointers to control data access;
 /*
options linesize=70 nodate pageno=1;
data test;
   input #3 a $ 3-5 @10 b $2. +5 c $1.
         /  d $ 17-21
         #5 @8 e 5.;
   datalines;
         11111111112222222
12345678901234567890123456
abcdefghijklmnopqrstuvwxyz
zyxwvutsrqponmlkjihgfedcba
12345678910111213141516171
;

proc print;

run;
quit;
*/
