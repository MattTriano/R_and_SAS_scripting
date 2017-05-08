* GetStateSales Example
  Find total sales in a state file and 
  append it to the total_sales.txt file;

%MACRO get_state_sales(state_name= );
   data sales;
      infile "c:/datasets/state-files/&state_name..txt";
      input store_sales;
      state = "&state_name";
   run;

   data _null_;
      file "c:/datasets/total_sales.txt" mod;
      set sales end=eof;
      total + store_sales;
      if eof then do;
         put state 14. @16 total COMMA12.; 
      end;
   run;

%MEND get_state_sales;

%get_state_sales(state_name = california)
%get_state_sales(state_name = texas)
%get_state_sales(state_name = new_york)
%get_state_sales(state_name = florida)
%get_state_sales(state_name = illinois)
%get_state_sales(state_name = pennsylvania)
%get_state_sales(state_name = ohio)
%get_state_sales(state_name = georgia)
%get_state_sales(state_name = michigan)
%get_state_sales(state_name = north_carolina)
%get_state_sales(state_name = new_jersey)
%get_state_sales(state_name = virginia)
%get_state_sales(state_name = washington)
%get_state_sales(state_name = massachusetts)
%get_state_sales(state_name = arizona)
%get_state_sales(state_name = indiana)
%get_state_sales(state_name = tennessee)
%get_state_sales(state_name = missouri)
%get_state_sales(state_name = maryland)
%get_state_sales(state_name = wisconsin)
%get_state_sales(state_name = minnesota)
%get_state_sales(state_name = colorado)
%get_state_sales(state_name = alabama)
%get_state_sales(state_name = south_carolina)
%get_state_sales(state_name = louisiana)
%get_state_sales(state_name = kentucky)
%get_state_sales(state_name = oregon)
%get_state_sales(state_name = oklahoma)
%get_state_sales(state_name = connecticut)
%get_state_sales(state_name = iowa)
%get_state_sales(state_name = mississippi)
%get_state_sales(state_name = arkansas)
%get_state_sales(state_name = kansas)
%get_state_sales(state_name = utah)
%get_state_sales(state_name = nevada)
%get_state_sales(state_name = new_mexico)
%get_state_sales(state_name = nebraska)
%get_state_sales(state_name = west_virginia)
%get_state_sales(state_name = idaho)
%get_state_sales(state_name = hawaii)
%get_state_sales(state_name = maine)
%get_state_sales(state_name = new_hampshire)
%get_state_sales(state_name = rhode_island)
%get_state_sales(state_name = montana)
%get_state_sales(state_name = delaware)
%get_state_sales(state_name = south_dakota)
%get_state_sales(state_name = alaska)
%get_state_sales(state_name = north_dakota)
%get_state_sales(state_name = vermont)
%get_state_sales(state_name = wyoming)

run;
quit;