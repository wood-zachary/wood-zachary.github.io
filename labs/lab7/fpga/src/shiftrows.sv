////////////////////////////////////////////////////////////////////////////////
// shiftrows
//   Section 5.1.2, cyclic left shift of row r by r bytes
////////////////////////////////////////////////////////////////////////////////

module shiftrows(input  logic [127:0] a,
                 output logic [127:0] y);

    logic [0:3][0:3][7:0] a_state, y_state;

    input_to_state its(
        .a(a),
        .y(a_state)
    );

    assign y_state[0] = a_state[0];
    assign y_state[1] = {a_state[1][1:3], a_state[1][0]};
    assign y_state[2] = {a_state[2][2:3], a_state[2][0:1]};
    assign y_state[3] = {a_state[3][3],   a_state[3][0:2]};

    state_to_output sts(
        .a(y_state),
        .y(y)
    );

endmodule
