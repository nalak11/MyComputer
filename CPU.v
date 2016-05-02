`include "CPU.vh"

// CPU Module

module CPU(
	
		input [7:0] Din,	
		input Sample,
		input [2:0] Btns,
		input Clock,
		input Reset,
		input Turbo,
		
		output [7:0] Dout,
		output reg Dval,
		output [5:0] GPO,
		output reg [3:0] Debug,
		output reg [7:0] IP

);

// Registers
reg [7:0] Reg [0:31];

// Use these to Read the Special Registers
wire [7:0] Rgout = Reg[29];
wire [7:0] Rdout = Reg[30];
wire [7:0] Rflag = Reg[31];

// Use these to Write to the Flags and Din Registers
`define RFLAG Reg[31]
`define RDINP Reg[28]

// Connect certain registers to the external world
assign Dout = Rdout;
assign GPO = Rgout[5:0];

// TO DO: Change Later
initial Dval = 1;

// Instruction Cycle
wire [3:0] cmd_grp = instruction[34:31];
wire [2:0] cmd = instruction[30:28];
wire [1:0] arg1_typ = instruction[27:26];
wire [7:0] arg1 = instruction[25:18];
wire [1:0] arg2_typ = instruction[17:16];
wire [7:0] arg2 = instruction[15:8];
wire [7:0] addr = instruction[7:0];

reg [24:0] cnt;
parameter Cycle = 250; // ms

wire go = !Reset && (cnt == 0);		// condition for executing the next instruction
wire [34:0] instruction;

AsyncROM Pmem(IP, instruction);		// Retreive the next instruction from ROM

always@ (posedge Clock) begin
	cnt <= (cnt == (50000000/1000)*Cycle) ? 0 : cnt + 1;	// counter
end

always@ (posedge Clock) begin
	if (go)					// Process instruction
		IP <= IP + 8'b1;
		case (cmd_grp)
			`MOV:
			Reg[arg2] <= arg1;

			// For now, we just assumed a PUR move, with arg1 a number and arg2 a register!
			endcase
	if (Reset)				// Process reset
		IP <= 0;
end

// Stage 5, Step 1, Q1: Quartus does not allow continuous assignments to the same variable in seperate always statements //
// Stage 5, Step 2, Q1: Pmem takes the IP and returns the appropriate instruction from the ROM //
// Stage 5, Step 2, Q2: //
// Stage 5, Step 2, Q3: //
// Stage 5, Step 2, Q4: Numbers, the defined constants are replaces with numbers at compile time //


endmodule

