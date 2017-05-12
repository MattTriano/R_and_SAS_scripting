* Uncomment the following link to generate comments in the log
  file on how the macro lines are expanded.  This line may
  or may not be useful;
options mprint;

/*%MACRO create_datasets(num_states=);*/
/*
libname states "c:/states-datasets";
%DO k = 1 %TO &num_states;
	data state_data;
    	infile "c:/states-files/state&k..txt" dlm="," obs=1;
      	length city $ 20;
      	input state $1-20;
		dsname = trim(state);
	  	IF find(trim(state), " ") ge 1 THEN DO;
			dsname = tranwrd(trim(state), " ", "_");
		END;
      	call symput("name", state);
      	call symput("dsname", dsname);
	run;
	data city_data;
		infile "c:/states-files/state34.txt" dlm="," firstobs=2 lrecl=200 truncover;
		input city_data $1-40;
		rank 		= scan(city_data,1,',');
		city_name	= scan(city_data,2,',');
		popul 		= scan(city_data,3,',');
		call symput("rank", rank);
		call symput("city_name", trim(city_name));
		call symput("population", popul);
	run;
      	do i = 1 to &num_states;
        	input rank city_name $ popul;
        	output;
      	end;
      	keep i state;
	run;

   	data states.&name;
    	set state_data;
   	run;

	proc print data=states.&dsname;
    	title "Ten Largest Cities in &name";      
   	run;
%END;
%MEND create_datasets; */

%MACRO create_datasets(num_states=);

libname states "c:/states-datasets";
%DO k = 1 %TO &num_states;
	data state_data;
    	infile "c:/states-files/state&k..txt" truncover;
      	input text $1-40;
/*	data _NULL_;*/
/*		set state_data;*/
		if _N_ = 1 then do;
			state = trim(text);
	  		IF find(trim(text), " ") ge 1 THEN DO;
				dsname = tranwrd(trim(text), " ", "_");
			END;
	      	call symput("name", state);
			call symput("dsname", dsname);
		else: 
			rank 		= scan(text,1,",");
			city_name	= scan(text,2,',');
			popul 		= scan(text,3,',');
/*			%let rank_text=trim(%scan(text,1,','));*/
/*			call symput("rank", scan(trim(text),1,","));*/
			call symput("rank_text", rank);
			call symput("city_name", scan(trim(text),2,","));
			call symput("population", scan(trim(text),3,","));
		end;
		input state rank city_name $ population;
        output;
		keep k state rank city_name population;
	run;
/*	data city_data;*/
/*		infile "c:/states-files/state34.txt" dlm="," firstobs=2 lrecl=200 truncover;*/
/*		input city_data $1-40;*/
/*		rank 		= scan(city_data,1,',');*/
/*		city_name	= scan(city_data,2,',');*/
/*		popul 		= scan(city_data,3,',');*/
/*		call symput("rank", rank);*/
/*		call symput("city_name", trim(city_name));*/
/*		call symput("population", popul);*/
/*	run;*/
/*      	do i = 1 to &num_states;*/
/*        	input rank city_name $ popul;*/
/*        	output;*/
/*      	end;*/
/*      	keep i &state;*/
/*	run;*/

   	data states.state;
    	set state_data;
   	run;

	proc print data=states.state;
    	title "Ten Largest Cities in &name";      
   	run;
%END;
%MEND create_datasets;

%create_datasets(num_states=50)

%create_datasets(num_states=50)

run;
quit;
