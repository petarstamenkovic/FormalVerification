checker black_box_checker(
	clk,
	rst,
	x,
	y
);

	default clocking @(posedge clk); endclocking
	default disable iff rst;

	property p1;
		(y[0] |=> ~y[0]);
	endproperty
	assert property(p1);
	
	// Attempt to implement liveness, assert fails but counter example makes sense for me to fail
	property p2;
		//(y[2] |=> y[2]);
		//(y[2][*]);
		always s_eventually y[2]; 
	endproperty
	assert property(p2);
	
	property p3;
		(y[1] |=> y[3]) until y[4];
	endproperty
	assert property(p3);
	
	// Now on the left side of implication is sequence, i could also implemented a seperate sequence  
	// but i was wondering if this way is okay?
	property p4;
		//(y[2] |=> y[5]) |=> y[6];
		(y[2] ##1 y[5]) |=> y[6]; //this should synatxily make sense
		//y[2] |=> y[5] |=> y[6];
	endproperty
	assert property(p4);

	sequence seq5;
		(~y[2])[*3];
	endsequence
	
	property p5;
		//~y[2][*3] |-> y[7];
		seq5 |-> y[7];
	endproperty
	assert property(p5);
	
	// How come operator '->' makes a property and not a sequnce?
	sequence seq6;
		y[8][*2:3] ##1 ~y[9];
	endsequence
	
	property p6;
		//y[8][->2:3] |=> ~y[9] |=> y[10];
		//y[8][*2:3] |=> ~y[9] |=> y[10];
		seq6 |=> y[10];
	endproperty
	assert property(p6);

	// Both p5 and p6 seem to fail but counter-example makes me think they are written
	// properly. 

	// Still struggling with this if else branching, difficult to find info online
	property p7;
		if (y[0])  (y[1])  else y[11]; 
	endproperty
	assert property(p7);

	property p8;
		y[2][->2] |=> y[16];  
	endproperty
	assert property(p8);

	property p9;
		y[28:17][->3] |=> y[5];  
	endproperty
	assert property(p9);
	
	property p10;
		y[29][*10];  
	endproperty
	cover property(p10);

	property p11_assumption;
		not(x[1] && x[0]);
	endproperty;
	assume property(p11_assumption);

	property p11;
		not(y[31] && y[30]);
	endproperty;
	assert property(p11);

endchecker
