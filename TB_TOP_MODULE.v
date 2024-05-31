`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2024 13:56:41
// Design Name: 
// Module Name: TB_TOP_MODULE
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


module TB_TOP_MODULE();
reg clk ,cpha,cpol,rw,rst,start,miso;
wire  mosi,sclk,cs;
reg [7:0]miso_sipo_in,instr_set;
wire [6:0]display_out;
top_SPI DUT(.clk(clk),.cpha(cpha),.cpol(cpol),
            .mosi(mosi),.rw(rw),.rst(rst),
            .start(start),.sclk(sclk),.cs(cs),
            .miso(miso),
            .display_out(display_out),
            .instr_set(instr_set));

always #5 clk=~clk ;
initial begin 
clk=0;
rw=1;
rst=1;
start=0;
{cpha,cpol}=2'b00;
instr_set=8'b00000110;
#10
rst=0;
#20
start=1;
#50
start=0;
#1200
start=1;

#50
start=0;
rw=0;
#1200
start=1;
#10
start=0;
#170
miso=1;
#10
miso=1;
#10
miso=1;
#10
miso=1;
#10
miso=0;
#10
miso=0;
#10
miso=0;
#10
miso=0;
#10
miso=1;
#10
miso=1;
#10
#165

#1500$finish;
end 
endmodule
