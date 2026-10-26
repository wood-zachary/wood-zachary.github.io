////////////////////////////////////////////////////////////////////////////////
// input_to_state
//   Section 3.4, copies a 128-bit value into the 4x4 state array
//
//   The input uses the same packing as aes_core
//        [127:120] [95:88] [63:56] [31:24]     S0,0    S0,1    S0,2    S0,3
//        [119:112] [87:80] [55:48] [23:16]     S1,0    S1,1    S1,2    S1,3
//        [111:104] [79:72] [47:40] [15:8]      S2,0    S2,1    S2,2    S2,3
//        [103:96]  [71:64] [39:32] [7:0]       S3,0    S3,1    S3,2    S3,3
//
//   The output is indexed y[r][c] for row r, column c, as in FIPS-197. The
//   ranges are [0:3] so that y[0][0] is the most significant byte and a
//   state written row by row reads like the grids in the standard.
////////////////////////////////////////////////////////////////////////////////

module input_to_state(input  logic [127:0]         a,
                      output logic [0:3][0:3][7:0] y);

    // TODO: Your code goes here

endmodule
