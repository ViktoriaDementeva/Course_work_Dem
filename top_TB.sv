`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 15:36:30
// Design Name: 
// Module Name: top_TB
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


module top_TB;
//inputs
logic clk, rst;
logic [11:0] bin_in;
//outputs
logic i;
 logic [3:0] dec_out1;
 logic [3:0] dec_out2;
 logic [3:0] dec_out3;
 logic echo, trig, stb, dio, clk_kHz;
 logic [11:0] dist_from_sensor;
 logic [3:0] dist_from_bcd1;
 logic [3:0] dist_from_bcd2;
 logic [3:0] dist_from_bcd3;
 logic [7:0] data1_to_TM;
 logic [7:0] data2_to_TM;
 logic [7:0] data3_to_TM;
 
//BCD uut (.clk(clk), .rst(rst), .bin_in(bin_in), .dec_out1(dec_out1), .dec_out2(dec_out2), .dec_out3(dec_out3));
top uut (.clk(clk), .rst(rst), .echo(echo), .trig(trig), .stb(stb), .dio(dio), .clk_kHz(clk_kHz));

//initialize inputs
initial 
forever 
begin
#5 clk=~clk;
end

initial
begin
clk = 1'd0;
rst = 1'd0;
echo = 1'd0;
#5 rst = 1'd1;
#5 rst = 1'd0;
#200 echo = 1'd1;
#290000 echo = 1'd0;
end
endmodule
