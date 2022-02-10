`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:56 11/07/2021 
// Design Name: 
// Module Name:    controlpath 
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
module controlpath(
	input go,
	input clk,
	input eqz,
	output eoc, ld_a, ld_b, ld_p, ld_acc, ld_N, dec_N, clr_acc, clr
    );
	
	controlpath_1 z1(ld_a, ld_b, ld_N, clr_acc, clr, go, clk, eqz);
	controlpath_2 z2(ld_p, ld_acc, dec_N, eoc, ld_a, eqz, clk);
	 
endmodule

//////////////////////////////////////
////  CONTROL PATH FOR PIPE-1 ///////
/////////////////////////////////////

module controlpath_1(
	output reg ld_a, ld_b, ld_N, clr_acc, clr,
	input go, clk, eqz);
	
	reg [1:0] state;
	
	parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
	
	initial state = 2'b00;
	
	always @(posedge clk) 
	 begin 
		 case(state) 
			 S0:
				begin
					if (go) state <= S1; 
					else state <=S0;
				end
			 S1: state <= S2; 
			 S2: 
				begin
					if (!eqz) state <= S2;
					else state <= S3; 
				end
			 S3: state <= S3;
			 default: state <= S0;
		 endcase
	end
	always @(state) 
	 begin 
		 case(state)
			 S0: begin ld_a = 0; ld_b = 0; ld_N = 0; clr_acc = 1; clr = 1; end
			 S1: begin ld_a = 0; ld_b = 0; ld_N = 1; clr_acc = 1; clr = 0; end
			 S2: begin ld_a = 1; ld_b = 1; ld_N = 0; clr_acc = 0; clr = 0; end
			 S3: begin ld_a = 0; ld_b = 0; ld_N = 0; clr_acc = 0; clr = 1; end
			 default: begin ld_a = 0; ld_b = 0; ld_N = 0; clr_acc = 1; clr = 1; end
		 endcase
	 end
endmodule



//////////////////////////////////////
////  CONTROL PATH FOR PIPE-2 ///////
/////////////////////////////////////
	 
module controlpath_2(
	output reg ld_p, ld_acc, dec_N, eoc,
	input ld_a, eqz, clk);
	
	reg [1:0] state;
	
	parameter S0=2'b00, S1=2'b01, S2=2'b10;
	
	initial state = 2'b00;
	
	always @(posedge clk) 
	 begin 
		 case(state) 
			 S0:
				begin
					if (ld_a) state <= S1; 
					else state <= S0;
				end
			 S1: 
				begin
					if (!eqz) state <= S1;
					else state <= S2; 
				end
			 S2: state <= S2;
			 default: state <= S0;
		 endcase
	end
	always @(state) 
	 begin 
		 case(state)
			 S0: begin ld_p = 0; ld_acc = 0; dec_N = 0; eoc = 0; end
			 S1: begin ld_p = 1; ld_acc = 1; dec_N = 1; eoc = 0; end
			 S2: begin ld_p = 0; ld_acc = 0; dec_N = 0; eoc = 1; end
			 default: begin ld_p = 0; ld_acc = 0; dec_N = 0; eoc = 0; end
		 endcase
	 end
endmodule
