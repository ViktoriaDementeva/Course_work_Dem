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
// input logic key,
(* mark_debug = "true" *)input logic echo,
output logic trig,
output logic [11:0] distance1,
output logic synch

);
(* mark_debug = "true" *)logic clk2, rst2, echo_flag;
logic [19:0] cnt;
logic [23:0] distance;
logic [15:0] trig_cnt;
logic [63:0] echo_cnt;
logic [23:0] T;
logic [7:0] dist_cnt;

enum logic [1:0]{
IDLE = 2'b00,
TRIGG = 2'b01,
WAIT = 2'b10,
COUNT = 2'b11
}
state, new_state;

always_ff@(posedge clk)
if (rst)
begin
trig_cnt <= 16'd1001;
trig <= 1'd0;
end
else
if (trig_cnt)
begin
trig <= 1'd1;
trig_cnt <= trig_cnt-16'd1;
end
else
trig <= 1'd0;


always_ff@(posedge clk)
if (rst)
begin
clk2 <= 1'd1;
cnt <= 20'd0;
end
else
begin
cnt <= cnt + 20'd1;
if (cnt == 20'd100000)
begin
clk2 <= ~clk2;
cnt <= 20'd0;
end
end


always_ff@(posedge clk)
if (rst)
rst2 <= 1'd1;
else
if (echo)
rst2 <= 1'd0;



always_ff@(negedge clk)
begin
if (rst2)
echo_cnt <= 63'd0;
else
if (echo)
echo_cnt <= echo_cnt + 63'd1;
else
echo_cnt <= 63'd0;
end


always_ff @(negedge clk)
if (rst2)
distance <= 24'd0;
else
begin
distance <= echo_cnt*17;
end

always_ff@(posedge clk)
if (rst2)
begin
distance1 <= 12'd0;
T <= 24'd1000;
dist_cnt <= 12'd0;
end
else
if (T < distance)
begin
T <= T + 24'd100000;
dist_cnt <= dist_cnt + 8'd1;
distance1 <= 12'd0;
end
else
distance1 <= (dist_cnt) ? dist_cnt : distance;

always_ff@(posedge clk)
if (rst)
begin
synch <= 1'd0;
echo_flag <= 1'd0;
end
else
begin
echo_flag <= echo;
if (~echo && echo_flag)
synch <=  1'd1;
else
synch <= 1'd0;
end

endmodule
