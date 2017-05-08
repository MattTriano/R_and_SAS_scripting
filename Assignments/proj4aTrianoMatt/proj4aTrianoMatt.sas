/* Matt Triano's CSC433 Assignment 4A */
options linesize=103 nodate pageno=1;
data baylor;
   	infile 'c:/datasets/baylor-religion-survey-data-2007.txt' firstobs=1 lrecl = 100000;
	input @1 id 10. @11 weight 6. @17 religion $17 @18 relig1 $18-19 @20 relig2 $20-21 @22 denom $22-72 @73 religious $73
			@74 attend $74 @75 howlong $75 @76 howmany $76 @134 prayfreq 1. @135 bibleinterp $135 @136 god_belief $136 @318 daterace $318 
			@360 gender $360 @380 income $380;
run;
	
proc format;
	value $gndr '1' = 'Male' '2' = 'Female';
run;

proc format;
	value $bibinterp '1' = 'The Bible is Literal' 
					 '2' = 'The Bible is perfect but needs interpretation' 
 					 '3' = 'The Bible contains human error'
					 '4' = 'The Bible is an ancient book of legends'
					 '5' = 'I do not know how to interpret the Bible';
run;

proc format;
	value $god	 	'1' = 'No Doubt God Exists'
					'2' = 'Some Doubt God Exists'
					'3' = 'I Sometimes Believe God Exists'
					'4' = 'I Believe In A Higher Power/Cosmic Force'
					'5' = 'I Am Agnostic'
					'6' = 'I Am An Atheist'
					'7' = 'No Opinion';

proc format;
	value $inc 	'1' = '$10,000 or less'
				'2' = '$10,001 to $20,000'
				'3' = '$20,001 to $35,000'
				'4' = '$35,001 to $50,000'
				'5' = '$50,001 to $100,000'
				'6' = '$100,001 to $150,000'
				'7' = '$150,001 or more';

proc format;
	value $racedate 	'1' = 'Yes'
						'2' = 'No';

/*proc print data=baylor;
	var id weight religion relig1 relig2 denom attend howlong howmany gender prayfreq bibleinterp;
*/

proc sgplot data=baylor;
	vbar bibleinterp / group = gender groupdisplay = cluster;
	format gender $gndr.;
	format bibleinterp $bibinterp.;
	label bibinterp = 'Bible Interpretation';
	title 'Bible Interpretation by gender';
run;

proc freq data=baylor;
	tables bibleinterp * gender / chisq;
	format gender $gndr.;
	format bibleinterp $bibinterp.;
	label bibinterp = 'Bible Interpretation';
	title 'Bible Interpretation by gender';
run;

proc sgplot data=baylor;
	vbar income / group = daterace groupdisplay = cluster;
	format daterace $racedate.;
	format income $inc.;
	label inc = 'Income Bracket';
	title 'Heterogeneous Racial Dating By Income';
run;

proc freq data=baylor;
	tables income * daterace / chisq;
	format daterace $racedate.;
	format income $inc.;
	label inc = 'Income Bracket';
	title 'Heterogeneous Racial Dating By Income';
run;

proc sgplot data=baylor;
	vbar income / group = god_belief groupdisplay = cluster;
	format god_belief $god.;
	format income $inc.;
	label inc = 'Income Bracket';
	title 'God-Belief By Income';
run;

proc freq data=baylor;
	tables income * god_belief / chisq;
	format god_belief $god.;
	format income $inc.;
	label inc = 'Income Bracket';
	title 'God-Belief By Income';
run;

proc sgplot data=baylor;
	vbar god_belief / group = daterace groupdisplay = cluster;
	format daterace $racedate.;
	format god_belief $god.;
	label god_belief = 'god belief';
	title 'Heterogeneous Racial Dating By God-Belief';
run;

proc freq data=baylor;
	tables god_belief * daterace / chisq;
	format daterace $racedate.;
	format god_belief $god.;
	label inc = 'Income Bracket';
	title 'Heterogeneous Racial Dating By God-Belief';
run;

quit;
