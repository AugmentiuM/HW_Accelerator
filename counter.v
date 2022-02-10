`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:47:26 11/07/2021 
// Design Name: 
// Module Name:    counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter (dout, N, ld_N, dec_N, clk, clr); 
 input [15:0] N; 
 input ld_N, dec_N, clk, clr; 
 output reg [15:0] dout; 
 always @(posedge clk) 
   begin
	 if (clr) 
		 dout <= 1'b0; 
	 else if (ld_N) 
		 dout <= N; 
	 else if (dec_N) 
		 dout <= dout - 1; 
	end
endmodule

