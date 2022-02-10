`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:54:36 11/09/2021
// Design Name:   counter
// Module Name:   C:/Users/ARIJIT/OneDrive/Documents/IIEST MTECH/1.Sem3/Xilinx/FinalMAC/counter_tb.v
// Project Name:  FinalMAC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	// Inputs
	reg [15:0] N;
	reg ld_N;
	reg dec_N;
	reg clk;
	reg clr;

	// Outputs
	wire [15:0] dout;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.dout(dout), 
		.N(N), 
		.ld_N(ld_N), 
		.dec_N(dec_N), 
		.clk(clk),
		.clr(clr)
	);

	initial begin
		// Initialize Inputs
		N = 0;
		ld_N = 0;
		dec_N = 0;
		clk = 0;
		clr = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		N = 16'd7;
		#20 ld_N = 1;
		//#50 ld_N = 0;
		#80 dec_N =1; 
		#50 dec_N =1;
		#50 dec_N =1;
		#50 dec_N =1;clr =1;
		#80 clr=0;

	end
      
	 always #50 clk = ~clk;
endmodule

