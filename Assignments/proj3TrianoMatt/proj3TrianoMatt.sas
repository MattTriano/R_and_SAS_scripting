/* Matt Triano's CSC433 Assignment 1
   Due on April 13th, 2017
   Completed on April 4th
*/
options linesize=103 nodate pageno=1;
data marathon;
   	infile 'c:/datasets/erie-marathon-2006.txt' firstobs=12;
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

data _NULL_;
	set 	marathon;
	file	'c:\datasets\triano_matt_assn1output.txt' print header=head; 
	title 'Erie Marathon Runner Data';
		*header = 'Runner ID Place Runner Name Final Time  Mile Pace';
	put 	id_number @11 place @18 name @43 age @48 gender @51 hometown $51-70 @71 homestate @75 final_time TIME. @86 mile_pace TIME.;
	return;

head:
	put 	'Jersey #' @11 'Place' @18 'Runner Name' @43 'Age' @48 'Sex' @52 'Hometown' @72 'State' @78 'Final Time' @88 'Mile Pace';
run;
quit;
