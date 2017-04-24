/* Matt Triano's CSC433 Assignment 1
   Due on April 13th, 2017
   Completed on April 4th
*/
options linesize=103 nodate pageno=1;
data marathon;
   	infile 'c:/datasets/erie-marathon-2006.txt' firstobs=12 lrecl = 8192;
	input @3 id_number 3. @9 place 3. @19 identity $19-64 @88 final_time TIME7. @98 mile_pace TIME5. ;
	name 		= scan(identity,1,',');  * This removes additional characters from 1-12 char-long names;
	age_gender 	= scan(identity,2,',');  * This returns the age and the asterisk that indicates gender;
	hometown 	= scan(identity,3,',');  * This returns the hometown of the runner;
	homestate 	= scan(identity,4,',');  * This returns the homestate of the runner;
	len = length(age_gender);
	if index(age_gender, "*") = 0 then do;
		age 	= age_gender;
		gender 	= 'M';
	end;
	else do;
		age = scan(age_gender, -1);
		gender = 'F';
	end;

	* This line prevents entry of the dashed and 'Pace:...' lines;
	if id_number ^= . then output; 
	
	label 	id_number 	= 'Jersey Number'     
    		place 		= 'Finish Place'	
			name 		= 'Runner Name'
			age 		= 'Runner Age'
			gender 		= 'Runner Gender'
			hometown 	= 'Runner Hometown'
			homestate	= 'Runner Homestate'
			final_time	= 'Final Time'
   			mile_pace	= 'Mile Pace';

	* this would remove values with missing data, but the problem doesn't requite that;
	*if (id_number ^= .) and (place ^= .) and (mile_pace ^= .) then output; 

/*data marathon;*/
/*	set 	gender = 'F';*/
/*	where	age contains '*';*/

title "RUNHIGH's Erie Marathon Placement and Times";
proc print label;
   format final_time TIME. mile_pace TIME.;
   var id_number place name age gender hometown homestate final_time mile_pace;

 *This sorts the data by name and then prints those sorted entries    ;

proc sort;
	by name; 

title "RUNHIGH's Erie Marathon Placement and Times";
proc print label;
   format final_time TIME. mile_pace TIME.;
   var id_number place name age gender hometown homestate final_time mile_pace;

/* This sorts the data by final time, then that sorted data is 
   written to a file named 'triano_matt_assn1output.txt in the 
   grader's C:\datasets directory
 */
proc sort data = marathon;
	by final_time;

/*proc means data=marathon noprint;
	where gender = "M";
	output out = male_stats 
		n(id_number)		= runner_count_m
		mean(final_time)	= average_time_m
		percent_m 			= runner_count_m * 100/runner_count; */

proc means data=marathon noprint;
	output out = all 
		n(id_number)		= runner_count
		mean(final_time)	= average_time;

proc means data=marathon noprint;
	where gender = "F";
	output out = female_stats 
		n(id_number)		= runner_count_f
		mean(final_time)	= average_time_f;

data female_data;
	if _n_ = 1 then set female_stats;
	if _n_ = 1 then set all;
	set marathon;
	percent_f = runner_count_f / runner_count;
	keep id_number place name age gender hometown homestate final_time mile_pace runner_count_f average_time_f runner_count percent_f;

proc means data=marathon noprint;
	where gender = "M";
	output out = male_stats 
		n(id_number)		= runner_count_m
		mean(final_time)	= average_time_m;

data male_data;
	if _n_ = 1 then set male_stats;
	if _n_ = 1 then set all;
	set marathon;
	percent_m = runner_count_m / runner_count;
	keep id_number place name age gender hometown homestate final_time mile_pace runner_count_m average_time_m runner_count percent_m;

data _NULL_;
	set 	marathon;
	file	'c:\datasets\triano_matt_assn3_output_all.txt' print header=head; 
	title 'Erie Marathon Runner Data';
	if _n_ = 1 then set all;
	put 	@2 id_number @12 place @19 name @43 age @48 gender @51 hometown $51-70 @71 homestate @76 final_time TIME. @87 mile_pace TIME.;
	return;

head:
	put / 	"Total Number of Runners:  " runner_count;
	put 	"Average Race Time: 	   " average_time TIME.;
	put /	;
	put 	'Jersey #' @11 'Place' @18 'Runner Name' @42 'Age' @47 'Sex' @51 'Hometown' @70 'State' @76 'Final Time' @87 'Mile Pace';
run;


data _NULL_;
	set 	female_data;
	file	'c:\datasets\triano_matt_assn3_output_female.txt' print header=head; 
	title 'Erie Marathon Female Runner Data';
	put 	@2 id_number @12 place @19 name @43 age @48 gender @51 hometown $51-70 @71 homestate @76 final_time TIME. @87 mile_pace TIME.;
	return;

head:
	put / 	"Total Number of Female Runners:      " runner_count_f;
	put 	"Average Race Time: 	         " average_time_f TIME.;
	put 	"Female Proportion of Runners:    " percent_f percent9.2;
	put /	;
	put 	'Jersey #' @11 'Place' @18 'Runner Name' @42 'Age' @47 'Sex' @51 'Hometown' @70 'State' @76 'Final Time' @87 'Mile Pace';
run;

data _NULL_;
	set 	male_data;
	file	'c:\datasets\triano_matt_assn3_output_male.txt' print header=head; 
	title 'Erie Marathon Male Runner Data';
	put 	@2 id_number @12 place @19 name @43 age @48 gender @51 hometown $51-70 @71 homestate @76 final_time TIME. @87 mile_pace TIME.;
	return;

head:
	put / 	"Total Number of Male Runners:      " runner_count_m;
	put 	"Average Race Time: 	       " average_time_m TIME.;
	put 	"Male Proportion of Runners:    " percent_m percent9.2;
	put /	;
	put 	'Jersey #' @11 'Place' @18 'Runner Name' @42 'Age' @47 'Sex' @51 'Hometown' @70 'State' @76 'Final Time' @87 'Mile Pace';
run;
quit;
