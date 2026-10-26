////////////////////////////////////////////////////////////////////////////////
// subword
//   Section 5.2, four synchronous sbox lookups, one cycle latency
////////////////////////////////////////////////////////////////////////////////

module subword(input  logic        clk,
               input  logic [31:0] a,
               output logic [31:0] y);

    sbox_sync sb0(
        .a(a[7:0]),
        .clk(clk),
        .y(y[7:0])
    );

    sbox_sync sb1(
        .a(a[15:8]),
        .clk(clk),
        .y(y[15:8])
    );

    sbox_sync sb2(
        .a(a[23:16]),
        .clk(clk),
        .y(y[23:16])
    );

    sbox_sync sb3(
        .a(a[31:24]),
        .clk(clk),
        .y(y[31:24])
    );

endmodule
