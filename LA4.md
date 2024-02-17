### Modules

```
`timescale 1ns/1ps
module left_shift_register_16(In,A,D,clk,E,load);
   input In,clk,E,load;
   input [15:0]D;
   output reg [15:0]A;
   always @(posedge clk,posedge load)
   begin
       if(load)
           A <= D;
       else if(E)
           begin
           A[15] <= A[14];
           A[14] <= A[13];
           A[13] <= A[12];
           A[12] <= A[11];
           A[11] <= A[10];
           A[10] <= A[9];
           A[9] <=  A[8];
           A[8] <=  A[7];
           A[7] <=  A[6];
           A[6] <=  A[5];
           A[5] <=  A[4];
           A[4] <=  A[3];
           A[3] <=  A[2];
           A[2] <=  A[1];
           A[1] <=  A[0];
           A[0] <= In;
           end
       else
           A <= A;
   end
endmodule

module left_shift_register_8(In,A,D,clk,E,load);
   input In,clk,E,load;
   input [7:0]D;
   output reg [7:0]A;
   always @(posedge clk,posedge load)
   begin
       if(load)
           A <= D;
       else if(E)
           begin
           A[7] <=  A[6];
           A[6] <=  A[5];
           A[5] <=  A[4];
           A[4] <=  A[3];
           A[3] <=  A[2];
           A[2] <=  A[1];
           A[1] <=  A[0];
           A[0] <= In;
           end
       else
           A <= A;
   end
endmodule


module right_shift_register_8(In,B,D,clk,E,load);
   input In,clk,E,load;
   input [7:0]D;
   output reg [7:0]B;
   always @(posedge clk,posedge load)
   begin
       if(load)
           B <= D;
       else if(E)
           begin
           B[7] <= In;
           B[6] <= B[7];
           B[5] <= B[6];
           B[4] <= B[5];
           B[3] <= B[4];
           B[2] <= B[3];
           B[1] <= B[2];
           B[0] <= B[1];
           end
       else
           B <= B;
   end
endmodule

module right_shift_register_4(In,B,D,clk,E,load);
   input In,clk,E,load;
   input [3:0]D;
   output reg [3:0]B;
   always @(posedge clk,posedge load)
   begin
       if(load)
           B <= D;
       else if(E)
           begin
           B[3] <= In;
           B[2] <= B[3];
           B[1] <= B[2];
           B[0] <= B[1];
           end
       else
           B <= B;
   end
endmodule

module adder_1bit(A,B,Cin,S,Cout);
input A,B,Cin;
output Cout,S;
wire s;
xor(s,A,B);
and(C,A,B);
and(D,Cin,s);
or(Cout,C,D);
xor(S,s,Cin);
endmodule

module adder_16(P,A,S);
   //input reset;
   input [15:0]P,A;
   output wire [15:0]S;
   wire [15:0]C;
adder_1bit A1(P[0],A[0],0,S[0],C[0]);
adder_1bit A2(P[1],A[1],C[0],S[1],C[1]);
adder_1bit A3(P[2],A[2],C[1],S[2],C[2]);
adder_1bit A4(P[3],A[3],C[2],S[3],C[3]);
adder_1bit A5(P[4],A[4],C[3],S[4],C[4]);
adder_1bit A6(P[5],A[5],C[4],S[5],C[5]);
adder_1bit A7(P[6],A[6],C[5],S[6],C[6]);
adder_1bit A8(P[7],A[7],C[6],S[7],C[7]);
adder_1bit A9(P[8],A[8],C[7],S[8],C[8]);
adder_1bit A10(P[9],A[9],C[8],S[9],C[9]);
adder_1bit A11(P[10],A[10],C[9],S[10],C[10]);
adder_1bit A12(P[11],A[11],C[10],S[11],C[11]);
adder_1bit A13(P[12],A[12],C[11],S[12],C[12]);
adder_1bit A14(P[13],A[13],C[12],S[13],C[13]);
adder_1bit A15(P[14],A[14],C[13],S[14],C[14]);
adder_1bit A16(P[15],A[15],C[14],S[15],C[15]);
endmodule

