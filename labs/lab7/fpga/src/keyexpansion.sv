////////////////////////////////////////////////////////////////////////////////
// keyexpansion
//   Section 5.2, generates one round key per cycle
////////////////////////////////////////////////////////////////////////////////

module keyexpansion(input  logic         clk,
                    input  logic         first,
                    input  logic [127:0] key,
                    output logic [127:0] roundkey);

    logic [7:0]   rcon_next, rcon_d, rcon;
    logic [31:0]  rw_out, sw_out;
    logic [127:0] prev_key, next_key;

    // rcon
    galoismult rcon_gm(
        .a(rcon),
        .y(rcon_next)
    );

    assign rcon_d = first ? 8'd1 : rcon_next;

    always_ff @(posedge clk) begin
        rcon <= rcon_d;
    end

    // sw_out
    rotword rw(
        .a(roundkey[31:0]),
        .y(rw_out)
    );

    subword sw(
        .a(rw_out),
        .clk(clk),
        .y(sw_out)
    );

    // prev_key
    always_ff @(posedge clk) begin
        prev_key <= roundkey;
    end

    // roundkey
    assign next_key[127:96] = prev_key[127:96] ^ {rcon, 24'h0} ^ sw_out;
    assign next_key[95:64]  = next_key[127:96] ^ prev_key[95:64];
    assign next_key[63:32]  = next_key[95:64]  ^ prev_key[63:32];
    assign next_key[31:0]   = next_key[63:32]  ^ prev_key[31:0];

    assign roundkey = first ? key : next_key;

endmodule
