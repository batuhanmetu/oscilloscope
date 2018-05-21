module ampfinddeneme(clk,data_in,amp,mean,maks,min,data_prev);
input [11:0] data_in;
input clk;

 output reg [11:0] maks ;
 output reg [11:0] min ;
 output reg [11:0] data_prev;

 reg [2:0] slope;
 reg [2:0] prevslope;
 integer isDC;
 integer sayac;
integer set;

output reg [11:0] amp;
output reg [11:0] mean;

parameter clk_freq = 1000000;
initial
	begin
		maks =0;
		min =4095;
		sayac= 0;
		isDC = 0;
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
					isDC = isDC + 1;
				end
				
			if ( data_in <= min)
					begin
						min = data_in;
					end
			if( data_in >= maks)
					begin
						maks = data_in;
					end
					
		
		if (( isDC > 100) || ( slope == 2 && prevslope ==1))
					begin
						sayac = sayac + 1;
						set = 1;
					end
				
				
		if( set == 1)
			begin
				amp = (maks - min)/2;
				mean = (maks + min)/2;
				set = 0;
				isDC = 0;
			end
			
		if( sayac > 10)
			begin
						min = 4095;
						maks = 0;
						sayac = 0;				
			end
			data_prev = data_in;	
			prevslope = slope;
		end
		
	endmodule