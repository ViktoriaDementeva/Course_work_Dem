`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2024 15:59:56
// Design Name: 
// Module Name: TM1638_TB
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


module TM1638_TB;

logic clk, clk_kHz, clk_kHz2, stb, rst, synch2;
logic [11:0] cnt;
logic [11:0] cnt_01;
logic [7:0] data1;
logic [7:0] data2;
logic [7:0] data3;
logic [3:0] cnt2;
logic dio;
logic [15:0] i;
logic [2:0] per;
logic [7:0] pos;
logic [151:0] data;

TM1638 uut(.clk(clk), .synch2(synch2), .stb(stb), .data1(data1), .data2(data2), .data3(data3), .rst(rst), .dio(dio), .clk_kHz(clk_kHz));
initial forever
begin
#5 clk = ~clk;
end

initial 
begin
data1 = 8'b0011_1111;
data2 = 8'b0101_1011;
data3 = 8'b0110_0110;
clk = 1'd0;
rst = 1'd0;
#15 rst = 1'd1;
#20 rst = 1'd0;
#100000 synch2 = 1'd1;
end

endmodule
