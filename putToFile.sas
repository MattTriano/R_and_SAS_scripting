* PutToFile Example
  Use the file and put statement to write to 
  an output file;  

data _null_;
   infile 'c:/datasets/kids.txt' firstobs=2;
   file 'c:/datasets/kids-out.txt';
   input name $ gender $ age;
   put 'name=' name 'gender=' gender 'age=' age;

run;
quit;
