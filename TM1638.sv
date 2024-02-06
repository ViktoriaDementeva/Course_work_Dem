`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2024 15:24:17
// Design Name: 
// Module Name: TM1638
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


module TM1638(
input logic clk,
input logic synch2,
output logic stb,
input logic [7:0] data1,
input logic [7:0] data2,
input logic [7:0] data3,
input logic rst,
output logic dio,
output logic clk_kHz
);

    logic [11:0] cnt;
    logic [11:0] cnt_01;
    logic clk_kHz2, rst2;
    logic [15:0] i;
    logic [2:0] per;
    logic [7:0] pos;
    logic [151:0] data;
    
    //logic [7:0] data1 = 8'b0111_0110;
    //logic [7:0] data2 = 8'b0111_1001;
    logic [7:0] data_0 = 8'b1111_1100;
    
    logic [7:0] data_d = 8'b0111_1010;
    logic [7:0] data_i = 8'b1100_0000;
    logic [7:0] data_s = 8'b1011_0100;
    logic [7:0] data_t = 8'b0001_1110;
    
    logic [7:0] com1 = 8'b0100_0000;
    logic [7:0] com2 = 8'b1100_0000;
    logic [7:0] com3 = 8'b1000_1111;
    
    
    always_ff@(posedge synch2)
    data = {com3, 8'b1111_1111, data3, 8'b0, data2, 8'b1111_1111, data1, 8'b0, data_0, 8'b1111_1111, data_t, 8'b0, data_s, 8'b1111_1111, data_i, 8'b0, data_d, com2, com1};
    
      
   always_ff@(posedge clk)
   if (rst)
    begin
   cnt <= 12'd0;
   clk_kHz2 <= 1'd0;
    end
   else
   begin
     if (cnt < 12'd499)
     cnt <= cnt + 12'd1;
        else
            begin
           cnt <= 12'd0;
           clk_kHz2 <= ~clk_kHz2;
            end
            end

   always_ff@(posedge clk)
   if (rst)
   begin
   rst2 <= 1'd1;
   cnt_01 <= 12'd0;
   end
   else 
   begin
   cnt_01 <= cnt_01 + 12'd1;
   if (cnt_01 == 12'd998)
   rst2 <= 1'd0;
   end
   
   enum logic [2:0]
   {
   IDLE,
   COM1,
   COM2,
   DATA,
   COM3,
   DONE
   } 
   state, new_state;
   
   always_ff@(posedge clk_kHz2)
   if (synch2)
    begin
    case(state)
    IDLE: new_state <= COM1;
    COM1: new_state <= (per == 3'd1) ? COM2 : state;
    COM2: new_state <= (per == 3'd2) ? DATA : state; 
    DATA: new_state <= (per == 3'd3) ? COM3 : state;  
    COM3: new_state <= (per == 3'd4) ? DONE : state;
    endcase
    end
    
    always_ff@(posedge clk_kHz2)
    if (synch2)
    begin
    case (state)
    
        IDLE:
            begin
            stb <= 1'd1;
            clk_kHz <= 1'd1;
            i <= 16'd0;
            per <= 3'd0;
            end
            
        COM1:
            begin
            stb <= 1'd0;
            i <= i + 16'd1;
            if (i > 16'd0 && i < 16'd17)
            clk_kHz <= ~clk_kHz;
            if (i == 16'd17)
            begin
            stb <= 1'd1;
            i <= 16'd0;
            per <= 3'd1;
            end
            end
      
      COM2:
        begin
        i <= i + 16'd1;
        if (i > 16'd0)
        stb <= 1'd0;    
        if (i > 16'd0 && i < 16'd17)
        clk_kHz <= ~clk_kHz;
        if (i == 16'd17)
            begin
            i <= 16'd0;
            per <= 3'd2;
            end
        end
        
     DATA:
         begin
         stb <= 1'd0;
         i <= i + 16'd1;
         if (i > 16'd0 && i < 16'd257)
         clk_kHz <= ~clk_kHz;
         if (i == 16'd257)
         begin
         stb <= 1'd1;
         i <= 16'd0;
         per <= 3'd3;
         end
     end
     
     COM3:
        begin
        i <= i + 16'd1;
        if (i > 16'd0)
        stb <= 1'd0;
        if (i > 16'd1 && i < 16'd17)
        clk_kHz <= ~clk_kHz;
        if (i == 16'd17)
            begin
            i <= 16'd0;
            per <= 3'd4;
            stb <= 1'd1;
            end
        end
        
     DONE:
        begin
        i <= i+ 16'd1;
        stb <= 1'd1;
        if (i == 16'd5) 
        begin 
        i <= 16'd0;
        per <= 3'd5;
        end
        end
        
    endcase
    end
    
     always_ff@(negedge clk_kHz or posedge rst)
        if (rst)
        begin
        dio <= 1'd0;
        pos <= 8'd0;
        end
        else
        if (synch2)
        begin
        dio <= data[pos];
        pos <= pos + 8'd1;
        if (pos == 8'd151)
        pos <= 8'd0;
        end
        
    always_ff@(posedge clk_kHz2)
        if (rst2)
        state <= IDLE;
        else 
        if (synch2)
        state <= new_state;

endmodule

