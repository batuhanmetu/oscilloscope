module ampfind2(clk,data_in,amp,mean,maks,min,data_prev);
input [11:0] data_in;
input clk;

 output reg [11:0] maks ;
 output reg [11:0] min ;
 output reg [11:0] data_prev;

 reg [2:0] slope;
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
					slope = 2; //decrease
				end
			else if ( data_in > data_prev )	
				begin
					slope = 1; //increase
				end
			else 
				begin
					slope = 0; // constant
				end
			
		case (state)
			0:	begin
				if( slope == 1)
					begin
						state = 1;
					end
				end
			1:
				if(slope == 2)
					begin
						state = 2;
					end
			2:begin
				if ( data_in <= min)
					begin
						min = data_in;
					end
				
				if(slope == 1)
					begin
						state = 3;
					end
					set = 0;
				end
			3:begin
				if( data_in >= maks)
					begin
						maks = data_in;
					end
				if(slope == 2)
					begin
						state = 2;
						sayac = sayac + 1;
						set = 1;
					end
				end
				
		endcase
		if (slope == 0)
					begin
						sayac = sayac + 1;
						state = 0;
					end	
		if( set == 1)
			begin
				amp = (maks - min)/2;
				mean = (maks + min)/2;
			end
		if( sayac > 10)
			begin
				if ( slope == 0)
					begin
						maks = data_prev;
						min = data_prev;
						state = 0;
						sayac = 0;
						amp=0;
						mean=data_prev;
					end
				else
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