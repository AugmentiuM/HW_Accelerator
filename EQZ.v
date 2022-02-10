`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:52:26 11/07/2021 
// Design Name: 
// Module Name:    EQZ 
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
module EQZ (eqz, data); 
	 input [15:0] data;
	 output eqz; 
	 assign eqz = (data == 0); 
endmodule
