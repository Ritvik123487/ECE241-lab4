module led_display(input [7:0] data, output [7:0] leds);
  assign leds = data;
endmodule

module hex_display_module(data, hex_output);
  input [3:0] data;
  output reg [6:0] hex_output;

  always @* begin
    case(data)
      4'b0000: hex_output = 7'b1000000; // 0
      4'b0001: hex_output = 7'b1111001; // 1
      4'b0010: hex_output = 7'b0100100; // 2
      4'b0011: hex_output = 7'b0110000; // 3
      4'b0100: hex_output = 7'b0011001; // 4
      4'b0101: hex_output = 7'b0010010; // 5
      4'b0110: hex_output = 7'b0000010; // 6
      4'b0111: hex_output = 7'b1111000; // 7
      4'b1000: hex_output = 7'b0000000; // 8
      4'b1001: hex_output = 7'b0010000; // 9
      4'b1010: hex_output = 7'b0001000; // A
      4'b1011: hex_output = 7'b0000011; // B
      4'b1100: hex_output = 7'b1000110; // C
      4'b1101: hex_output = 7'b0100001; // D
      4'b1110: hex_output = 7'b0000110; // E
      4'b1111: hex_output = 7'b0001110; // F
      default: hex_output = 7'b1111111; // OFF
    endcase
  end
endmodule

module ALU (A,B,func,out);
  input [3:0] A,B;
  input [1:0] func;
  output reg [7:0] out;

  always@* begin
    case(func)
      2'b00: out = A+B;
      2'b01: out = A*B;
      2'b10: out = B<<A;
      2'b11: out = out;
      default: out = 8'b0;
    endcase
  end
endmodule  

module register (clk, reset_b, d, q);
  input wire clk, reset_b;
  input wire [7:0] d;
  output reg [7:0] q;

  always@(posedge clk) begin
    if(!reset_b)
      q <= 8'b0;
    else
      q <= d;
  end
endmodule

module part2(Clock, Reset, Data, Function, ALUout);
  //(Clock, Reset, Data, Function, ALUout, hex_display, leds);
  input Clock, Reset;
  input [3:0] Data;
  input [1:0] Function;
  output [7:0] ALUout;
  //output [6:0] hex_display;
  //output [7:0] leds;

  wire [7:0] pre_reg_ALUout;
  wire [3:0] signalB = pre_reg_ALUout[3:0];

  ALU u1 (.A(Data), .B(signalB), .func(Function), .out(pre_reg_ALUout));

  register u2 (.clk(Clock), .reset_b(Reset), .d(pre_reg_ALUout), .q(ALUout));

  //hex_display_module u3 (.data_input(Data), .hex_output(hex_display));
  
  //led_display u4(.data(ALUout), .leds(leds));

endmodule
