* GenerateState Example
  Generate simulated store sales data
  for stores in all 50 states;

%MACRO generate_state(state=, nstores=);
   data _null_;
      file "c:/datasets/state-files/&state..txt";
      %DO i = 1 %TO &nstores;
         sales = 80000 + round(rannor(0) * 15000);
         put sales 7.;
      %END;
%MEND;

%generate_state(state = california,    nstores = 308)
%generate_state(state = texas,         nstores = 255)
%generate_state(state = new_york,      nstores = 221)
%generate_state(state = florida,       nstores = 220)
%generate_state(state = illinois,      nstores = 179)
%generate_state(state = pennsylvania,  nstores = 179)
%generate_state(state = ohio,          nstores = 170)
%generate_state(state = georgia,       nstores = 157)
%generate_state(state = michigan,      nstores = 157)
%generate_state(state = north_carolina, nstores = 156)
%generate_state(state = new_jersey,    nstores = 156)
%generate_state(state = virginia,      nstores = 143)
%generate_state(state = washington,    nstores = 131)
%generate_state(state = massachusetts, nstores = 129)
%generate_state(state = arizona,       nstores = 128)
%generate_state(state = indiana,       nstores = 128)
%generate_state(state = tennessee,     nstores = 127)
%generate_state(state = missouri,      nstores = 123)
%generate_state(state = maryland,      nstores = 121)
%generate_state(state = wisconsin,     nstores = 120)
%generate_state(state = minnesota,     nstores = 116)
%generate_state(state = colorado,      nstores = 114)
%generate_state(state = alabama,       nstores = 110)
%generate_state(state = south_carolina,nstores = 109)
%generate_state(state = louisiana,     nstores = 107)
%generate_state(state = kentucky,      nstores = 105)
%generate_state(state = oregon,        nstores =  99)
%generate_state(state = oklahoma,      nstores =  98)
%generate_state(state = connecticut,   nstores =  95)
%generate_state(state = iowa,          nstores =  86)
%generate_state(state = mississippi,   nstores =  86)
%generate_state(state = arkansas,      nstores =  86)
%generate_state(state = kansas,        nstores =  85)
%generate_state(state = utah,          nstores =  84)
%generate_state(state = nevada,        nstores =  83)
%generate_state(state = new_mexico,    nstores =  72)
%generate_state(state = nebraska,      nstores =  68)
%generate_state(state = west_virgina,  nstores =  68)
%generate_state(state = idaho,         nstores =  63)
%generate_state(state = hawaii,        nstores =  59)
%generate_state(state = maine,         nstores =  58)
%generate_state(state = new_hampshire, nstores =  57)
%generate_state(state = rhode_island,  nstores =  51)
%generate_state(state = montana,       nstores =  50)
%generate_state(state = delaware,      nstores =  48)
%generate_state(state = south_dakota,  nstores =  48)
%generate_state(state = alaska,        nstores =  43)
%generate_state(state = north_dakota,  nstores =  42)
%generate_state(state = vermont,       nstores =  40)
%generate_state(state = wyoming,       nstores =  38)
run;
quit;