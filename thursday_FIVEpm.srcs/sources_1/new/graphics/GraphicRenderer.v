`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2024 05:58:05 PM
// Design Name: 
// Module Name: GraphicRenderer
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


module GraphicRenderer(
    input [6:0] x,
    input [5:0] y, //x and y coordinates from OLED module
    
    input [12:0] pixel_index,
    input walk_clk,  //frequency of walking animations, 4 frames, (8hz)
    input kick_clk, //frequency of kicking animations, 2 frames, (2hz)
    input ball_clk, //frequency of ball rolling animations, 4 frames, (8hz)
    
    input [31:0] Sx_player1, Sy_player1, //coordinates of first player
    input player1_direction, //facing left or right
    input [1:0]player1_movement, //Jump, Idle, Walk, Kick
    
    input [31:0] Sx_player2, Sy_player2, //coordinates of the second player
    input player2_direction, //facing left or right
    input [1:0]player2_movement, //Jump, Idle, Walk, Kick
    
    input [31:0] Sx_ball, Sy_ball, //coordinates of the ball,
    input [1:0] ball_direction, //idle, rotate left and right
    output [15:0] rgb
    );
   
    //rgb output wires
    wire [15:0] player1_rgb, player2_rgb;
    wire [15:0] ball_rgb, background_rgb, menu_rgb, goalpost_rgb, endscreen_rgb;
    //status wires
    wire player1_on, player2_on, ball_on, goal_on, background_on, goalpost_on;
    
    //Player sprite 1 (for player, 0:player1, 1:player2)
    PlayerSprite_Control player_unit1(.x(x), .y(y), .player(0), 
        .walk_clk(walk_clk), .kick_clk(kick_clk), .pixel_index(pixel_index),
        .Sx(Sx_player1), .Sy(Sy_player1), .direction(player1_direction), .movement(player1_movement),
        .player_on(player1_on), .rgb(player1_rgb));
    ////
    
    //Player sprite 2
    PlayerSprite_Control player_unit2(.x(x), .y(y), .player(1), 
        .walk_clk(walk_clk), .kick_clk(kick_clk),.pixel_index(pixel_index),
        .Sx(Sx_player2), .Sy(Sy_player2), .direction(player2_direction), .movement(player2_movement),
        .player_on(player2_on), .rgb(player2_rgb)); 
    ////
    
    //Soccer ball
    ball_sprite_control ball_unit(.x(x), .y(y), 
        .ball_clk(ball_clk), .pixel_index(pixel_index),
        .rgb(ball_rgb), .Sx(Sx_ball), .Sy(Sy_ball), .direction(ball_direction), .ball_on(ball_on));
    ///
    
    //Goalpost, need to give the correct bits to y and x
    goalpost_control goalpost_unit(.pixel_index(pixel_index),
            .x(x), .y(y), .rgb(goalpost_rgb), .goalpost_on(goalpost_on));
    ////
    
    ///Background
    background_rom background_unit(.pixel_index(pixel_index), .row(y), .col(x), .color_data(background_rgb));
    ////
                         
    //Muxing the rgb output based on gamestate and how elements are supposed to overlap
    rgb_selector selector_unit(.pixel_index(pixel_index),
         .player1_rgb(player1_rgb), .player2_rgb(player2_rgb),
        .background_rgb(background_rgb), .goalpost_rgb(goalpost_rgb), 
         .ball_rgb(ball_rgb), 
         .player1_on(player1_on), .player2_on(player2_on), 
         .goalpost_on(goalpost_on), .ball_on(ball_on),
        .rgb(rgb));
    //////
endmodule
