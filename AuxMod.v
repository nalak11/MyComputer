// Add more auxillary modules here...



// Display a Hexadecimal Digit, a Negative Sign, or a Blank, on a 7-segment Display
module SSeg(input [3:0] bin, input neg, input enable, output reg [6:0] segs);
	always @(*)
		if (enable) begin
			if (neg) segs = 7'b011_1111;
			else begin
				case (bin)
					0: segs = 7'b100_0000;
					1: segs = 7'b111_1001;
					2: segs = 7'b010_0100;
					3: segs = 7'b011_0000;
					4: segs = 7'b001_1001;
					5: segs = 7'b001_0010;
					6: segs = 7'b000_0010;
					7: segs = 7'b111_1000;
					8: segs = 7'b000_0000;
					9: segs = 7'b001_1000;
					10: segs = 7'b000_1000;
					11: segs = 7'b000_0011;
					12: segs = 7'b100_0110;
					13: segs = 7'b010_0001;
					14: segs = 7'b000_0110;
					15: segs = 7'b000_1110;
				endcase
			end
		end
		else segs = 7'b111_1111;
endmodule

module DeBounce(

	input Clock,
	input in,
	output reg out
);

	parameter Speed = 50000000;

	wire in_Sync;								// Synchronised input
	wire rst;									// flag to reset the values in the DFFs
	reg [20:0] count;							// counter
	reg DFF1;									// D Flip-Flops
	reg DFF2;

	Synchroniser DB_Sync(Clock, in, in_Sync);

	assign rst = (DFF1 ^ DFF2);					// XOR statement to check if DFF1 and DFF2 are different and reset if they are

	always@ (posedge Clock) begin 				// counter resetting every 30ms
		
		if (count < (Speed/1000)*30) begin
			count <= count + 1;
		end

		else begin
			count <= 0; 						// if we get to 30ms without a reset, output the value in DFF2		
			out <= DFF2;						
		end
		
		if (rst) begin 							// if DFF1 and DFF2 were different, reset the counter
			count <= 0;
		end

		DFF1 <= in_Sync;					// keep clocking through
		DFF2 <= DFF1; 

	end



endmodule

module Disp2cNum(

	input [7:0] in,
	input enable,
	output [6:0]  HEX0,
	output [6:0]  HEX1,
	output [6:0]  HEX2,
	output [6:0]  HEX3
);

endmodule

module DispHex(

	input [7:0] in,
	output [6:0] HEX0,
	output [6:0] HEX1
);

endmodule

module Synchroniser(input Clock, input in, output reg out2);

	reg out1;

	always@(posedge Clock) begin
		out1 <= in;
		out2 <= out1;
	end

endmodule