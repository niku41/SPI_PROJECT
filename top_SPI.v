`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2024 13:53:08
// Design Name: 
// Module Name: top_SPI
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


module top_SPI(input clk,rst,cpha,cpol,rw,start,
                output mosi,sclk,cs,
                input miso,
                input [7:0]instr_set,
                output [6:0]display_out,
                output AN0,AN1);
                
wire div_clk_app,txdone,cs_wire,cpol_w,cpha_w;
wire [7:0]d_in;
wire [7:0]p_out;
wire div_freq;

freqn_divider FD1( .clk(clk),
                  .rst(rst),
                  .divided_freq(div_freq));


spi_master SPI1(
                .CS_in(cs_wire) ,
                .clk(clk) ,
                .cpha(cpha_w),
                .cpol(cpol_w),
                .data_in(d_in),
                .sclk(sclk), 
                .mosi(mosi),
                .TX_DONE(txdone),
                .cs(cs),
                .div_clk_app(div_clk_app),
                .rst(rst),
                .p_out(p_out),
                .miso(miso)
    );
    
SPI_application SPIAPP1(
                        .clk(div_freq),
                        .rst(rst),
                        .tx_done_in(txdone),
                        .rw(rw),
                        .data_out(d_in),
                        .CS_out(cs_wire),
                        .start(start),
                        .cpol_out(cpol_w),
                        .cpha_out(cpha_w),
                        .app_cpol(cpol),
                        .app_cpha(cpha),
                        .miso_sipo_in(p_out),
                        .display_out(display_out),
                        .AN0(AN0),
                        .AN1(AN1),
                        .instr_set(instr_set)
);
endmodule
