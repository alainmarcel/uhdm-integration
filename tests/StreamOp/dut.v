module dut;
  logic[31:0] x;
  logic[31:0] y;
  logic[31:0] a;
  logic[31:0] b;
  logic[63:0] c;

  initial begin
     x = { 8'h11, 8'h22, 8'h33, 8'h44 };
     a = { << 8 {x} };
  end

  assign y = { 8'h88, 8'h77, 8'h66, 8'h55 };
  assign b = { << 8 {y} };

  initial begin
     c = { << 8 {x, y} };
  end

  logic[63:0] d;
  assign d = { >> 8 {y, x} };

endmodule
