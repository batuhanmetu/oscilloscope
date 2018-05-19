module main(bias,peak2peak,clk,measuredAmplitude,measuredMean,maks,min,data_prev,sayac);
	//input freq;
	input clk;
	input [10:0] peak2peak;
	input [10:0] bias;
	output  [11:0] measuredMean;
	output  [11:0] measuredAmplitude;
	wire [11:0] data_out1;
	output  [11:0] maks ;
   output  [11:0] min ;
   output  [11:0] data_prev;
	output [4:0] sayac;
	trivav mytrivav(.bias(bias),.p2p(peak2peak),.clk(clk),.data_out(data_out1));
	//squarevav mysquarevav(.freq(freq),.bias(bias),.p2p(peak2peak),.clk(clk),.data_out(data_out1));
	ampfind myampfind(.clk(clk),.data_in(data_out1),.amp(measuredAmplitude),.mean(measuredMean),.maks(maks),.min(min),.data_prev(data_prev));
	
	endmodule