module layer #(parameter bits=8, max_bits=8, shift=0, row_size=10, column_size=10)(clk,reset,x,M,b,y,done);
input clk;
input reset;
input signed [bits-1:0] x[0:row_size-1];
input signed [bits-1:0] M[0:row_size*column_size -1];
input signed [max_bits-1:0] b[0:column_size-1];
wire signed [max_bits-1:0] Y[0:column_size-1];
output signed [bits-1:0] y[0:column_size-1];
output done;
wire mul_done;
matrix #(bits,max_bits,row_size,column_size) Mat(clk,reset,x,M,b,Y,mul_done);
ReLu #(max_bits,bits,shift,column_size) R(clk,~mul_done,Y,y,done);
endmodule
