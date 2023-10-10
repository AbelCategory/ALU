module Add(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
wire t = 0;
wire carry_1;
wire carry_2;
adder_16 Add1(.a(a[15:0]), .b(b[15:0]), .in_c(t), .out_c(carry_1), .s(sum[15:0]));
adder_16 Add2(.a(a[31:16]), .b(b[31:16]), .in_c(carry_1), .out_c(carry_2), .s(sum[31:16]));
endmodule //Add

module CLU(
    input [3:0] g,
    input [3:0] p,
    input in_c,
    output [3:0] c
);
assign c[0] = g[0] | in_c & p[0];
assign c[1] = g[1] | g[0] & p[1] | in_c & p[1] & p[0];
assign c[2] = g[2] | g[1] & p[2] | g[0] & p[2] & p[1] | in_c & p[2] & p[1] & p[0];
assign c[3] = g[3] | g[2] & p[3] | g[1] & p[3] & p[2] | g[0] & p[3] & p[2] & p[1] | in_c & p[3] & p[2] & p[1] & p[0];
endmodule //CLU

module add_4(
    input [3:0] g,
    input [3:0] p,
    input in_c,
    output [3:0] s
);
wire [3:0] c, t;

assign t = ~g & p;
CLU clu(.g(g), .p(p), .in_c(in_c), .c(c));
assign s[0] = t[0] ^ in_c;
assign s[1] = t[1] ^ c[0];
assign s[2] = t[2] ^ c[1];
assign s[3] = t[3] ^ c[2];

endmodule //add_4

module pgm_4(
    input [3:0] g,
    input [3:0] p,
    output gm,
    output pm
);
assign gm = g[3] | g[2] & p[3] | g[1] & p[3] & p[2] | g[0] & p[3] & p[2] & p[1];
assign pm = p[3] & p[2] & p[1] & p[0];
endmodule //pgm_4

module adder_16(
    input [15:0] a,
    input [15:0] b,
    input in_c,
    output out_c,
    output [15:0] s
);
wire [15:0] g, p;
wire [3:0] pm, gm, c;
assign g = a & b;
assign p = a | b;
pgm_4   PG0 (.g(g[3:0]), .p(p[3:0]), .gm(gm[0]), .pm(pm[0])),
        PG1 (.g(g[7:4]), .p(p[7:4]), .gm(gm[1]), .pm(pm[1])),
        PG2 (.g(g[11:8]), .p(p[11:8]), .gm(gm[2]), .pm(pm[2])),
        PG3 (.g(g[15:12]), .p(p[15:12]), .gm(gm[3]), .pm(pm[3]));

CLU clu(.g(gm), .p(pm), .in_c(in_c), .c(c));

add_4   ADD0 (.g(g[3:0]), .p(p[3:0]), .in_c(in_c), .s(s[3:0])),
        ADD1 (.g(g[7:4]), .p(p[7:4]), .in_c(c[0]), .s(s[7:4])),
        ADD2 (.g(g[11:8]), .p(p[11:8]), .in_c(c[1]), .s(s[11:8])),
        ADD3 (.g(g[15:12]), .p(p[15:12]), .in_c(c[2]), .s(s[15:12]));
assign out_c = c[3];
endmodule //add_16