/* Matt Triano's CSC433 Assignment 1
   Due on April 13th, 2017
   Completed on April 4th
*/
options linesize=103 nodate pageno=1;
data marathon;
   	infile 'c:/datasets/erie-marathon-2006.txt' firstobs=12;
	input @3 id_number 3. @9 place 3. @19 identity $19-65 @88 final_time TIME7. @98 mile_pace TIME5. ;
	name = scan(identity,1,',');  * This removes additional characters from 1-12 char-long names;
	age = scan(identity,2,',');   * This returns the age;
	fem = find(age, '*');
	/*	gender = 'M';*/
	if (fem = 0) then gender = 'M';
		ELSE gender = 'M'; * This returns the runner's gender;

	* This line prevents entry of the dashed and 'Pace:...' lines;
	if id_number ^= . then output; 
	
	label 	id_number 	= 'Runner ID'     
    		place 		= 'Finish Place'	
			name 		= 'Runner Name'
			age 		= 'Runner Age'
			gender 		= 'Runner Gender';
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
   var id_number place name age gender final_time mile_pace;

/* This sorts the data by name and then prints those sorted entries    
*/ 
/*proc sort;*/
/*	by name; */
/**/
/*title "RUNHIGH's Erie Marathon Placement and Times";*/
/*proc print label;*/
/*   format final_time TIME. mile_pace TIME.;*/
/*   var id_number place name age gender final_time mile_pace;*/
/**/
/*/* This sorts the data by final time, then that sorted data is */
/*   written to a file named 'triano_matt_assn1output.txt in the */
/*   grader's C:\datasets directory*/
/* */*/
/*proc sort data = marathon;*/
/*	by final_time;*/
/**/
/*data _NULL_;*/
/*	set 	marathon;*/
/*	file	'c:\datasets\triano_matt_assn1output.txt'; */
/*		*header = 'Runner ID Place Runner Name Final Time  Mile Pace';*/
/*	put 	id_number @11 place @18 name @43 age @48 gender @51 final_time TIME. @62 mile_pace TIME.;*/


run;
quit;
