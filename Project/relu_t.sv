module ReLu_t();
reg signed [7:0]x[0:2] = {12,-100,21}; //a vector
wire signed [4:0]y[0:2]; //output
reg clk,reset,done; //controls
ReLu #(8,5,1,3) uut(clk,reset,x,y,done);
initial begin 
    clk = 0;
	forever #1 clk = ~clk;
end
initial begin
	reset=1;
	#5;
	reset=0;
	#10;
	$finish;
end
endmodule
