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
    //assign c_out[3] = 0;
    //assign c_out[2] = 0;
    //assign c_out[1] = 0;
    //wire c1, c2, c3;
 

    full_adder F0(a[0], b[0], c_in, s[0], c_out[0]);
    full_adder F1(a[1], b[1], c_out[0], s[1], c_out[1]);
    full_adder F2(a[2], b[2], c_out[1], s[2], c_out[2]);
    full_adder F3(a[3], b[3], c_out[2], s[3], c_out[3]);
    


endmodule 