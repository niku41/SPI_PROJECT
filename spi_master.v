`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2024 13:54:53
// Design Name: 
// Module Name: spi_master
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



module spi_master(
input CS_in ,clk ,cpha,cpol,rst,
input [7:0]data_in,
output sclk,
output reg mosi,TX_DONE,
input miso,
output cs,div_clk_app,
output [7:0]p_out
    );
    reg q;
    reg [3:0]sel_cnt;
    reg [1:0]divide_cnt;
    wire dive_clk,mux_cnt_clk;
    wire gated_clk;
    reg [7:0]temp;
    
    
    assign div_clk_app=divide_cnt[0];
    assign cs=CS_in;
    
    always @(posedge clk,posedge rst)
        begin 
            if ( rst)
                divide_cnt<=2'b00;
            else 
                divide_cnt<=divide_cnt+2'b01;     
        end 
        
        assign dive_clk = divide_cnt[0];
         
always @ (negedge dive_clk)
begin 
    if(CS_in)
        q<=1'b0;
    else
        q<=~CS_in;
end
    assign gated_clk=dive_clk & q;
    assign sclk = cpol ? ~gated_clk : gated_clk;
    assign mux_cnt_clk = cpol^cpha ? ~sclk :sclk;  
    
    
 always @(posedge mux_cnt_clk , posedge rst,posedge  CS_in)
   begin 
        if (rst || CS_in)
            begin
            sel_cnt <= 4'b0000;
            TX_DONE <= 1'b0;
            end
     
        else 
          if(sel_cnt == 4'b1000)
            begin
            TX_DONE <= 1'b1;
            sel_cnt <= 4'b0001;
            end   
          else 
            begin
            sel_cnt <= sel_cnt + 4'b0001;  
            TX_DONE <= 1'b0;
            end
   end 
        
   always @(*)
   begin 
   case (sel_cnt)
   4'b0001 :  mosi = data_in[7];
   4'b0010 :  mosi = data_in[6];
   4'b0011 :  mosi = data_in[5];
   4'b0100 :  mosi = data_in[4];
   4'b0101 :  mosi = data_in[3];
   4'b0110 :  mosi = data_in[2];
   4'b0111 :  mosi = data_in[1];
   4'b1000 :  mosi = data_in[0];
   endcase
   end   
   
   
//MISO
always @(posedge mux_cnt_clk)
    begin
    temp[0]<=miso;
    temp[1]<=temp[0];
    temp[2]<=temp[1];
    temp[3]<=temp[2];
    temp[4]<=temp[3];
    temp[5]<=temp[4];
    temp[6]<=temp[5];
    temp[7]<=temp[6];
    end

assign p_out = temp;
    
endmodule
