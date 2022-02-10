`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:10 11/07/2021 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
	input ld_a,
	input ld_b,
	input [15:0] a,
	input [15:0] b,
	input ld_p,
	input ld_acc,
	input ld_N,
	input [15:0]N,
	input dec_N,
	input clk,
	input clr,
	input clr_acc,
	output eqz,
	output reg[63:0]out
	);
	 
	wire [63:0]temp;
	wire [15:0] temp1;
	wire [15:0] temp2;
	wire [31:0] temp3;
	wire [31:0] temp4;
	wire [63:0] sum_in;
	wire [63:0] sum_out; 
	wire [15:0] Nout;
	
	supply0 gnd;
	supply0 [32:0] pad;
	 
	PIPO_16 REG_A(temp1, a, ld_a, clr, clk);
	PIPO_16 REG_B(temp2, b, ld_b, clr, clk);
	vedic_16x16 MULTIPLIER(temp1,temp2,temp3);
	PIPO_32 REG_P(temp4,temp3, ld_p, clr, clk);
	//accumulator q2(temp4,clk,clr_acc,sum_out);
	assign temp = {pad,temp4};
	CLA_64 ACCUMULATOR(.a(temp),.b(sum_in), .cin(gnd), .sum(sum_out));
	PIPO_64 REG_ACC(sum_in,sum_out, ld_acc, clr_acc, clk);
	counter COUNT(Nout, N, ld_N, dec_N, clk, clr);
	EQZ COMPARATOR (eqz, Nout);	
	
	always @(*)
	  out = sum_in;
	
endmodule