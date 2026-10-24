////////////////////////////////////////////////////////////////////////////////
// aes_datapath
//   Iterative AES-128 round datapath, one round per cycle
////////////////////////////////////////////////////////////////////////////////

module aes_datapath(input  logic         clk,
                    input  logic         first,
                    input  logic         last,
                    input  logic [127:0] key,
                    input  logic [127:0] plaintext,
                    output logic [127:0] cyphertext);

endmodule
