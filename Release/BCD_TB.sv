`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 16:47:33
// Design Name: 
// Module Name: BCD_TB
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


module BCD_TB;
//inputs
logic clk, rst, synch;
logic [11:0] bin_in;
//outputs
logic i;
 logic [3:0] dec_out1;
 logic [3:0] dec_out2;
 logic [3:0] dec_out3;
BCD uut (.clk(clk), .rst(rst),.synch(synch), .bin_in(bin_in), .dec_out1(dec_out1), .dec_out2(dec_out2), .dec_out3(dec_out3));


//initialize inputs
initial 
forever 
begin
#5 clk=~clk;
end

initial
begin
bin_in = 12'd400;
synch = 1'd1;
clk = 1'd0;
rst = 1'd0;
#5 rst = 1'd1;
#5 rst = 1'd0;
#20 synch = 1'd0;
end
endmodule

