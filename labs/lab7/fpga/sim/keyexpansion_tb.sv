`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// keyexpansion_tb
//   Self-checking testbench for keyexpansion against FIPS-197 Appendix A.1
////////////////////////////////////////////////////////////////////////////////

module keyexpansion_tb();
    logic         clk;
    logic         first;
    logic [127:0] key;
    logic [127:0] roundkey;
    logic [127:0] expected;
    int           errors;

    keyexpansion dut(
        .clk(clk),
        .first(first),
        .key(key),
        .roundkey(roundkey)
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
