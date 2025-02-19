`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2024 12:04:53 PM
// Design Name: 
// Module Name: goalpost_control
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


module goalpost_control(input [12:0] pixel_index,
    input [6:0]x, input[5:0] y,
    output reg [15:0] rgb = 0,
    output reg goalpost_on = 0);
    
    //Boundaries for OLED display area    
    parameter MAX_X = 95;
    parameter MAX_Y = 63;
   ////
   
   ///Goal post dimensions
    parameter GP_H = 25; //Goal post height
    parameter GP_W = 13; //Goal post width
    ////
    
    wire [4:0] row;
    wire [3:0] col;
    //Goalpost will only appear within this dimensions
    //Goalpost by default faces right
    wire [15:0] rgb_buffer;
    
    assign col = ((x >= 0) && (x <= GP_W) && (y >= MAX_Y - GP_H) && (y <= MAX_Y)) ? (GP_W - 1 - x):
                   ((x >= MAX_X - GP_W + 1) && (x <= MAX_X) && (y >= MAX_Y - GP_H) && (y <= MAX_Y)) ? x - (MAX_X - GP_W + 1):0;
    
    assign row = ((x >= 0) && (x <= GP_W) && (y >= MAX_Y - GP_H) && (y <= MAX_Y)) ? y - (MAX_Y - GP_H):
                                      ((x >= MAX_X - GP_W + 1) && (x <= MAX_X) && (y >= MAX_Y - GP_H) && (y <= MAX_Y)) ? y - (MAX_Y - GP_H):0;

    goalpost_rom goalpost_unit(.pixel_index(pixel_index), .row(row), .col(col), .color_data(rgb_buffer));
    always @ (pixel_index) begin
        goalpost_on = 0;   
        rgb = rgb_buffer;
        if(rgb != 16'b1111100110000110) begin //if rgb is not background colour, then its on
            goalpost_on = 1; //need to change default colour in the rom also because i nvr check if sprite on
        end
    end
endmodule
