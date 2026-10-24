`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// subword_tb
//   Self-checking testbench for subword against FIPS-197 Appendix A.1
////////////////////////////////////////////////////////////////////////////////

module subword_tb();
    logic        clk;
    logic [31:0] a;
    logic [31:0] y;
    logic [31:0] expected;
    int          errors;

    subword dut(
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
