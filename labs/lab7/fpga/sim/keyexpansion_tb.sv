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

    task automatic check(input logic         first_val,
                         input logic [127:0] key_val,
                         input logic [127:0] expected_val);
        @(negedge clk);
        first = first_val;
        key = key_val;
        expected = expected_val;
        #1;
        assert (roundkey === expected) else begin
            errors++;
            $error("first=%h, key=%h: expected roundkey=%h, got roundkey=%h",
                   first, key, expected, roundkey);
        end
    endtask

    initial begin
        errors = 0;

        check(1'b1,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'h2b7e151628aed2a6abf7158809cf4f3c);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'ha0fafe1788542cb123a339392a6c7605);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'hf2c295f27a96b9435935807a7359f67f);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'h3d80477d4716fe3e1e237e446d7a883b);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'hef44a541a8525b7fb671253bdb0bad00);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'hd4d1c6f87c839d87caf2b8bc11f915bc);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'h6d88a37a110b3efddbf98641ca0093fd);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'h4e54f70e5f5fc9f384a64fb24ea6dc4f);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'head27321b58dbad2312bf5607f8d292f);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'hac7766f319fadc2128d12941575c006e);
        check(1'b0,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'hd014f9a8c9ee2589e13f0cc8b6630ca6);

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
