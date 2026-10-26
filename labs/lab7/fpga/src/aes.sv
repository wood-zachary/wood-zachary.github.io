////////////////////////////////////////////////////////////////////////////////
// aes
//   AES accelerator with SPI interface and encryption core
////////////////////////////////////////////////////////////////////////////////

module aes(input  logic clk,
           input  logic sck,
           input  logic sdi,
           output logic sdo,
           input  logic load,
           output logic done);

    logic [127:0] key, plaintext, cyphertext;

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
        .clk(clk),
        .load(load),
        .key(key),
        .plaintext(plaintext),
        .done(done),
        .cyphertext(cyphertext)
    );

endmodule