module adder_8(P,A,S);
   //input reset;
   input [7:0]P,A;
   output wire [7:0]S;
   wire [7:0]C;
adder_1bit A1(P[0],A[0],0,S[0],C[0]);
adder_1bit A2(P[1],A[1],C[0],S[1],C[1]);
adder_1bit A3(P[2],A[2],C[1],S[2],C[2]);
adder_1bit A4(P[3],A[3],C[2],S[3],C[3]);
adder_1bit A5(P[4],A[4],C[3],S[4],C[4]);
adder_1bit A6(P[5],A[5],C[4],S[5],C[5]);
adder_1bit A7(P[6],A[6],C[5],S[6],C[6]);
adder_1bit A8(P[7],A[7],C[6],S[7],C[7]);
endmodule


module register_16(P,S,E,clk,reset);
   input reset;
   input [15:0]S;
   output reg [15:0]P;
   input clk,E;
   always @(posedge clk,posedge reset)
   begin
       if(reset)
           P <= 0;
       else if(E)
           P <= S;
       else
           P <= P;
   end
endmodule

module register_8(P,S,E,clk,reset);
   input reset;
   input [7:0]S;
   output reg [7:0]P;
   input clk,E;
   always @(posedge clk,posedge reset)
   begin
       if(reset)
           P <= 0;
       else if(E)
           P <= S;
       else
           P <= P;
   end
endmodule

module multiplier_8(DataA, DataB,P,reset,compute,clk);
   input clk;
   input [7:0]DataA,DataB;
   output [15:0]P;
   input reset,compute;
   wire [15:0]A;
   wire [7:0]B;
   wire [15:0]S;
   left_shift_register_16 LSR(0,A,{8'b00000000,DataA},clk,compute,reset); //16 bit
   right_shift_register_8 RSR(0,B,DataB,clk,compute,reset); //8 bit
   adder_16 ADD(P,A,S);
   wire compute_n_B0;
   and(compute_n_B0,compute,B[0]);
   register_16 R(P,S,compute_n_B0,clk,reset);
endmodule

module multiplier_4(DataA, DataB,P,reset,compute,clk);
   input clk;
   input [3:0]DataA,DataB;
   output [7:0]P;
   input reset,compute;
   wire [7:0]A;
   wire [3:0]B;
   wire [7:0]S;
   left_shift_register_8 LSR(0,A,{4'b0000,DataA},clk,compute,reset); //8 bit
   right_shift_register_4 RSR(0,B,DataB,clk,compute,reset); //4 bit
   adder_8 ADD(P,A,S);
   wire compute_n_B0;
   and(compute_n_B0,compute,B[0]);
   register_8 R(P,S,compute_n_B0,clk,reset);
endmodule
```

### Test Bench

```
`timescale 1ns/1ps
module test_multiplier_4();
   reg [3:0]DataA,DataB;
   wire [7:0]P;
   reg clk,reset,compute;
   multiplier_4 uut(DataA, DataB,P,reset,compute,clk);
   initial begin
       clk = 0;
       reset = 1;
       compute = 0;
       DataA = 7;
       DataB = 7;
       forever #5 clk = ~clk;
   end
   initial begin
       #10;
       compute = 1;reset = 0;
       #50;
       DataA=8;DataB=8;
       reset=1;compute=0;
       #10;
       reset=0;compute=1;
       #50;
       $finish;
   end
endmodule

module test_multiplier_8();
   reg [7:0]DataA,DataB;
   wire [15:0]P;
   reg clk,reset,compute;
   multiplier_8 uut(DataA, DataB,P,reset,compute,clk);
   initial begin
       clk = 0;
       reset = 1;
       compute = 0;
       DataA = 15;
       DataB = 7;
       forever #5 clk = ~clk;
   end
   initial begin
       #10;
       compute = 1;reset = 0;
       #50;
       DataA=30;DataB=30;
       reset=1;compute=0;
       #10;
       reset=0;compute=1;
       #50;
       $finish;
   end
endmodule
```
