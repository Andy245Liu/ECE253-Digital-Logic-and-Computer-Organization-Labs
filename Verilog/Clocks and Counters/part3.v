
module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	

	input ClockIn, Resetn, Start;
	input [2:0] Letter;
	reg [11:0] code;
	output reg DotDashOut;

	//reg [7:0] counter;
	wire enable;
	RateDivider rate_div(ClockIn, Resetn, Start,enable);
	always @(*)


	begin
		case(Letter)
			3'b000: if(Start == 1'b1) begin 
				code <= 12'b101110000000;
				end
			3'b001: if(Start == 1'b1) begin
				code <= 12'b111010101000;
				end
			3'b010: if(Start == 1'b1) begin
				code <= 12'b111010111010;
				end
			3'b011: if(Start == 1'b1) begin
				code <= 12'b111010100000;
				end
			3'b100: if(Start == 1'b1) begin
				code <= 12'b100000000000;
				end
			3'b101: if(Start == 1'b1) begin
				code <= 12'b101011101000;
				end
			3'b110: if(Start == 1'b1) begin
				code <= 12'b111011101000;
				end
			3'b111: if(Start == 1'b1) begin
				code <= 12'b101010100000;
				end
			default: if(Start == 1'b1) begin
				code <= 12'b000000000000;
				end
		endcase
		if(Resetn == 1'b0) begin
			code <= 12'b000000000000;
		end	
		
	end
	
	/*always@(*)
	begin
		
		
	end*/
	
	always@(posedge ClockIn)
	begin 
		
		if(enable == 1'b1) begin
			DotDashOut <= code[11];
			code <= {code[10:0], code[11]};
		end
		
	end
endmodule





//module ShiftRegister(ClockIn,code, Start, Resetn, Dot)

module RateDivider(ClockIn, Resetn, Start, enable);

	//input [1:0] speed;
	input ClockIn, Resetn, Start;
	
	
	reg [7:0] counter = 8'b11111010;
	output reg enable;
	
	/*always@ (*)
	begin
		if(Resetn == 1'b0 ) begin
			//counter<= 25'b1011111010111100001000000; 
			counter <= 8'b11111010;
		end
	

	end*/	
	always@(posedge ClockIn)
	begin
		enable <= (counter == 0)? 1'b1 : 1'b0;
		if(counter == 0) begin
			//counter<= 25'b1011111010111100001000000;
			
			counter <= 8'b11111010;
		end
		
		/*else if(Resetn == 1'b0 ) begin
			//counter<= 25'b1011111010111100001000000; 
			counter <= 8'b11111010;
		end*/
			
		else begin
			counter <= counter - 1;
		end
		
	end
endmodule
			
			

/*module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	input ClockIn, Resetn, Start;
	input [2:0] Letter;
	reg [11:0] code;
	output reg DotDashOut;

	//reg [7:0] counter;
	wire enable;
	RateDivider rate_div(ClockIn, Resetn, Start,enable);
	always @(*)
	begin
		case(Letter)
			3'b000: if(Start == 1'b1) begin 
				code <= 12'b101110000000;
				end
			3'b001: if(Start == 1'b1) begin
				code <= 12'b111010101000;
				end
			3'b010: if(Start == 1'b1) begin
				code <= 12'b111010111010;
				end
			3'b011: if(Start == 1'b1) begin
				code <= 12'b111010100000;
				end
			3'b100: if(Start == 1'b1) begin
				code <= 12'b100000000000;
				end
			3'b101: if(Start == 1'b1) begin
				code <= 12'b101011101000;
				end
			3'b110: if(Start == 1'b1) begin
				code <= 12'b111011101000;
				end
			3'b111: if(Start == 1'b1) begin
				code <= 12'b101010100000;
				end
			default: if(Start == 1'b1) begin
				code <= 12'b000000000000;
				end
		endcase
		
	end
	
	always@(*)
	begin
		
		if(Resetn == 1'b0) begin
			code <= 12'b000000000000;
		end	
	end
	
	always@(posedge ClockIn)
	begin 
		
		if(enable == 1'b1) begin
			DotDashOut <= code[11];
			code <= {code[10:0], code[11]};
		end
		
	end
endmodule


//module ShiftRegister(ClockIn,code, Start, Resetn, Dot)

module RateDivider(ClockIn, Resetn, Start, enable);

	//input [1:0] speed;
	input ClockIn, Resetn, Start;
	
	
	reg [7:0] counter = 8'b11111010;
	output reg enable;
	
	/*always@ (*)
	begin
		if(Resetn == 1'b0 ) begin
			//counter<= 25'b1011111010111100001000000; 
			counter <= 8'b11111010;
		end
	

	end*/	
	/*always@(posedge ClockIn)
	begin
		enable <= (counter == 0)? 1'b1 : 1'b0;
		if(counter == 0) begin
			//counter<= 25'b1011111010111100001000000;
			
			counter <= 8'b11111010;
		end
		
		else if(Resetn == 1'b0 ) begin
			//counter<= 25'b1011111010111100001000000; 
			counter <= 8'b11111010;
		end
			
		else begin
			counter <= counter - 1;
		end
		
	end
endmodule*/
			
			