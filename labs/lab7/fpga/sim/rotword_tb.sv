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

    task automatic check(input logic [31:0] in, input logic [31:0] exp);
        a = in;
        expected = exp;
        #10;
        assert (y === expected) else begin
            errors++;
            $error("a=%h: expected y=%h, got y=%h", a, expected, y);
        end
    endtask

    initial begin
        errors = 0;

        check(32'h09cf4f3c, 32'hcf4f3c09);
        check(32'h2a6c7605, 32'h6c76052a);
        check(32'h7359f67f, 32'h59f67f73);
        check(32'h6d7a883b, 32'h7a883b6d);
        check(32'hdb0bad00, 32'h0bad00db);
        check(32'h11f915bc, 32'hf915bc11);
        check(32'hca0093fd, 32'h0093fdca);
        check(32'h4ea6dc4f, 32'ha6dc4f4e);
        check(32'h7f8d292f, 32'h8d292f7f);
        check(32'h575c006e, 32'h5c006e57);

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
