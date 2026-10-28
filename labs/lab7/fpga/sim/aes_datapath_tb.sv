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

    task automatic check(input logic         first_val,
                         input logic         last_val,
                         input logic [127:0] expected_val);
        @(negedge clk);
        first = first_val;
        last = last_val;
        expected = expected_val;
        #1;
        assert (dut.ark_out === expected) else begin
            errors++;
            $error("first=%h, last=%h, expected ark_out=%h, got ark_out=%h",
            first, last, expected, dut.ark_out);
        end
    endtask

    initial begin
        errors = 0;

        plaintext = 128'h3243f6a8885a308d313198a2e0370734;
        key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

        check(1'b1,
              1'b0,
              128'h193de3bea0f4e22b9ac68d2ae9f84808);
        check(1'b0,
              1'b0,
              128'ha49c7ff2689f352b6b5bea43026a5049);
        check(1'b0,
              1'b0,
              128'haa8f5f0361dde3ef82d24ad26832469a);
        check(1'b0,
              1'b0,
              128'h486c4eee671d9d0d4de3b138d65f58e7);
        check(1'b0,
              1'b0,
              128'he0927fe8c86363c0d9b1355085b8be01);
        check(1'b0,
              1'b0,
              128'hf1006f55c1924cef7cc88b325db5d50c);
        check(1'b0,
              1'b0,
              128'h260e2e173d41b77de86472a9fdd28b25);
        check(1'b0,
              1'b0,
              128'h5a4142b11949dc1fa3e019657a8c040c);
        check(1'b0,
              1'b0,
              128'hea835cf00445332d655d98ad8596b0c5);
        check(1'b0,
              1'b0,
              128'heb40f21e592e38848ba113e71bc342d2);
        check(1'b0,
              1'b1,
              128'h3925841d02dc09fbdc118597196a0b32);

        @(posedge clk);
        #1;
        expected = 128'h3925841d02dc09fbdc118597196a0b32;
        assert (cyphertext === expected) else begin
            errors++;
            $error("expected cyphertext=%h, got cyphertext=%h", expected, cyphertext);
        end

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
