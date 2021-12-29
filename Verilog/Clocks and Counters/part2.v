/*module RateDivider(ClockIn, Speed, counter);

	input [1:0] Speed;
	
	output reg Enable;
	parameter reg n;
	reg [n-1:0] load;
	output reg [n-1:0] counter;

	always @ (*)
	begin
	case(speed)
		2'b00 : begin 
				n = 1;
				load = 0;
			end
		2'b01 : begin 
				n = 26;
				load = 26b'10111110101111000001111111;
			end
		2'b10 :begin 
				n = 27;
				load = 27'b101111101011110000011111111;
			end
		2'b11 : begin 
				n = 28;
				load = 28'b1011111010111100000111111111;
			end
	end
	
	always@(posedge clockIN)
	begin
		if(count == 0)
			count <= load;
			///Enable <= 1;
		count <= count - 1;
	end
endmodule*/
		

/*module RateDivider(clockIn, speed, resetn, counter);

	input [1:0] speed;
	input clockIn;
        input resetn;
	
	
	reg [28:0] counter;
	
	
	
	always@(posedge clockIn)
	begin
		if(resetn == 1'b0)
		begin
		counter <= 0;
		end
		if(counter == 0) begin
			if(speed == 2'b00)
				counter <= 0;
			else if(speed == 2'b01)
				counter <= 28'b0010111110101111000001111111;
			else if (speed == 2'b10)
				counter <= 28'b0101111101011110000011111111;
			else if(speed == 2'b11)
				counter <= 28'b1011111010111100000111111111;
		end
			
		counter <= counter - 1;
	end
endmodule*/

module RateDivider(ClockIn, speed, resetn, enable );
    
    input [1:0] speed;
       input ClockIn;
    input resetn;
    output reg enable;
    reg [10:0] counter;

    always @(posedge ClockIn)
    begin

    if (resetn == 1)  // active high reset (to init counter)
    begin
        counter <= 11'b00000000000;    
    end    
    else if (counter == 0)
        begin
        enable <= 1;

        if (speed == 2'b00)
        begin
                    counter <= 11'b00000000000;
            //enable <= 1;
        end

        else if (speed == 2'b01)
        begin
                    counter <= 11'b00111110011;
            //enable <= 1;
        end

        else if (speed == 2'b10)
        begin    
                       counter <= 11'b01111100111;
            //enable <= 1;
        end 
        else if (speed == 2'b11)
        begin 
                    counter <= 11'b11111001111;
            //enable <= 1;
        end
    end
    else 
    	begin
           counter <= counter-1;
       	   enable <= 0;
    	end
    end

endmodule


module part2(ClockIn, Reset, Speed, CounterValue );
    input ClockIn, Reset;
    //reg Enable;

    input [1:0] Speed;
    output reg [3:0] CounterValue; // output hex numbers 0 to F
    reg enable; 
	reg [10:0] counter;
    
    //output [10:0] counter;

   // RateDivider R0 (.ClockIn(ClockIn), .speed(Speed), .resetn(Reset), .enable(enable));//, .counter(counter));



    always @(posedge ClockIn)
        begin
            
        
	if (Reset == 1)  // active high reset (to init counter)
    		begin
        	counter <= 11'b00000000000; 
		CounterValue  <= 0;   
    		end
	else
		begin 
		if (counter == 0)
    			begin
        		//enable <= 1;
			CounterValue <= (CounterValue == 4'b1111)? 0 : CounterValue + 1;
			

        		if (Speed == 2'b00)
        			begin
                    		counter <= 11'b00000000000;
            //enable <= 1;
       				 end

        		else if (Speed == 2'b01)
        			begin
                   		 counter <= 11'b00111110011;
            //enable <= 1;
       				 end

        		else if (Speed == 2'b10)
        			begin    
                      		 counter <= 11'b01111100111;
            //enable <= 1;
        			end 
        		else if (Speed == 2'b11)
        			begin 
                    		counter <= 11'b11111001111;
            //enable <= 1;
        			end
    			end
    		else 
    			begin
           		counter <= counter-1;
       	   		enable <= 0;
    			end

		end   
     



        //else if (ParLoad == 1'b1)// Check parallel load
           //q <= d;

        //else if ( == 4'b1111)
            //CounterValue <= 0;
/*if (Reset == 1'b1)
      
else if (enable == 1'b1)
       CounterValue <= (CounterValue == 4'b1111)? 0 : CounterValue + 1;*/
     end
endmodule
		
			
			

