`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 15:29:31
// Design Name: 
// Module Name: top
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


module top(
input logic clk,
input logic rst,
input logic echo,
output logic trig,  
output logic stb,
output logic dio,
output logic clk_kHz
    );
logic [11:0] dist_from_sensor;
logic [3:0] dist_from_bcd1;
logic [3:0] dist_from_bcd2;
logic [3:0] dist_from_bcd3;
logic [7:0] data1_to_TM;
logic [7:0] data2_to_TM;
logic [7:0] data3_to_TM;
logic synch, synch2;
 
    HC_SR04 hcsr04(.clk(clk), .rst(rst), .echo(echo), .trig(trig), .distance1(dist_from_sensor), .synch(synch));
    BCD bcd (.clk(clk), .rst(rst), .synch(synch), .bin_in(dist_from_sensor), .dec_out1(dist_from_bcd1), .dec_out2(dist_from_bcd2), .dec_out3(dist_from_bcd3));
    Data_to_TM1638 data1(.clk(clk), .in(dist_from_bcd1), .out(data1_to_TM));
    Data_to_TM1638 data2(.clk(clk), .in(dist_from_bcd2), .out(data2_to_TM));
    Data_to_TM1638 data3(.clk(clk), .in(dist_from_bcd3), .out(data3_to_TM));
    
    always_ff@(posedge clk)
    if ((data1_to_TM == 8'd252) && (data2_to_TM == 8'd252) && (data3_to_TM == 8'd252))
    synch2 <= 1'd0;
    else 
    synch2 <= 1'd1;
    
    TM1638 tm1638(.clk(clk), .synch2(synch2), .stb(stb), .rst(rst), .data1(data1_to_TM), .data2(data2_to_TM), .data3(data3_to_TM), .dio(dio), .clk_kHz(clk_kHz));
endmodule
