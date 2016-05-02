`timescale 1ms/1ps

module testStage2;

	reg x;
	wire y;
	reg CLOCK_50;

	DeBounce DUT(CLOCK_50, x, y);

	initial begin
		x = 0;
		#30;
		x = 1;
		#5;
		x = 0;
		#10;
		x = 1;
		#5;
		x = 0;
		#10;
		x = 1;
		#5;
		x = 0;
		#5;
		x = 1;
		#40;
		x = 0;
		#10;
		$stop;
	end
endmodule 