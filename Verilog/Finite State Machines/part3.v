
// DataIn - input data port
// Resetn - synchronous reset
// Go signal starts things
// DataResult - register at output of ALU

module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder);
    input Clock;
    input Resetn;
    input Go;
    	input [3:0] Divisor; // M
	input [3:0] Dividend;
    	output [3:0] Quotient;
	output [4:0] Remainder;

    // lots of wires to connect our datapath and control
    wire div;
    wire   l_q, alu_op;//, load_quotient, load_remainder; //l_a,l_m,
    assign div = {1'b0, Divisor};

    //wire ld_alu_out;
    //wire [1:0]  alu_select_a, alu_select_b;
    //wire alu_op;

    control C0(
        .clk(Clock),
        .resetn(Resetn),

        .go(Go),

        
        //.l_m(l_m),
        .l_q(l_q),
        .alu_op(alu_op)//, .load_quotient(load_quotient),
	//.load_remainder(load_remainder) //.l_a(l_a),
    );

    datapath D0(
        .clk(Clock),
        .resetn(Resetn),
        .M(div), // M
        .Dividend(Dividend),
        .Quotient(Quotient),
        .Remainder(Remainder),

          .l_q(l_q), .alu_op(alu_op)//,.load_quotient(load_quotient),
	//.load_remainder(load_remainder)//.l_a(l_a), .l_m(l_m),
    );

 endmodule


module control(
    input clk,
    input resetn,
    input go,

    output reg   l_q,//l_a,l_m,
    output reg alu_op
	//output reg load_quotient,
	//output reg load_remainder

    //output reg  ld_a, ld_b, ld_c, ld_x, ld_r,
    //output reg  ld_alu_out,
    //output reg [1:0]  alu_select_a, alu_select_b,
    );

    reg [5:0] current_state, next_state; // FSM logic

   
    localparam  S_LOAD_Q        = 5'd0,
                S_LOAD_Q_WAIT   = 5'd1,
                S_CYCLE_0       = 5'd2,
                S_CYCLE_1       = 5'd3,
		S_CYCLE_2 	= 5'd4,
                S_CYCLE_3       = 5'd5;
                
                


    // Next state logic aka our state table
    always@(*)
    begin: state_table
            case (current_state)
                //S_LOAD_A: next_state = go ? S_LOAD_A_WAIT : S_LOAD_A; // Loop in current state until value is input
                //S_LOAD_A_WAIT: next_state = go ? S_LOAD_A_WAIT : S_LOAD_M; // Loop in current state until go signal goes low
                //S_LOAD_M: next_state = go ? S_LOAD_M_WAIT : S_LOAD_M; // Loop in current state until value is input
                //S_LOAD_M_WAIT: next_state = go ? S_LOAD_M_WAIT : S_LOAD_Q; // Loop in current state until go signal goes low
                S_LOAD_Q: next_state = go ? S_LOAD_Q_WAIT : S_LOAD_Q; // Loop in current state until value is input
                S_LOAD_Q_WAIT: next_state = go ? S_LOAD_Q_WAIT : S_CYCLE_0; // Loop in current state until go signal goes low
                S_CYCLE_0: next_state = S_CYCLE_1;
                S_CYCLE_1: next_state = S_CYCLE_2;
		S_CYCLE_2: next_state = S_CYCLE_3;
                S_CYCLE_3: next_state = S_LOAD_Q;
                

                 // we will be done our 4 operations, start over after (then again waiting for the go signal until all inputs are valid (for dividend, and diviser))
            default:     next_state = S_LOAD_Q;
        endcase
    end // state_table



    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
        
        l_q = 1'b0;
        alu_op = 1'b0;
	//load_quotient = 1'b0;
	//load_remainder = 1'b0;


        case (current_state)
			// just loading the values first before go
           /* S_LOAD_A: begin
                l_a = 1'b1;
                end*/
            /*S_LOAD_M: begin
                l_m = 1'b1;
                end*/
            S_LOAD_Q: begin
                l_q = 1'b1;
		alu_op = 1'b0; 
		//load_quotient = 1'b0;
		//load_remainder = 1'b0;
                end


            /// IMPORTANT !!!!
			// manipulations after go
            // 12 cycles (4 times 3) ? or 4 ???? DOUBT 


            S_CYCLE_0: begin //
		//l_m = 1'b0;
		l_q = 1'b0;
                alu_op = 1'b1; // shift left signal
            end
            S_CYCLE_1: begin
                alu_op = 1'b1; // A <= A - M
            end
	    S_CYCLE_2: begin
                alu_op = 1'b1; // A <= A + M (if A now negative)
            end

            ////////////////////////////////////////////
            S_CYCLE_3: begin
                alu_op = 1'b1; // shift left signal
		//load_quotient = 1'b1
//load_remainder = 1'b1;
            end
            



        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals

    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(!resetn)
            current_state <= S_LOAD_Q;
        else
            current_state <= next_state;
    end // state_FFS
endmodule





module datapath(
    input clk,
    input resetn,
    input [4:0] M, // M
	input [3:0] Dividend,
    output reg [4:0] Quotient,
	output reg [3:0] Remainder,

    input   l_q, alu_op//, load_quotient, load_remainder //l_a,l_m,
    );

    // DECLARE REGISTERS
	//reg [4:0] A; // load 0 then shift left
    //reg [4:0] M; // the divisor // const
    //reg [3:0] Q; // load the dividend
	//reg [3:0] Quotient;
	//reg [3:0] Remainder;


    // LOAD THE APPROPRIATE VALUES INTO THE REGISTERS AT THE START
    // all the same registors are changed under one always block
    always@(posedge clk)
    begin
        if(!resetn)
        begin
            // loading the values initially (after go set to zero in control path)
            //if (l_a)
                Remainder = 5'b0;
            /*if (l_m)
                M <= 5'b00001;*/
            //if (l_q)
                Quotient = 4'b0;
		 //Quotient <= 4'b0;
		//Remainder <= 5'b0; 
		
        end

        else
		begin
		
	    	/*if (l_a)
                	A <= 5'b0;*/
            	/*if (l_m)
                	M <= Divisor;*/
		
            	if (l_q)
		begin
                	Quotient = Dividend;
			Remainder = 5'b0;
		end
		
        	end
		
			
   end
	 // Output result register
    /*always@(posedge clk) begin
        if(!resetn) begin
           
        end
        else 
	begin
            
	end
    end*/

 
    always@(*)
            begin
		if(alu_op == 1'b1) 
			begin
			Remainder = {Remainder[3:0],Quotient[3]};
                    	Quotient = Quotient<<1;
			Remainder = Remainder - M;
			if (Remainder[4]) // if negative A after subtracting M (M >= A (og value))
				begin
                        	Remainder = Remainder + M;
				Quotient[0] = 1'b0;
				end
 			
                    	else
				begin
                        	//A = A;
				Quotient[0] = 1'b1;
				end
		end
		else	
		begin
			Remainder = Remainder;
			Quotient = Quotient;
		end
/*
		if (load_quotient == 1'b1)
			Quotient = Q;
	   	if (load_remainder == 1'b1)
			Remainder = A;*/
	end
    
endmodule


