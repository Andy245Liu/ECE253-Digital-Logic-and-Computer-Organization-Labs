module T_FF(Clock, T, Clear_b, Q);
    input T, Clock, Clear_b;
    output reg Q;

    always @(posedge Clock)
    begin
        if (Clear_b == 1'b0)
            Q <= 0;
        else
            Q <= Q^T;
    end
endmodule


module part1(Clock, Enable, Clear_b, CounterValue);
    input Clock, Enable, Clear_b;
    output reg [7:0] CounterValue;
    wire T1, T2, T3, T4, T5, T6, T7;
    wire q1, q2, q3, q4, q5, q6, q7, q8;

    // instantiate TFF 8 times and add in the adder logic between each instance

    T_FF U0(.Clock(Clock), .T(Enable), .Clear_b(Clear_b), .Q(q1));
    assign T1 = q1 & Enable;
    T_FF U1(.Clock(Clock), .T(T1), .Clear_b(Clear_b), .Q(q2));
    assign T2 = q2 & T1;
    T_FF U2(.Clock(Clock), .T(T2), .Clear_b(Clear_b), .Q(q3));
    assign T3 = q3 & T2;
    T_FF U3(.Clock(Clock), .T(T3), .Clear_b(Clear_b), .Q(q4));
    assign T4 = q4 & T3;
    T_FF U4(.Clock(Clock), .T(T4), .Clear_b(Clear_b), .Q(q5));
    assign T5 = q5 & T4;
    T_FF U5(.Clock(Clock), .T(T5), .Clear_b(Clear_b), .Q(q6));
    assign T6 = q6 & T5;
    T_FF U6(.Clock(Clock), .T(T6), .Clear_b(Clear_b), .Q(q7));
    assign T7 = q7 & T6;
    T_FF U7(.Clock(Clock), .T(T7), .Clear_b(Clear_b), .Q(q8));

    // assign all values at once to the output reg
    always @(*)
    begin
        CounterValue[0] <= q1;
        CounterValue[1] <= q2;
        CounterValue[2] <= q3;
        CounterValue[3] <= q4;
        CounterValue[4] <= q5;
        CounterValue[5] <= q6;
        CounterValue[6] <= q7;
        CounterValue[7] <= q8;
    end

endmodule