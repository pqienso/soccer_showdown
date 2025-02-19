`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2024 03:52:46 PM
// Design Name: 
// Module Name: endscreen_control
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


module endscreen_control(input CLOCK, 
    input [6:0]x, input [5:0] y, 
    input player_win, // 0: player1, 1: player2
    output [15:0] rgb);
    
    wire [15:0] rgb1, rgb2;
    endscreen_1_rom player1(.clk(CLOCK), .row(y), .col(x), .color_data(rgb1));
    endscreen_2_rom player2(.clk(CLOCK), .row(y), .col(x), .color_data(rgb2));
    
    assign rgb = ~player_win ? rgb1:rgb2;
    
endmodule
