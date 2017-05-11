* Uncomment the following link to generate comments in the log
  file on how the macro lines are expanded.  This line may
  or may not be useful;
options mprint;

*UNCOMMENT BELOW;


%MACRO create_datasets(num_states=);

libname states "c:/states-datasets";
%DO k = 1 %TO &num_states;
	data state_name;
		infile "c:/states-files/state1.txt" dlm="," obs=1;
    	length state $ 20;
    	input state $;
		dsname = trim(state);
		%IF find(trim(state), " ") ge 1 %THEN %DO;
			dsname = tranwrd(trim(state), " ", "_");
		%END;
	run;
	data city_data;
		infile "c:/states-files/state34.txt" dlm="," firstobs=2 lrecl=200 truncover;
		input city_data $1-40;
		rank 		= scan(city_data,1,',');
		city_name	= scan(city_data,2,',');
		popul 		= scan(city_data,3,',');
	run;
	/*data state_name;
		infile "c:/states-files/state&k..txt" dlm="," obs=1;
    	length state $ 20;
    	input state $;
		state = trim(&state);
		%IF %index(&state, " ") = 0 %THEN %DO;
			%LET dsname = tranwrd(trim(state), " ", "_");
		%END;
		%ELSE %DO;
			%LET dsname = state;
		%END;

    	call symput("name", state);
    	call symput("dsname", dsname);

	data state_data;
		infile "c:/states-files/state&k..txt" dlm="," firstobs=2;
    	length state $ 20;
    	length city $ 20;
		input city $;
    	dsname = tranwrd(trim(state), " ", "_");
    	call symput("name", state);
    	call symput("dsname", dsname);
	*/

    %do i = 1 %to 50;
    	input rank city_name $ popul;
        output;
	%end;
    keep i state city_name popul;

	data states.&name;
		set state_name;
	run;

   	proc print data=states.&dsname;
    	title "Ten Largest Cities in &name";      
   	run;
%END;
%MEND create_datasets;

%create_datasets(num_states=50)

run;
quit;
/* END UNCOMMENT */


/* Working Code!

data state_name;
	infile "c:/states-files/state1.txt" dlm="," obs=1;
    length state $ 20;
    input state $;
	dsname = trim(state);
	IF find(trim(state), " ") ge 1 THEN DO;
		dsname = tranwrd(trim(state), " ", "_");
	END;
run;

data city_data;
	infile "c:/states-files/state34.txt" dlm="," firstobs=2 lrecl=200 truncover;
	input city_data $1-40;
	rank 		= scan(city_data,1,',');
	city_name	= scan(city_data,2,',');
	popul 		= scan(city_data,3,',');
run;

proc print data=state_name;
	var state dsname;
proc print data=city_data;
	var rank city_name popul;
/*proc print data=city_data;*/

/*run;*/
/*quit;*/
