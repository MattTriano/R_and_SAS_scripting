* GenerateState Example
  Determine the number of stores in each
  state based on its population;

options ls=64 nodate pageno=1;
data state_pop;
   infile 'c:/datasets/states.txt' firstobs=3;
   input state $ 1-14 @16 pop COMMA12.;
   nstores = round(sqrt(pop)/20);
   drop pop;

proc print;

run;
quit;
