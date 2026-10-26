////////////////////////////////////////////////////////////////////////////////
// state_to_output
//   Section 3.4, copies the 4x4 state array back into a 128-bit value
//   Inverse of input_to_state, with the same packing
////////////////////////////////////////////////////////////////////////////////

module state_to_output(input  logic [0:3][0:3][7:0] a,
                       output logic [127:0]         y);

    assign y = {
        a[0][0], a[1][0], a[2][0], a[3][0],
        a[0][1], a[1][1], a[2][1], a[3][1],
        a[0][2], a[1][2], a[2][2], a[3][2],
        a[0][3], a[1][3], a[2][3], a[3][3]
    };

endmodule
