`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2024 18:45:41
// Design Name: 
// Module Name: Data_to_TM1638_TB
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


module Data_to_TM1638_TB;
logic [3:0] in;
logic [7:0] out;

Data_to_TM1638 uut(.in(in), .out(out));

initial begin
in = 4'd9;
#5 in = 4'd1;
#5 in = 4'd2;
#5 in = 4'd3;
end

endmodule
