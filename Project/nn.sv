`timescale 1s/1ps
module NN(clk,reset,x,y,done);
input clk,reset;
output done;
input signed [17:0]x[0:1];
output signed [17:0]y[0:783];
wire done5,done6;
wire signed [17:0]y5[0:19];
layer5 L5(clk,reset,x,y5,done5);
layer6 L6(clk,~done5,y5,y,done);
endmodule
