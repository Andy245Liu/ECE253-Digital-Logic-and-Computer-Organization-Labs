// code for part 2

module full_adder(a, b, c_in, s, c_out);
    input a, b, c_in;
    output s, c_out;
    assign s = (a^b)^c_in;
    assign c_out = a & c_in | b & c_in | b & a | b & a & c_in;

endmodule 


module part2(a, b, c_in, s, c_out);
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
module part3(A, B, Function, ALUout);
	input [3:0] A;
	input [3:0] B;
	input [2:0] Function;
	output [7:0] ALUout;
	reg [7:0] ALUout;
	wire [7:0] w0;
	//assign w0[7] = 0;
	//assign w0[6] = 0;
	//assign w0[5] = 0;
	part2 u1(A, B, 0, w0[3:0], w0[7:4]);

	wire [7:0]w1;
	assign w1 = {A,B};
	always @(*) begin 
        	case (Function[2:0]) 
        	3'b000: ALUout = w0;
        	3'b001: ALUout = A + B; 
        	3'b010: ALUout = {{B[3], B[3], B[3], B[3]},B}; 
        	3'b011: ALUout = |w1;
        	3'b100: ALUout = &w1; 
        	3'b101: ALUout = w1; 
        	//3'b110: Out = Input[6]; 
        	default: ALUout = 0; // don't care 
        // default case so as to ensure all cases are covered
        	endcase 
    	end
endmodule