`include "CPU.vh"

// Asynchronous ROM (Program Memory)

module AsyncROM(
	input addr,
	output reg data
);

always @(addr) begin
	case (addr)
	0: data = {`MOV, `PUR, `NUM, 8'd 1, `REG, `DOUT, `N8};
	1: data = {`MOV, `PUR, `NUM, 8'd 3, `REG, `DOUT, `N8};
	2: data = {`MOV, `PUR, `NUM, 8'd 5, `REG, `DOUT, `N8};
	3: data = {`MOV, `PUR, `NUM, 8'd 7, `REG, `DOUT, `N8};
	4: data = {`MOV, `PUR, `NUM, 8'd 9, `REG, `DOUT, `N8};
	5: data = {`MOV, `PUR, `NUM, 8'd 11, `REG, `DOUT, `N8};
	6: data = {`MOV, `PUR, `NUM, 8'd 13, `REG, `DOUT, `N8};
	7: data = {`MOV, `PUR, `NUM, 8'd 15, `REG, `DOUT, `N8};
	8: data = {`MOV, `PUR, `NUM, 8'd 17, `REG, `DOUT, `N8};
	9: data = {`MOV, `PUR, `NUM, 8'd 19, `REG, `DOUT, `N8};
	default: data = 35'b0; // Default instruction is a NOP
	endcase
end

endmodule

