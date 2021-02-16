module dut(input wire[3:0] a, output reg[3:0] o);

assign o = a >>> 2;

endmodule
