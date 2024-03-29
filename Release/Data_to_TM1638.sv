`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 16:34:32
// Design Name: 
// Module Name: Data_to_TM1638
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Data_to_TM1638(
//input logic clk, rst,
input logic [3:0] in,
 (* dont_touch = "true" *) output  logic [7:0] out
);
    
   always_ff@(in) 
   case (in)
    4'd0:  out <= 8'b0011_1111; 
    4'd1:  out <= 8'b0000_0110; 
    4'd2:  out <= 8'b0101_1011;
    4'd3:  out <= 8'b0100_1111;
    4'd4:  out <= 8'b0110_0110;
    4'd5:  out <= 8'b0110_1101; 
    4'd6:  out <= 8'b0111_1101; 
    4'd7:  out <= 8'b0000_0111; 
    4'd8:  out <= 8'b0111_1111; 
    4'd9:  out <= 8'b0110_1111; 
    default: out <= 8'b1000_0000;
endcase
   
endmodule
