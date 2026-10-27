////////////////////////////////////////////////////////////////////////////////
// aes
//   Top level module with SPI interface and SPI core
////////////////////////////////////////////////////////////////////////////////

module aes(input  logic sck,
           input  logic sdi,
           output logic sdo,
           input  logic load,
           output logic done);

    logic         int_osc;
    logic [127:0] key, plaintext, cyphertext;

    // Internal high-speed oscillator generating a 24 MHz clock
    HSOSC #(.CLKHF_DIV("0b01")) hf_osc(
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(int_osc)
    );

    aes_spi spi(
        .sck(sck),
        .sdi(sdi),
        .sdo(sdo),
        .done(done),
        .key(key),
        .plaintext(plaintext),
        .cyphertext(cyphertext)
    );
    aes_core core(
        .clk(int_osc),
        .load(load),
        .key(key),
        .plaintext(plaintext),
        .done(done),
        .cyphertext(cyphertext)
    );

endmodule
