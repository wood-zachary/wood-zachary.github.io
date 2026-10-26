////////////////////////////////////////////////////////////////////////////////
// aes_controller
//   Sequences the initial AddRoundKey, ten rounds, and done
////////////////////////////////////////////////////////////////////////////////

module aes_controller(input  logic clk,
                      input  logic load,
                      output logic first,
                      output logic last,
                      output logic done);

    logic [3:0] round;

    counter #(.WIDTH(4)) round_cnt (
        .clk(clk),
        .rst(load),
        .en(!done),
        .count(round)
    );

    assign first = (round == 4'd0);
    assign last = (round == 4'd10);

    always_ff @(posedge clk or posedge load) begin
        if (load) done <= 1'b0;
        else if (last) done <= 1'b1;
    end

endmodule
