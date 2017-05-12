* Matt Triano's Assignment 5a) for CSC 433;

* Uncomment the following link to generate comments in the log
  file on how the macro lines are expanded.  This line may
  or may not be useful;
options mprint;


%MACRO create_datasets(num_states=);

libname states "c:/states-datasets";
%DO k = 1 %TO &num_states;
	data state_data;
    	infile "c:/states-files/state&k..txt" dlm="," truncover;
		length text $40;
      	input text $;
		if _N_ = 1 then do;
			length state $ 20;
			dsname = trim(text);
			state  = trim(text); 
	  		IF find(trim(text), " ") ge 1 THEN DO;
				dsname = tranwrd(trim(text), " ", "_");
			END;
	      	call symput("name", state);
			call symput("dsname", dsname);
		else: 
			length city_name $ 20;
			rank 		= scan(text,1,",");
			city_name	= scan(text,2,',');
			popul 		= scan(text,3,',');
			call symput("rank_text", rank);
			call symput("city_name", scan(trim(text),2,","));
			call symput("population", scan(trim(text),3,","));
		end;
		input rank city_name $ population;
        output;
		keep k dsname state rank city_name population;
	run;

   	data states.&dsname;
    	set state_data;
   	run;

	proc print data=states.&dsname;
    	title "Ten Largest Cities in &name";      
		var rank city_name population;
   	run;
%END;
%MEND create_datasets;

%create_datasets(num_states=50)

run;
quit;
