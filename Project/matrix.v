`timescale 1s/1ps
module matrix #(parameter bits=8,outbits=24, row_size=10, column_size=10)(clk,reset,x,M,b,y,done
//,row_done,product,acc
);
input clk;
input reset;
input signed [bits-1:0] x[0:row_size-1];
input signed [bits-1:0] M[0:row_size*column_size -1];
input signed [outbits-1:0] b[0:column_size-1];
output reg signed [outbits-1:0] y[0:column_size-1];
output reg done;
//output 
reg signed [outbits-1:0]acc;
//output 
reg signed [2*bits-1:0]product;
integer addr_in = 0;
integer addr_out = 0;
//output 
reg row_done;
always @(posedge clk) begin
	if(reset) begin
		addr_in = 0;
		addr_out = 0;
		row_done = 0;
		done = 0;
		acc = 0;
	end else if(!done) begin
		if(row_done) begin
			if(addr_out < column_size) begin
				addr_in = 0;
				acc = 0;
				row_done =0;
				product = product;
			end else begin
				done =1;
			end
		end else begin
			if(addr_in < row_size) begin
				product = x[addr_in]*M[(addr_out*row_size)+addr_in];
				acc = acc + product;
				addr_in = addr_in + 1;
			end else begin
				row_done =1;
				y[addr_out] = acc + b[addr_out];
				addr_out = addr_out + 1;
				acc = acc;
				product = product;
			end
		end
	end
end

endmodule
