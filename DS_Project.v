`timescale 1s / 1fs
module ram(clk,index,write,data_in,data_out);
input clk,write;
input [32:0]index;
input [15:0]data_in;
output reg [15:0]data_out;
reg [15:0]data[0:790387];
always @(posedge clk)
begin
    if(write)
        data[index] <= data_in;
    else
        data_out <= data[index];
end
endmodule

`timescale 1s/1fs
module ram_t();
/*
Sizes and shapes of weights(+ biases stacked on top as birst row) (fro w0 to w7)
314384 (400, 784)
80400 (200, 400)
600 (2, 200)
600 (2, 200)
402 (200, 2)
80200 (400, 200)
314000 (784, 400)
Maximum bits required :  14.999516
Total numbers needed to store :  790586)
*/
reg [15:0]captured_data;
integer scan_file;
integer i;
integer data_file;
initial
begin
  data_file = $fopen("numbers.txt", "r");
  if (data_file == 0) 
  begin
    $display("data_file handle was NULL");
    $finish;
  end
  else
  begin
    $display("read");
  end
end
reg clk,write;
reg [32:0]index;
wire [15:0]data_out;
reg [15:0]data_in;
ram uut(clk,index,write,data_in,data_out);
initial begin
    clk=0; write=1;
    index= 0;
    forever #1 clk = ~clk;
end
initial begin
    // next d_in numbers are for the bias and then from there, there are d_out clusters of d_in numbers for each row of weight matrix.
    // I am putting all that in a single array.
    for(i=0;i<790388;i=i+1)
    begin
        scan_file = $fscanf(data_file, "%d\n", captured_data); 
        index = i;
        data_in = captured_data;
        #2;
    end
    $finish;
end
endmodule
