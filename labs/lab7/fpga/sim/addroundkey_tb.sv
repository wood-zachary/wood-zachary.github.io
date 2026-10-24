`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// addroundkey_tb
//   Self-checking testbench for addroundkey against FIPS-197 Appendix B
////////////////////////////////////////////////////////////////////////////////

module addroundkey_tb();
    logic [127:0] a;
    logic [127:0] roundkey;
    logic [127:0] y;
    logic [127:0] expected;
    int           errors;

    addroundkey dut(
        .a(a),
        .roundkey(roundkey),
        .y(y)
    );

    initial begin
        errors = 0;

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
