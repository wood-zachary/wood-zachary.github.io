`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// aes_datapath_tb
//   Self-checking testbench for aes_datapath against FIPS-197 Appendix B
////////////////////////////////////////////////////////////////////////////////

module aes_datapath_tb();
    logic         clk;
    logic         first;
    logic         last;
    logic [127:0] key;
    logic [127:0] plaintext;
    logic [127:0] cyphertext;
    logic [127:0] expected;
    int           errors;

    aes_datapath dut(
        .clk(clk),
        .first(first),
        .last(last),
        .key(key),
        .plaintext(plaintext),
        .cyphertext(cyphertext)
    );

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        errors = 0;

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
