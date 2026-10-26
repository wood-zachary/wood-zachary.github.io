////////////////////////////////////////////////////////////////////////////////
// lab7_zw
//   Top level module, clocks the AES accelerator from the internal oscillator
////////////////////////////////////////////////////////////////////////////////

module lab7_zw(input  logic sck,
               input  logic sdi,
               output logic sdo,
               input  logic load,
               output logic done);

    logic int_osc;

    // Internal high-speed oscillator generating a 48 MHz clock
    HSOSC hf_osc(
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(int_osc)
    );

    aes aes_accel(
        .clk(int_osc),
        .sck(sck),
        .sdi(sdi),
        .sdo(sdo),
        .load(load),
        .done(done)
    );

endmodule
