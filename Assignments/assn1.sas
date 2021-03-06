/* Matt Triano's CSC433 Assignment 1
   Due on April 13th, 2017
   Completed on April 4th
*/
options linesize=103 nodate pageno=1;
data marathon;
   	infile 'c:/datasets/erie-marathon-2006.txt' firstobs=12;
	input @3 id_number 3. @9 place 3. @19 name $19-32 @88 final_time TIME7. @98 mile_pace TIME5. ;
	name = scan(name,1,',');  * This removes additional characters from 1-12 char-long names;
	* This line prevents entry of the dashed and 'Pace:...' lines;
	if id_number ^= . then output; 
	* This adds labels to our variables;
	label 	id_number 	= 'Runner ID'     
    		place 		= 'Finish Place'	
			name 		= 'Runner Name'
			final_time	= 'Final Time'
   			mile_pace	= 'Mile Pace';

	* this would remove values with missing data, but the problem doesn't requite that;
	*if (id_number ^= .) and (place ^= .) and (mile_pace ^= .) then output; 

title "RUNHIGH's Erie Marathon Placement and Times";
proc print label;
   format final_time TIME. mile_pace TIME.;
   var id_number place name final_time mile_pace;

proc sort;
	by name; 

title "RUNHIGH's Erie Marathon Placement and Times";
proc print label;
   format final_time TIME. mile_pace TIME.;
   var id_number place name final_time mile_pace;

proc sort data = marathon;
	by final_time;

data _NULL_;
	set 	marathon;
	file	'c:\datasets\triano_matt_assn1output.txt';
	put 	id_number @9 place @15 name @32 final_time TIME. @45 mile_pace TIME.;

run;
quit;
