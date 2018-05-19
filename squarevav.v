module squarevav(freq,bias,p2p,clk,data_out);
    input clk;
	 input [10:0] p2p;
	 input [10:0] bias;
	 input freq;
    output reg [11:0] data_out;
	 reg prevfreq; 
	  integer inc;
	 initial
		begin
			inc = 1;
		end
	 always @(posedge clk)
		begin
			if(freq != prevfreq)
				begin
					inc = (-1)*inc;
				end
			data_out <=  bias + inc*p2p/2 ;
			prevfreq = freq ;
		end
	endmodule