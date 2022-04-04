 module pipe(f,a,b,c,d,clk);
parameter n=10;
input[n-1:0]a,b,c,d;
input clk;
output[n-1:0]f;
reg[n-1:0] a1_x1,a1_x2,a1_x3,b1_x1,b1_x2,c1_x1;

always@(posedge clk)
begin
a1_x1<=#4 a+b; //stage1//
a1_x2<=#4 c-d;
a1_x3<=d;
end

always@(posedge clk)
begin
b1_x1<=#4 a1_x1+a1_x2;   //stage2//
b1_x2<=a1_x3;
end

always@(posedge clk)
begin
c1_x1<=#6 b1_x1+b1_x2;
end     //stage3//
endmodule
