`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2024 09:46:27 AM
// Design Name: 
// Module Name: ball_sprite_control
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


module ball_sprite_control( 
    input [6:0] x, input [5:0] y, input [12:0] pixel_index,
    input ball_clk,
    input [31:0] Sx, Sy, //X and Y coordinates of the ball
    input [1:0] direction, //direction which ball is rotating
    output reg [15:0]rgb = 0,  
    output reg ball_on = 0);
    
    //Boundaries for OLED display area    
    parameter MAX_X = 95;
    parameter MAX_Y = 63;
    
    //Ball width and height
    parameter B_W = 5;
    parameter B_H = 5;
        
    //Default state is IDLE
    parameter IDLE = 0;
    parameter LEFT = 1;
    parameter RIGHT = 2;
    ///
    
    ///ROM Coordinates
    wire [2:0] col;
    wire [2:0] row;
    wire sprite_on; //Indicates the pixels which should be displaying the sprite
    
    //Ensures only 1 ball is showing
    assign sprite_on =  (x >= Sx) && (x <= Sx + B_W - 1) && (y >= Sy) && (y <= Sy + B_H - 1) ? 1:0;
    
    assign col = sprite_on ? (x - Sx) : 0;
    assign row = sprite_on ? y - Sy:0;
    
    wire [15:0] rgb_buffer;
    ball_animation roll(.pixel_index(pixel_index), .ball_clk(ball_clk), .direction(direction), 
                .row(row), .col(col), .rgb(rgb_buffer));

    always @ (pixel_index) begin
        ball_on = 0; //If the rgb is the sprite background, ball is off
        rgb = rgb_buffer;
        if(rgb != 16'b0000010010110110) begin //If the rgb is not the sprite background, ball is on
            ball_on = 1;
        end
    end
endmodule
