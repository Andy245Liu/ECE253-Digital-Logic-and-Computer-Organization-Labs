
module v7404 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input pin1, pin3, pin5, pin9, pin11, pin13;
	output pin2, pin4, pin6, pin8, pin10, pin12;
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule;

module v7408 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output pin3, pin6, pin8, pin11;
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
endmodule;


module v7432 (pin1, pin3, pin5, pin9, pin11, pin13,pin2, pin4, pin6, pin8, pin10, pin12);
	input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13;
	output pin3, pin6, pin8, pin11;
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
endmodule;

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
  
endmodule;





module register(ParallelLoadn, right, left, DataIN , RotateRight,  clock, reset, Q);
	input ParallelLoadn, right, left, DataIN , RotateRight,  clock, reset;
	output reg Q;
	//reg w0;
	//reg w1;
	wire w0;
	wire w1;
	mux2to1 M1(right, left, RotateRight,w0);
	mux2to1 M2(DataIN ,w0 ,ParallelLoadn, w1);
	/*always @(*)
	begin
		case(LoadLeft)
		1'b0: w0 = right;
		1'b1: w0 = left;
	end

	begin
		case(loadn)
		1'b0: w1 = D;
		1'b1: w1 = w0;
	end
	*/
	always @(posedge clock)
	begin
		if  (reset == 1'b1)
			Q <= 0;
		else
			Q <= w1;
	end
endmodule
	

module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input ParallelLoadn,  RotateRight,  clock, reset, ASRight;
	input [7:0] Data_IN;
	output reg [7:0] Q;
	//always@(posedge clock)
	wire highest_bit;
	//assign highest_bit = Q[7];
	
	//wire w7a, w7b, w6, w5, w4, w3, w2, w1, w0;
	wire w7, w6, w5, w4, w3, w2, w1, w0;
		//if (ASRight == 1'b1)		
		//register R7a(.ParallelLoadn(ParallelLoadn), .right(Q[6]), .left(Q[7]), .DataIN(Data_IN[7]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w7a));
		//else		
		register R7(.ParallelLoadn(ParallelLoadn), .right(Q[6]), .left(ASRight ? Q[7] : Q[0]), .DataIN(Data_IN[7]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w7));
	
		register R6(.ParallelLoadn(ParallelLoadn), .right(Q[5]), .left(Q[7]), .DataIN(Data_IN[6]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w6));
	
		register R5(.ParallelLoadn(ParallelLoadn), .right(Q[4]), .left(Q[6]), .DataIN(Data_IN[5]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w5));
	
	
		register R4(.ParallelLoadn(ParallelLoadn), .right(Q[3]), .left(Q[5]), .DataIN(Data_IN[4]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w4));
		register R3(.ParallelLoadn(ParallelLoadn), .right(Q[2]), .left(Q[4]), .DataIN(Data_IN[3]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w3));
		register R2(.ParallelLoadn(ParallelLoadn), .right(Q[1]), .left(Q[3]), .DataIN(Data_IN[2]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w2));
		register R1(.ParallelLoadn(ParallelLoadn), .right(Q[0]), .left(Q[2]), .DataIN(Data_IN[1]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w1));
		register R0(.ParallelLoadn(ParallelLoadn), .right(Q[7]), .left(Q[1]), .DataIN(Data_IN[0]) , .RotateRight(RotateRight),  .clock(clock), .reset(reset), .Q(w0));

	always @(*) begin
	//if(ASRight == 1'b1)
		//Q[7] <= w7a;
	//else
		//Q[7] <= w7b;	
	Q[7] <= w7;
	Q[6] <= w6;	
	Q[5] <= w5;
	Q[4] <= w4;
	Q[3] <= w3;
	Q[2] <= w2;
	Q[1] <= w1;
	Q[0] <= w0;
	
	end
	
	
endmodule
	