`timescale 1ns/1ps
module matrix_t();
reg signed [7:0]x[0:2] = {1,1,1}; //a vector
reg signed [7:0]M[0:8] = //a matrix
{
1,-1,0,
1,1,0,
0,0,1
};
reg signed [7:0]b[0:2] = {0,0,1}; //bias
wire signed [23:0]y[0:2]; //output
reg clk,reset,done; //controls
//reg row_done; 
//reg signed [15:0]product; //just for debugging
//reg signed [23:0]acc; //just for debugging
matrix #(8,3,3) uut(clk,reset,x,M,b,y,done
//,row_done,product,acc
);
initial begin 
    clk = 0;
	forever #1 clk = ~clk;
end
initial begin
	reset=1;
	#5;
	reset=0;
	#50;
	$finish;
end
endmodule
