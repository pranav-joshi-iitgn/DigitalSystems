module layer_t();
reg signed [7:0]x[0:2] = {1,1,1}; //input
reg signed [7:0]M[0:8] = //weights
{
1,-1,0,
1,1,0,
0,0,1
};
reg signed [7:0]b[0:2] = {0,0,-5}; //bias
wire signed [7:0]y[0:2]; //output
reg clk,reset,done; //controls
layer #(8,8,0,3,3) uut(clk,reset,x,M,b,y,done);
initial begin 
    clk = 0;
	forever #1 clk = ~clk;
end
initial begin
	reset=1;
	#5;
	reset=0;
	#100;
	$finish;
end
endmodule
