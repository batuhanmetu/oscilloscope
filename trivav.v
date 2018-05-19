module trivav(bias,p2p,clk,data_out);
    input clk;
	 input [10:0] p2p;
	 input [10:0] bias;
    output reg [11:0] data_out;
	 integer sayac;
	  integer inc;
	 initial
		begin
			sayac = 0;
			inc = 1;
		end
	 always @(posedge clk)
		begin
			if((inc == 1 && sayac >= p2p) || (inc == -1 && sayac <= 0))
				begin
					inc = (-1)*inc;
				end
			if (p2p == 0)
				begin
					inc = 0;
				end
			sayac = sayac + inc;
			data_out <= sayac + bias - p2p/2 ;
		end
	endmodule