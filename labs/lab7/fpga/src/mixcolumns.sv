////////////////////////////////////////////////////////////////////////////////
// mixcolumns
//   Even funkier action on columns
//   Section 5.1.3, Figure 9
//   Same operation performed on each of four columns
////////////////////////////////////////////////////////////////////////////////

module mixcolumns(input  logic [127:0] a,
                  output logic [127:0] y);

    mixcolumn mc0(
        .a(a[127:96]),
        .y(y[127:96])
    );
    mixcolumn mc1(
        .a(a[95:64]),
        .y(y[95:64])
    );
    mixcolumn mc2(
        .a(a[63:32]),
        .y(y[63:32])
    );
    mixcolumn mc3(
        .a(a[31:0]),
        .y(y[31:0])
    );

endmodule
