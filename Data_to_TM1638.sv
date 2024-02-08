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
input logic clk,
input logic [3:0] in,
 (* dont_touch = "true" *) output  logic [7:0] out
);
    
   always_ff@(posedge clk) 
   case (in)
    4'd0:  out <= 8'b0011_1111; //1111_1100
    4'd1:  out <= 8'b0000_0011; //1100_0000
    4'd2:  out <= 8'b0101_1011_; //1101_1010
    4'd3:  out <= 8'b0100_1111; //1111_0010
    4'd4:  out <= 8'b0110_0110; //0110_0110
    4'd5:  out <= 8'b0110_1101; //1011_0110
    4'd6:  out <= 8'b0111_1101; //1011_1110
    4'd7:  out <= 8'b0000_0111; //1110_0000
    4'd8:  out <= 8'b0111_1111; //1111_1110
    4'd9:  out <= 8'b0110_1111; //1111_0110
    default: out <= 8'b1000_0000; //0000_0001
endcase
   
endmodule
