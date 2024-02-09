`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 15:52:04
// Design Name: 
// Module Name: HC_SR04
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


module HC_SR04(
input logic clk,
input logic rst,
//input logic key,
input logic echo,
output logic trig,
output logic [11:0] distance1,
output logic synch

);
logic clk2, rst2, dist1_flag;
logic [19:0] cnt;
logic [31:0] distance;
logic [15:0] trig_cnt;
logic [63:0] echo_cnt;
logic [31:0] T;
logic [11:0] dist_cnt;

enum logic [1:0]{
IDLE = 2'b00,
TRIGG = 2'b01,
WAIT = 2'b10,
COUNT = 2'b11
}
state, new_state;

always_ff@(posedge clk or negedge rst)
if (rst)
begin
trig_cnt <= 16'd1001;
trig <= 1'd0;
end
else
    if (trig_cnt)
    begin
    //if (key)
    trig <= 1'd1;
    trig_cnt <= trig_cnt-16'd1;
    end
        else
        trig <= 1'd0;




always_ff@(posedge clk)
if (rst)
rst2 <= 1'd1;
else
if (echo)
rst2 <= 1'd0;



always_ff@(negedge clk)
if (rst2)
echo_cnt <= 63'd0;
else
if (echo)
echo_cnt <= echo_cnt + 63'd1;
//else
//echo_cnt <= 63'd0;



always_ff @(posedge clk)
if (rst2)
distance <= 32'd0;
else
begin
distance <= echo_cnt*17;
end

always_ff@(posedge clk or negedge echo)
if (echo)
begin
distance1 <= 12'd0;
T <= 31'd1000;
dist_cnt <= 12'd0;
end
else
if (T < distance)
begin
T <= T + 31'd100000;
dist_cnt <= dist_cnt + 12'd1;
distance1 <= 12'd0;
end
else
distance1 <= dist_cnt;
////    else 





//always_ff@(posedge clk)
//if (rst)
//begin
//synch <= 1'd0;
//echo_flag <= 1'd0;
//end
//else
//begin
//echo_flag <= echo;
//if (~echo && echo_flag)
//synch <=  1'd1;
//else
//synch <= 1'd0;
//end

always_ff@(posedge clk or posedge rst)
if (rst)
begin
synch <= 1'd0;
dist1_flag <= 1'd0;
end
else
begin
dist1_flag <= |distance1;
if (distance1 && ~dist1_flag)
synch <=  1'd1;
else
synch <= 1'd0;
end
endmodule
