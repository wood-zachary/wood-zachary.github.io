`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// rotword_tb
//   Self-checking testbench for rotword against FIPS-197 Appendix A.1
////////////////////////////////////////////////////////////////////////////////

module rotword_tb();
    logic [31:0] a;
    logic [31:0] y;
    logic [31:0] expected;
    int          errors;

    rotword dut(
        .a(a),
        .y(y)
    );

    initial begin
        errors = 0;

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
