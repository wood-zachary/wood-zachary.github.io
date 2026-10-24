`timescale 10ns/1ns

////////////////////////////////////////////////////////////////////////////////
// aes_controller_tb
//   Self-checking testbench for the aes_controller state sequence
////////////////////////////////////////////////////////////////////////////////

module aes_controller_tb();
    logic clk;
    logic load;
    logic first;
    logic last;
    logic done;
    int   errors;

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

    initial begin
        errors = 0;

        if (errors == 0) $display("PASSED");
        else             $display("FAILED: %0d errors", errors);
        $stop();
    end

endmodule
