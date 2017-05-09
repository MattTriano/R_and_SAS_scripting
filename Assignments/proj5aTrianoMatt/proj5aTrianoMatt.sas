* Uncomment the following link to generate comments in the log
  file on how the macro lines are expanded.  This line may
  or may not be useful;
options mprint;
/**/
/*%MACRO create_datasets(num_states=);*/
/**/
/*libname states c:/states-datasets;*/
/*%DO k = 1 %TO &num_states;*/
/*   data state_data;*/
/*      infile "c:/states-files/state&k..txt" dlm=',';*/
/*      length state $ 20;*/
/*      length city $ 20;*/
/*      input state $;*/
/*      dsname = transwrd(trim(state), " ", "_");*/
/*      call symput("name", state);*/
/*      call symput("dsname", dsname);*/
/**/
/*      do i = 1 to 50;*/
/*         input rank city $ popul;*/
/*         output;*/
/*      end;*/
/*      keep i state;*/
/*   run;*/
/**/
/*   data states.&name;*/
/*      set state_data;*/
/*   run;*/
/**/
/*   proc print data=states.&dsname;*/
/*      title "Ten Largest Cities in &name";      */
/*   run;*/
/*%END*/
/*%MEND create_datasets;*/
/**/
/*%create_datasets(numstates=50)*/
/**/
/*run;*/
/*quit;*/


%MACRO create_datasets(num_states=);

libname states 'c:/states-datasets';
%DO k = 1 %TO &num_states;
   data state_name;
		infile "c:/states-files/state&k..txt" dlm="," obs=1;
    	length state $ 20;
    	length city $ 20;
    	input state $;
		input #1 city $;
    	dsname = tranwrd(trim(state), " ", "_");
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

    do i = 1 to 50;
    	input rank city $ popul;
        output;
	end;
    keep i state;

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
/* Stopped lecture at 2:14, he's about to go into possibly relevant examples */

/*
libname states c:/states-datasets;

data state_data;
	infile "c:/states-files/state34.txt" dlm=",";
    length state $ 20;
    length city $ 20;
    input state $;
    dsname = tranwrd(trim(state), " ", "_");
    call symput("name", state);
    call symput("dsname", dsname);

    do i = 1 to 50;
    	input rank city $ popul;
        output;
	end;
    keep i state;

data states.&name;
	set state_data;
run;

proc print data=state_data;
run;
quit;
*/;
