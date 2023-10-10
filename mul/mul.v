`include "add.v"

module Mul(
    input [15:0] a,
    input [15:0] b,
    output [31:0] mul
);
wire[16:0] b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12;
wire[31:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;
Booth booth0(a, {b[1:0], 1'b0}, b0);
Booth booth1(a, b[3:1], b1);
Booth booth2(a, b[5:3], b2);
Booth booth3(a, b[7:5], b3);
Booth booth4(a, b[9:7], b4);
Booth booth5(a, b[11:9], b5);
Booth booth6(a, b[13:11], b6);
Booth booth7(a, b[15:13], b7);
assign pp0 = {{15{b0[16]}}, b0};
assign pp1 = {{13{b1[16]}}, b1, {2{1'b0}}};
assign pp2 = {{11{b2[16]}}, b2, {4{1'b0}}};
assign pp3 = {{9{b3[16]}}, b3, {6{1'b0}}};
assign pp4 = {{7{b4[16]}}, b4, {8{1'b0}}};
assign pp5 = {{5{b5[16]}}, b5, {10{1'b0}}};
assign pp6 = {{3{b6[16]}}, b6, {12{1'b0}}};
assign pp7 = {{1{b7[16]}}, b7, {14{1'b0}}};
Wallace wallce(pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, mul);

always @(*) begin
    $display("%d %d %d %d %d %d %d %d",pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7);
end
endmodule //Mul


module Wallace(
    input [31:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7,
    output [31:0] res
);
wire [31:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11;
Compress32 comp0(pp0, pp1, pp2, c0, c1);
Compress32 comp1(pp3, pp4, pp5, c2, c3);
Compress32 comp2(pp6, pp7, c0, c4, c5);

Compress32 comp3(c1, c2, c3, c6, c7);
Compress32 comp4(c4, c5, c6, c8, c9);
Compress32 comp5(c7, c8, c9, c10, c11);

Add add(c10, c11, res);
endmodule //Wallace


module Booth(
    input [15:0] a,
    input [2:0] b,
    output reg [16:0] booth
);
always @(*) begin
    case (b)
        3'b000 : booth <= 0;
        3'b001 : booth <= {a[15], a};
        3'b010 : booth <= {a[15], a};
        3'b011 : booth <= a << 1;
        3'b100 : booth <= -(a << 1);
        3'b101 : booth <= -{a[15], a};
        3'b110 : booth <= -{a[15], a};
        3'b111 : booth <= 0;
        default: booth <= 0;
    endcase
    // $display("a = %d b = %d booth = %d", a, b, booth);
end
endmodule //Booth

module CSA(
    input a,
    input b,
    input c,
    output S,
    output C     
);
assign S = a ^ b ^ c;
assign C = a & b | c & (a ^ b);
endmodule //CSA

module Compress32(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    output [31:0] S,
    output [31:0] C
);
assign S = a ^ b ^ c;
assign C = (a & b | c & (a ^ b)) << 1;
endmodule //Compress32