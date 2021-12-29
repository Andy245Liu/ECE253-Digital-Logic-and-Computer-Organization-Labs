
// code for part 2

module full_adder(a, b, c_in, s, c_out);
    input a, b, c_in;
    output s, c_out;
    assign s = (a^b)^c_in;
    assign c_out = a & c_in | b & c_in | b & a | b & a & c_in;

endmodule 


module ripple_carry(a, b, c_in, s, c_out);
    // 4-bit ripple carry adder circuit
    // a and b are 4 bit inputs, s is a 4 bit output
    // The c_in and c_out signals are 1 bit
    
    input [3:0] a;
    input [3:0]b;
    input c_in;
    output [3:0] s;
    output [3:0]c_out;
    assign c_out[3] = 0;
    assign c_out[2] = 0;
    assign c_out[1] = 0;
    wire c1, c2, c3;
	
    full_adder F0(a[0], b[0], c_in, s[0], c1);
    full_adder F1(a[1], b[1], c1, s[1], c2);
    full_adder F2(a[2], b[2], c2, s[2], c3);
    full_adder F3(a[3], b[3], c3, s[3], c_out);

endmodule 

//part3
//module ALU(A, B, Function, ALUout);
//	input [3:0] A;
//	input [3:0] B;
//	input [2:0] Function;
//	output [7:0] ALUout;
//	reg [7:0] ALUout;
//	wire [7:0] w0;
//	//assign w0[7] = 0;
//	//assign w0[6] = 0;
//	//assign w0[5] = 0;
//	ripple_carry u1(A, B, 0, w0[3:0], w0[7:4]);
//
//	wire [7:0]w1;
//	assign w1 = {A,B};
//	always @(*) begin 
//        	case (Function[2:0]) 
//        	3'b000: ALUout = w0;
//        	3'b001: ALUout = A + B; 
//        	3'b010: ALUout = {{B[3], B[3], B[3], B[3]},B}; 
//        	3'b011: ALUout = |w1;
//        	3'b100: ALUout = &w1; 
//        	3'b101: ALUout = w1; 
//        	//3'b110: Out = Input[6]; 
//        	default: ALUout = 0; // don't care 
//        // default case so as to ensure all cases are covered
//        	endcase 
//    	end
//endmodule
//module ALU(Function, A, B, q,d);
//	input [2:0] Function;
	//input [3:0] A;
//	input [3:0] B;
//	input [7:0] q;
//	output reg [7:0] d;
	//reg [7:0] d;
	
//	wire [7:0] w0;
//	ripple_carry u1(A, B, 0, w0[3:0], w0[7:4]);

//	wire [7:0]w1;
//	assign w1 = {A,B};
//	always @(*)
//	begin
//		case(Function [2:0])
//		3'b000: d = w0;
//        	3'b001: d = A + B; 
//        	3'b010: d = {{B[3], B[3], B[3], B[3]},B}; 
//        	3'b011: d = |w1;
//        	3'b100: d = &w1; 
//        	3'b101: d = B << A; 
 //       	3'b110: d = A * B; 
//		3'b111: d = 0;
 //       	default: d = 0; // don't care 	
//		endcase
//
//	end
//endmodule

module part2(Clock, Reset_b, Data, Function, ALUout);

	input Clock, Reset_b;
	input [2:0] Function;
	input  [3:0] Data;
	output [7:0] ALUout;
	reg [7:0] d;
	
	reg [7:0] q;
	
	wire [3:0] B;
	wire [7:0] w0;
	ripple_carry u1(Data, q[3:0], 0, w0[3:0], w0[7:4]);
	
	wire [7:0]w1;
	assign w1 = {Data,q[3:0]};

	
	
	
	//ALU A0(.Function(Function[2:0]), .A(Data[3:0]), .B(q[3:0]), .q(q[7:0]),.d(d[7:0]));
	always @(posedge Clock)
	begin
		if(Reset_b == 1'b0)
		
			q<=0;
			
		
		else
	
			q<=d;	

	end
	

	always @(*)
	begin
		case(Function [2:0])
		3'b000: d = w0;
        	3'b001: d = Data + B; 
        	3'b010: d = {{B[3], B[3], B[3], B[3]},B}; 
        	3'b011: d = |w1;
        	3'b100: d = &w1; 
        	3'b101: d = B << Data; 
        	3'b110: d = Data * B; 
		3'b111: d = q;
        	default: d = 0; // don't care 	
		endcase

	end
	

	 //B = q[3:0];
	assign B = q[3:0]; 

	assign ALUout = q;

endmodule



