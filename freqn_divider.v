`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2024 13:54:04
// Design Name: 
// Module Name: freqn_divider
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



module freqn_divider(input clk,rst,
                    output divided_freq);
                    
reg [24:0]count;
 always @(posedge clk,posedge rst)
        begin 
            if ( rst)
               count<=2'b00;
            else 
                count<=count+2'b01;     
        end 
        
        assign divided_freq = count[20];
endmodule
