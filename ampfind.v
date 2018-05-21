module ampfind(clk,data_in,amp,mean,maks,min,data_prev);
input [11:0] data_in;
input clk;

 output reg [11:0] maks ;
 output reg [11:0] min ;
 output reg [11:0] data_prev;

 reg [2:0] trend;
 reg [2:0] state;
 integer sayac;
integer set;

output reg [11:0] amp;
output reg [11:0] mean;

parameter clk_freq = 1000000;
initial
	begin
		maks =0;
		min =4095;
		state= 0;
		sayac= 0;
		
	end

	always @(posedge clk)
		begin
			if(data_prev > data_in ) 	
				begin
					trend = 2; //decrease
				end
			else if ( data_in > data_prev )	
				begin
					trend = 1; //increase
				end
			else 
				begin
					trend = 0; // constant
				end
			
		case (state)
			0:	begin					//state 0
				
				if( trend == 1)
					begin
						state = 1;
					end
				end
			1:						//state 1				
				if(trend == 2)
					begin
						sayac = 0;
						state = 2;
					end
			2:begin				//state 2
				if ( data_in <= min)
					begin
						min = data_in;
					end
				
				if(trend == 1)
					begin
						state = 3;
					end
					set = 0;
				end
			3:begin				//state 3
				if( data_in >= maks)
					begin
						maks = data_in;
					end
				if(trend == 2)
					begin
						state = 2;
						sayac = sayac + 1;
						set = 1;
					end
				end
				
		endcase
			if (trend == 0 && state == 0)
					begin
						sayac = sayac + 1;
					end	
		if( set == 1)							//set
			begin
				amp = (maks - min)/2;
				mean = (maks + min)/2;
			end
		if( sayac > 10)
			begin
				if ( trend == 0)               //reset 1
					begin
						maks = data_prev;
						min = data_prev;
						state = 0;
						sayac = 0;
						amp=0;
						mean=data_prev;
					end
				else									//reset 2
					begin
						state = 0;
						min = 4095;
						maks = 0;
						sayac = 0;
					end	
			end
			data_prev = data_in;	
		end
		
	endmodule
