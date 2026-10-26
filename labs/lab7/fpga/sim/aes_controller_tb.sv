`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// aes_controller_tb
//   Self-checking testbench for the aes_controller state sequence
////////////////////////////////////////////////////////////////////////////////

module aes_controller_tb();
    logic       clk;
    logic       load;
    logic       first;
    logic       last;
    logic       done;
    logic [2:0] expected;
    int         errors;

    aes_controller dut(
        .clk(clk),
        .load(load),
        .first(first),
        .last(last),
        .done(done)
    );

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    task automatic check(input logic       load_val,
                         input logic [2:0] expected_val);
        @(negedge clk);
        load = load_val;
        expected = expected_val;
        #1;
        assert ({first, last, done} === expected) else begin
            errors++;
            $error("load=%b: expected {first, last, done}=%b, got %b",
                   load, expected, {first, last, done});
        end
    endtask

    initial begin
        errors = 0;

        // Raise the reset signal for a bit
        check(1'b1, 3'b100);
        check(1'b1, 3'b100);

        // round 0 asserts first
        check(1'b0, 3'b100);

        // rounds 1-9 assert nothing
        repeat (9) check(1'b0, 3'b000);

        // round 10 asserts last
        check(1'b0, 3'b010);

        // round 11 asserts done until next load
        repeat (3) check(1'b0, 3'b001);
        check(1'b1, 3'b100);

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
