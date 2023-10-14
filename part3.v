module part3(
    input clock, reset, ParallelLoadn, RotateRight, ASRight,
    input [3:0] Data_IN,
    output reg [3:0] Q
);

    always @(posedge clock) begin
        if (reset) 
            Q <= 4'b0000;
        else if (!ParallelLoadn) 
            Q <= Data_IN;
        else if (RotateRight && ASRight) 
            Q <= {Q[3], Q[3:1]}; //ASRight
        else if (RotateRight)
          Q <= {Q[0], Q[3:1]}; //Rotate right - preserving lowest bit
        else
          Q <= {Q[2:0], Q[3]}; //Rotate left - preserving sig bit
    end

endmodule
