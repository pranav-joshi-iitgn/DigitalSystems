module NN_t();
reg signed [17:0]x[0:1] = {40000,40000}; // write numbers at the scale of 2**-15
wire signed [17:0]y[0:783];
reg clk,reset;
wire done;
NN uut(clk,reset,x,y,done);
initial begin 
    clk = 0;
	forever #1 clk = ~clk;
end
initial begin
	reset=1;
	#10;
	reset=0;
	#100000;
	$finish;
end
endmodule
