`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2024 12:16:55 AM
// Design Name: 
// Module Name: kicking_animation
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


module kicking_animation(input [12:0]pixel_index, input kick_clk, input [3:0]row, input [3:0]col,
    input player,
    input [1:0] movement,
     output [15:0]rgb);
    parameter KICK = 3;
    
    wire [15:0] rgb1, rgb2;
    reg kick_state = 0;
    
    //player 1
    wire [15:0] p1rgb1, p1rgb2;
    player1_run2_rom p1kick1(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p1rgb1)); 
    player1_run3_rom p1kick2(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p1rgb2)); 
    
    //player 2
    wire [15:0] p2rgb1, p2rgb2;
    player2_run2_rom p2kick1(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p2rgb1)); 
    player2_run3_rom p2kick2(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p2rgb2)); 
    
    //Muxing the RGB outputs
    assign rgb1 = ~player ? p1rgb1: p2rgb1;
    assign rgb2 = ~player ? p1rgb2: p2rgb2;
    
    assign rgb = ~kick_state ? rgb1:rgb2;
    always @ (posedge kick_clk) begin
        if(movement == KICK) begin 
            kick_state <= kick_state + 1;
        end
        else begin
            kick_state <= 0;
        end
    end
endmodule
