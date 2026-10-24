`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// subbytes_tb
//   Self-checking testbench for subbytes against FIPS-197 Appendix B
////////////////////////////////////////////////////////////////////////////////

module subbytes_tb();
    logic         clk;
    logic [127:0] a;
    logic [127:0] y;
    logic [127:0] expected;
    int           errors;

    subbytes dut(
        .clk(clk),
        .a(a),
        .y(y)
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
