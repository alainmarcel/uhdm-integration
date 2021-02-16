module dut(input wire[2:0] a, output reg[2:0] o);

assign o = a << 1;

endmodule
