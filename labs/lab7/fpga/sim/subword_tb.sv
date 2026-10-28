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

    task automatic check(input logic [31:0] a_val,
                         input logic [31:0] expected_val);
        @(negedge clk);
        a = a_val;
        expected = expected_val;
        @(posedge clk);
        #1;
        assert (y === expected) else begin
            errors++;
            $error("a=%h: expected y=%h, got y=%h", a, expected, y);
        end
    endtask

    initial begin
        errors = 0;

        check(32'hcf4f3c09, 32'h8a84eb01);
        check(32'h6c76052a, 32'h50386be5);
        check(32'h59f67f73, 32'hcb42d28f);
        check(32'h7a883b6d, 32'hdac4e23c);
        check(32'h0bad00db, 32'h2b9563b9);
        check(32'hf915bc11, 32'h99596582);
        check(32'h0093fdca, 32'h63dc5474);
        check(32'ha6dc4f4e, 32'h2486842f);
        check(32'h8d292f7f, 32'h5da515d2);
        check(32'h5c006e57, 32'h4a639f5b);

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
