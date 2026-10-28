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

    logic [127:0] sb_out, sr_out, mc_out, round_out, ark_in, roundkey, ark_out;

    subbytes sb(
        .clk(clk),
        .a(ark_out),
        .y(sb_out)
    );

    shiftrows sr(
        .a(sb_out),
        .y(sr_out)
    );

    mixcolumns mc(
        .a(sr_out),
        .y(mc_out)
    );

    assign round_out = last ? sr_out : mc_out;
    assign ark_in = first ? plaintext : round_out;

    keyexpansion ke(
        .clk(clk),
        .first(first),
        .key(key),
        .roundkey(roundkey)
    );

    addroundkey ark(
        .a(ark_in),
        .roundkey(roundkey),
        .y(ark_out)
    );

    always_ff @(posedge clk) begin
        if (last) cyphertext <= ark_out;
    end

endmodule
