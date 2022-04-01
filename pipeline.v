module pipe_ex(f,a,b,c,d,clk);
parameter n=10;
input[n-1:0] a,b,c,d;
input clk;
output[n-1:0] f;
reg[n-1:0]l12_x1,l12_x2,l12_b,l23_x3,l23_d,l34_f;
assign f=l34_f;

always @(posedge clk)
begin
l12_x1<=#4 a+b;
l12_x2<=#4 c-d;
l23_d<=0;
end

always @( posedge clk)
begin
l23_x3<=#4 l12_x1+l12_x2;
l23_d<= l23_d;
end

always @( posedge clk)
begin
l34_f=#8 l23_x3*l23_d;
end
endmodule
    
//testbench

module pipe1_test;
parameter n=10;
wire[n-1:0] f;
reg [n-1:0] a,b,c,d;
reg clk;
pipe_ex mypipe(f,a,b,c,d,clk);
initial clk=0;
always #10 clk = ~clk;
initial
begin
#30 a=10;b=12;c=6;d=3;
#20 a=10;b=10;c=5;d=3;
#20 a=11;b=11;c=1;d=4;
#20 a=15;b=22;c=1;d=5;
#20 a=9;b=11;c=9;d=5;
#20 a=19;b=19;c=5;d=7;
#20 a=10;b=10;c=5;d=3;
#20 a=17;b=12;c=5;d=9;
end

initial 
begin
$dumpfile ("pipe1.vcd");
$dumpvars (10,pipe1_test);
$monitor ("time:%d,f=%d",$time,f);
#300 $finish;
end
endmodule
