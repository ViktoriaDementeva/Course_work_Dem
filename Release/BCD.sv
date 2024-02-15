`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 15:24:57
// Design Name: 
// Module Name: BCD
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


module BCD(
input logic clk,
input logic rst,
input logic synch,
input logic [11:0] bin_in,
output logic [3:0] dec_out1,
output logic [3:0] dec_out2,
output logic [3:0] dec_out3
);
 //logic [11:0] bin_in = 12'b0001_1001_0000;
 logic [3:0] i;
 enum logic [1:0]
 {
    Start = 2'b00,
    Shift = 2'b01,
    Add = 2'b10,
    Done = 2'b11
 }
 state;
 logic [11:0] bin; 
 logic [11:0] dec;

 
always_ff@(posedge clk or posedge rst)
begin
    if (rst)
    begin
        i <= 4'd0;
        dec <= 12'b0;
        dec_out1 <= 4'd0;
        dec_out2 <= 4'd0;
        dec_out3 <= 4'd0;
        bin <= 12'd0;
    end
     else begin
     if (synch)
     state <= Start;
     else 
    case (state)
  Start:
        begin
        bin <= bin_in;
        i <= 4'd0;
        dec <= 12'b0;
        dec_out1 <= 4'd0;
        dec_out2 <= 4'd0;
        dec_out3 <= 4'd0;
        state <= Shift;
        end
  Shift:
        begin
        bin <= {bin [10:0], 1'd0};
        dec <= {dec [10:0], bin[11]};
        i <= i + 4'd1;
        if (i == 4'd11)
            state <= Done;
        else
            state <= Add;
        end
   Add:
        begin
   //ones
        if (dec [3:0] > 4'd4)
            begin
            dec [3:0] <= dec [3:0] + 4'd3;
            state <= Shift;
            end
        else
            state <= Shift;
  //decs
       if (dec [7:4] > 4'd4)
            begin
            dec [7:4] <= dec [7:4] + 4'd3;
            state <= Shift;
            end
        else
            state <= Shift;
 //hundreds
        if (dec [11:8] > 4'd4)
            begin
            dec [11:8] <= dec [3:0] + 4'd3;
            state <= Shift;
            end
        else
            state <= Shift;
        end
  Done:
    begin
    dec_out1 <= dec[11:8];
    dec_out2 <= dec[7:4];
    dec_out3 <= dec[3:0]; 
    i <= 4'd0;
    end
    endcase;
end;
end;


endmodule

