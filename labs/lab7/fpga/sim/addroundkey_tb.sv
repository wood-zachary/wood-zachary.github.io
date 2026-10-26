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

    task automatic check(input logic [127:0] a_val,
                         input logic [127:0] roundkey_val,
                         input logic [127:0] expected_val);
        a = a_val;
        roundkey = roundkey_val;
        expected = expected_val;
        #10;
        assert (y === expected) else begin
            errors++;
            $error("a=%h, roundkey=%h\n  expected y=%h\n  got      y=%h",
                   a, roundkey, expected, y);
        end
    endtask

    initial begin
        errors = 0;

        // Round 0: input
        check(128'h3243f6a8885a308d313198a2e0370734,
              128'h2b7e151628aed2a6abf7158809cf4f3c,
              128'h193de3bea0f4e22b9ac68d2ae9f84808);

        // Rounds 1-9: after MixColumns
        check(128'h046681e5e0cb199a48f8d37a2806264c,
              128'ha0fafe1788542cb123a339392a6c7605,
              128'ha49c7ff2689f352b6b5bea43026a5049);
        check(128'h584dcaf11b4b5aacdbe7caa81b6bb0e5,
              128'hf2c295f27a96b9435935807a7359f67f,
              128'haa8f5f0361dde3ef82d24ad26832469a);
        check(128'h75ec0993200b633353c0cf7cbb25d0dc,
              128'h3d80477d4716fe3e1e237e446d7a883b,
              128'h486c4eee671d9d0d4de3b138d65f58e7);
        check(128'h0fd6daa9603138bf6fc0106b5eb31301,
              128'hef44a541a8525b7fb671253bdb0bad00,
              128'he0927fe8c86363c0d9b1355085b8be01);
        check(128'h25d1a9adbd11d168b63a338e4c4cc0b0,
              128'hd4d1c6f87c839d87caf2b8bc11f915bc,
              128'hf1006f55c1924cef7cc88b325db5d50c);
        check(128'h4b868d6d2c4a8980339df4e837d218d8,
              128'h6d88a37a110b3efddbf98641ca0093fd,
              128'h260e2e173d41b77de86472a9fdd28b25);
        check(128'h1415b5bf461615ec274656d7342ad843,
              128'h4e54f70e5f5fc9f384a64fb24ea6dc4f,
              128'h5a4142b11949dc1fa3e019657a8c040c);
        check(128'h00512fd1b1c889ff54766dcdfa1b99ea,
              128'head27321b58dbad2312bf5607f8d292f,
              128'hea835cf00445332d655d98ad8596b0c5);
        check(128'h473794ed40d4e4a5a3703aa64c9f42bc,
              128'hac7766f319fadc2128d12941575c006e,
              128'heb40f21e592e38848ba113e71bc342d2);

        // Round 10: after ShiftRows
        check(128'he9317db5cb322c723d2e895faf090794,
              128'hd014f9a8c9ee2589e13f0cc8b6630ca6,
              128'h3925841d02dc09fbdc118597196a0b32);

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
