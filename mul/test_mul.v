`include "mul.v"


// module Booth(
//     input [15:0] a,
//     input [2:0] b,
//     output reg [16:0] booth
// );
// always @(*) begin
//     case (b)
//         3'b000 : booth <= 0;
//         3'b001 : booth <= {a[15], a};
//         3'b010 : booth <= {a[15], a};
//         3'b011 : booth <= a << 1;
//         3'b100 : booth <= -(a << 1);
//         3'b101 : booth <= -{a[15], a};
//         3'b110 : booth <= -{a[15], a};
//         3'b111 : booth <= 0;
//         default: booth <= 0;
//     endcase
//     $display("a = %d b = %d booth = %d", a, b, booth);
// end
// endmodule //Booth
module test_mul;
wire [31:0] res,ta,tb;
reg [15:0] a,b;
reg [31:0] A,B,answer;
wire [16:0] boo;
reg [15:0] aa;
reg [2:0] bb;
Mul mul(a, b, res);
    // Booth booth(.a(aa), .b(bb), .booth(boo));
integer i;
initial begin
    for(i=1;i<=20;i=i+1) begin
        a[15:0] = $random;
        b[15:0] = $random;
        A = {{16{a[15]}}, a};
        B = {{16{b[15]}}, b};
        answer = A * B;
        #10
        $display("TESTCASE %d: %d * %d = %d, res = %d", i, a, b, answer, res);
    end
    // a[15:0] = $random;
    // b[15:0] = $random;
    // A = {{16{a[15]}}, a};
    // B = {{16{b[15]}}, b};
    // answer = A * B;
    // #10;
    // $display("TESTCASE %d: %d * %d = %d ans = %d", i, a, b, res, answer);
    
end
endmodule