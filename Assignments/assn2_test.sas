
data zip;
input origin;* destination @@;
zipcity(origin);
*subject = zipcity(destination);
*distance = zipcitydistance(origin, destination);
datalines;
60622 
53713
60614 
48201
60126 
30135
;

proc print;
run;

/*
data zips;
    input zip customerid @;
    citystate=zipcity(zip);
    city=scan(citystate,1,',');
  cards;
  27513 762
  33432 338
  07026 267
  ;
  run;

proc print;
run;
*/
 /*
data locations;
input Zip;
City=zipcity(zip);
data_flag=1;
datalines;
35004
85003
71601
80002
06001
19701
20001
32007
83201
60001
46001
50001
66002
40003
70001
3901
20601
1001
27513
;
run;

proc print;
run;
quit;
*/
