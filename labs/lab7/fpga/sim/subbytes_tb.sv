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

    task automatic check(input logic [127:0] a_val,
                         input logic [127:0] expected_val);
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

        check(128'h193de3bea0f4e22b9ac68d2ae9f84808,
              128'hd42711aee0bf98f1b8b45de51e415230);
        check(128'ha49c7ff2689f352b6b5bea43026a5049,
              128'h49ded28945db96f17f39871a7702533b);
        check(128'haa8f5f0361dde3ef82d24ad26832469a,
              128'hac73cf7befc111df13b5d6b545235ab8);
        check(128'h486c4eee671d9d0d4de3b138d65f58e7,
              128'h52502f2885a45ed7e311c807f6cf6a94);
        check(128'he0927fe8c86363c0d9b1355085b8be01,
              128'he14fd29be8fbfbba35c89653976cae7c);
        check(128'hf1006f55c1924cef7cc88b325db5d50c,
              128'ha163a8fc784f29df10e83d234cd503fe);
        check(128'h260e2e173d41b77de86472a9fdd28b25,
              128'hf7ab31f02783a9ff9b4340d354b53d3f);
        check(128'h5a4142b11949dc1fa3e019657a8c040c,
              128'hbe832cc8d43b86c00ae1d44dda64f2fe);
        check(128'hea835cf00445332d655d98ad8596b0c5,
              128'h87ec4a8cf26ec3d84d4c46959790e7a6);
        check(128'heb40f21e592e38848ba113e71bc342d2,
              128'he9098972cb31075f3d327d94af2e2cb5);

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
