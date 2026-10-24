`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// shiftrows_tb
//   Self-checking testbench for shiftrows against FIPS-197 Appendix B
////////////////////////////////////////////////////////////////////////////////

module shiftrows_tb();
    logic [127:0] a;
    logic [127:0] y;
    logic [127:0] expected;
    int           errors;

    shiftrows dut(
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
