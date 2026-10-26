////////////////////////////////////////////////////////////////////////////////
// addroundkey
//   Section 5.1.4, XOR of the state with the round key
////////////////////////////////////////////////////////////////////////////////

module addroundkey(input  logic [127:0] a,
                   input  logic [127:0] roundkey,
                   output logic [127:0] y);

    assign y = a ^ roundkey;

endmodule
