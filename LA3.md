# Modules
```
`timescale 1ns / 1ps

module TFF(T,clk,Q,reset_n,preset_n,load,D);
input T,clk,reset_n,preset_n,load,D;
output reg Q;
always @(posedge clk,negedge reset_n,preset_n)
begin
if(load)
Q<=D;
else if(!reset_n)
Q<=0;
else if(!preset_n)
Q<=1;
else if(T)
Q<=~Q;
else
Q<=Q;
end
endmodule

module counter(Q,En,reset,clk,bcd,up,load,D);
input En,reset,clk,bcd,up,load; //reset=1 means reset here.
inout [3:0]Q;
input [3:0]D;

wire [2:0]Qxd;
not(down,up);
not(bin,bcd);
xor(Qxd[0],Q[0],down);
xor(Qxd[1],Q[1],down);
xor(Qxd[2],Q[2],down);

and(reset_down_bits,~Q[0],~Q[1],~Q[2],~Q[3]);
and(reset_up_order,reset,up);

and(reset_bcd_up_bits,Q[3],Q[0]);
and(reset_bcd_up_con,reset_bcd_up_bits,up,bcd);
and(reset_bcd_down_con,reset_down_bits,~up,bcd);
and(reset_bcd_down_order,reset,bcd,down);
or(reset_bcd_down,reset_bcd_down_con,reset_bcd_down_order);

or(reset_up,reset_bcd_up_con,reset_up_order);

and(reset_bin_down_order,reset,bin,down);

or(ReUp_or_ReBcdDown,reset_up,reset_bcd_down);
or(reset_down,reset_bin_down_order,reset_bcd_down);

and(Q2_flip_con,Qxd[0],Qxd[1]);
and(Q3_flip_con,Qxd[0],Qxd[1],Qxd[2]);

not(reset_up_n,reset_up);
not(ReUp_or_ReBcdDown_n,ReUp_or_ReBcdDown);
not(reset_down_n,reset_down);
not(reset_bin_down_order_n,reset_bin_down_order);

TFF T0(En,clk,Q[0],reset_up_n,reset_down_n,load,D[0]);
TFF T1(Qxd[0],clk,Q[1],ReUp_or_ReBcdDown_n,reset_bin_down_order_n,load,D[1]);
TFF T2(Q2_flip_con,clk,Q[2],ReUp_or_ReBcdDown_n,reset_bin_down_order_n,load,D[2]);
TFF T3(Q3_flip_con,clk,Q[3],reset_up_n,reset_down_n,load,D[3]);
endmodule

module shift_register(Q,shift,clk,In,load,D);
input clk,shift,load,In;
input [3:0]D;
output reg [3:0]Q;
always @(posedge clk)
begin
if(load)
Q = D;
else if(shift)
begin
Q[3]=Q[2];
Q[2]=Q[1];
Q[1]=Q[0];
Q[0]=In;
end
else
Q=Q;
end
endmodule

module Load_Shift_Counter(Q,En,reset,clk,bcd,up,load,D,In,shift,download);
input En,reset,clk,bcd,up,load,In,shift,download; //reset=1 means reset here.
input [3:0]Q;
input [3:0]D;
shift_register S(D,shift,clk,In,download,Q);
counter C(Q,En,reset,clk,bcd,up,load,D);
endmodule
```

# Test Bench
```
`timescale 1ns / 1ps
module test();
wire [3:0]Q;
reg clk,En,up,reset,bcd,load,In,shift,download;
wire [3:0]D;
Load_Shift_Counter uut(Q,En,reset,clk,bcd,up,load,D,In,shift,download);
initial
begin
    clk=0;
    forever #5 clk=~clk;
end
initial
begin
    bcd=0;up=1;En=0;reset=1;load=0;shift=0;In=0;download=0;
    #10; //resets the counter to all 0s
    download=1;
    #10; //copies the counter's values to shift register.
    En=1;reset=0;download=0;
    #200; // counting up in binary for 20 clock cycles.
    En=0;shift=1;
    #40 // stopped counting and shift register has started. Countinue for 4 clock cycles.
    In=1;
    #40; //input to shift register changed to 1
    shift=0;load=1; //shift register stopped.
    #20; //loading the shift register's value to counter and waiting for a clock cycle.
    load=0;En=1;up=0;
    #50; //Counting down in binary
    En=0;reset=1;bcd=1;
    #20; //reset to 9
    En=1;reset=0;
    #150 //counting down for 15 clock cycles.
    $finish;
    
end
endmodule
```

# Simulation

<img src=Assignment3/Assign3_22110197.PNG>
