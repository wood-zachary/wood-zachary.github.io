////////////////////////////////////////////////////////////////////////////////
// sbox_sync
//   Infamous AES byte substitutions with magic numbers
//   Synchronous version which is mapped to embedded block RAMs (EBR)
//   Section 5.1.1, Figure 7
////////////////////////////////////////////////////////////////////////////////

module sbox_sync(input  logic [7:0] a,
                 input  logic       clk,
                 output logic [7:0] y);

    logic [7:0] sbox [0:255];

    initial $readmemh("sbox.txt", sbox);

    always_ff @(posedge clk)
        y <= sbox[a];

endmodule
