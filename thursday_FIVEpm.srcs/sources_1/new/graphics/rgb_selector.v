`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2024 02:27:04 PM
// Design Name: 
// Module Name: rgb_selector
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


module rgb_selector(input [12:0] pixel_index,
input [15:0] player1_rgb, player2_rgb,
   ball_rgb, background_rgb, goalpost_rgb, 
   input player1_on, goalpost_on, ball_on, player2_on, 
    output reg [15:0] rgb = 0);
    
    always @(pixel_index) begin 
        if(goalpost_on)begin  
            rgb = goalpost_rgb;
        end 
        else if(ball_on) begin //goalpost should be in front of the ball
            rgb = ball_rgb;
        end
        else if(player1_on) begin //ball should be in front of player (if overlap occurs)
            rgb = player1_rgb;
        end
        else if(player2_on) begin //as a side note, p1, p2 and ball should not overlap
            rgb = player2_rgb;
        end 
        else begin
            rgb = background_rgb;
        end
    end
endmodule
