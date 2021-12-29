module v7404 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input pin1, pin3, pin5, pin9, pin11, pin13;
	output pin2, pin4, pin6, pin8, pin10, pin12;
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule

module v7408 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output pin3, pin6, pin8, pin11;
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
endmodule


module v7432 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output pin3, pin6, pin8, pin11;
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
endmodule

module mux2to1 (x,y,s,m);
	input x; //select 0
    	input y; //select 1
    	input s; //select signal
    	output m; //output
	wire w0, w1, w2; //define my wires
	v7404 U0 (
		.pin1(s),
		.pin2(w0)	
	);
	v7408 U1 (
		.pin1(w0),
		.pin2(x),
		.pin3(w1),
		.pin4(s),

		.pin5(y),

		.pin6(w2)
	);
	v7432 U2 (
		.pin1(w1),
		.pin2(w2),
		.pin3(m)
	);
  
endmodule
