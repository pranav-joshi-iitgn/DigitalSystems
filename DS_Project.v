`timescale 1ns / 1ps
module read();
reg [15:0]w[0:790585];
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
integer i,scan_file;
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
initial begin
    // next d_in numbers are for the bias and then from there, there are d_out clusters of d_in numbers for each row of weight matrix.
    // I am putting all that in a single array.
    for(i=0;i<790586;i=i+1)
    begin
        scan_file = $fscanf(data_file, "%d\n", captured_data); 
        w[i] = captured_data;
    end
    #10;
end
endmodule
