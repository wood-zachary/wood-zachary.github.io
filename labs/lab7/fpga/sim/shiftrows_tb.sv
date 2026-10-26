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

    task automatic check(input logic [127:0] a_val,
                         input logic [127:0] expected_val);
        a = a_val;
        expected = expected_val;
        #10;
        assert (y === expected) else begin
            errors++;
            $error("a=%h: expected y=%h, got y=%h", a, expected, y);
        end
    endtask

    initial begin
        errors = 0;

        check(128'hd42711aee0bf98f1b8b45de51e415230,
              128'hd4bf5d30e0b452aeb84111f11e2798e5);
        check(128'h49ded28945db96f17f39871a7702533b,
              128'h49db873b453953897f02d2f177de961a);
        check(128'hac73cf7befc111df13b5d6b545235ab8,
              128'hacc1d6b8efb55a7b1323cfdf457311b5);
        check(128'h52502f2885a45ed7e311c807f6cf6a94,
              128'h52a4c89485116a28e3cf2fd7f6505e07);
        check(128'he14fd29be8fbfbba35c89653976cae7c,
              128'he1fb967ce8c8ae9b356cd2ba974ffb53);
        check(128'ha163a8fc784f29df10e83d234cd503fe,
              128'ha14f3dfe78e803fc10d5a8df4c632923);
        check(128'hf7ab31f02783a9ff9b4340d354b53d3f,
              128'hf783403f27433df09bb531ff54aba9d3);
        check(128'hbe832cc8d43b86c00ae1d44dda64f2fe,
              128'hbe3bd4fed4e1f2c80a642cc0da83864d);
        check(128'h87ec4a8cf26ec3d84d4c46959790e7a6,
              128'h876e46a6f24ce78c4d904ad897ecc395);
        check(128'he9098972cb31075f3d327d94af2e2cb5,
              128'he9317db5cb322c723d2e895faf090794);

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
