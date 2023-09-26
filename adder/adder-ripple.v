/* ACM Class System (I) Fall Assignment 1 
 *
 *
 * Implement your naive adder here
 * 
 * GUIDE:
 *   1. Create a RTL project in Vivado
 *   2. Put this file into `Sources'
 *   3. Put `test_adder.v' into `Simulation Sources'
 *   4. Run Behavioral Simulation
 *   5. Make sure to run at least 100 steps during the simulation (usually 100ns)
 *   6. You can see the results in `Tcl console'
 *
 */

module adder(
    input [15:0] a,
    input [15:0] b,
    output [15:0] answer,
    output carry
);
wire c[15:0];
wire zero = 0;
full_adder  ADD0 (.a(a[0]), .b(b[0]), .in_c(zero), .s(answer[0]), .out_c(c[0])),
            ADD1 (.a(a[1]), .b(b[1]), .in_c(c[0]), .s(answer[1]), .out_c(c[1])),
            ADD2 (.a(a[2]), .b(b[2]), .in_c(c[1]), .s(answer[2]), .out_c(c[2])),
            ADD3 (.a(a[3]), .b(b[3]), .in_c(c[2]), .s(answer[3]), .out_c(c[3])),
            ADD4 (.a(a[4]), .b(b[4]), .in_c(c[3]), .s(answer[4]), .out_c(c[4])),
            ADD5 (.a(a[5]), .b(b[5]), .in_c(c[4]), .s(answer[5]), .out_c(c[5])),
            ADD6 (.a(a[6]), .b(b[6]), .in_c(c[5]), .s(answer[6]), .out_c(c[6])),
            ADD7 (.a(a[7]), .b(b[7]), .in_c(c[6]), .s(answer[7]), .out_c(c[7])),
            ADD8 (.a(a[8]), .b(b[8]), .in_c(c[7]), .s(answer[8]), .out_c(c[8])),
            ADD9 (.a(a[9]), .b(b[9]), .in_c(c[8]), .s(answer[9]), .out_c(c[9])),
            ADD10 (.a(a[10]), .b(b[10]), .in_c(c[9]), .s(answer[10]), .out_c(c[10])),
            ADD11 (.a(a[11]), .b(b[11]), .in_c(c[10]), .s(answer[11]), .out_c(c[11])),
            ADD12 (.a(a[12]), .b(b[12]), .in_c(c[11]), .s(answer[12]), .out_c(c[12])),
            ADD13 (.a(a[13]), .b(b[13]), .in_c(c[12]), .s(answer[13]), .out_c(c[13])),
            ADD14 (.a(a[14]), .b(b[14]), .in_c(c[13]), .s(answer[14]), .out_c(c[14])),
            ADD15 (.a(a[15]), .b(b[15]), .in_c(c[14]), .s(answer[15]), .out_c(out_c));
endmodule

module full_adder(
    input a,
    input b,
    input in_c,
    output s,
    output out_c
);
wire t = a ^ b;
assign s = t ^ in_c;
assign out_c = a & b | t & in_c;

endmodule
