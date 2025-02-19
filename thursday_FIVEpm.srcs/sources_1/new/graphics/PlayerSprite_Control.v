`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2024 05:17:35 PM
// Design Name: 
// Module Name: PlayerSprite_Control
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


module PlayerSprite_Control(input [6:0]x,input [5:0] y, //Coordinates from OLED
    input walk_clk, input kick_clk, input [12:0] pixel_index,//clock cycles
    input player, //0:player1, 1:player2
     input [31:0] Sx, Sy, //Input for coordinates, relative to top left "rectangle" of sprite
     input direction, //Signals sprite to face left or right
     input [1:0] movement, //signals sprite's stand, walk, jump or kick animation 
     output reg player_on = 0, //output if the pixel is being used within the player_sprite
    output reg [15:0]rgb = 0); //Output Colour for current Sprite pixel
    
    //Boundaries for OLED display area    
    parameter MAX_X = 95;
    parameter MAX_Y = 63;
    
    // Players width and height
    parameter P_W = 10;
    parameter P_H = 12;
        
    //Default direction is RIGHT
    parameter LEFT = 0;
    parameter RIGHT = 1;
    ///
   
    //Current action
    parameter JUMP = 0;
    parameter IDLE = 1;
    parameter WALK = 2;
    parameter KICK = 3;
    ////
    
    ///ROM Coordinates
    wire [3:0] row;
    wire [3:0] col;
    wire sprite_on; //Indicates the pixels which should be displaying the sprite

    //Ensures that only one sprite is displayed by checking if its within width and height
    assign sprite_on =  (x >= Sx) && (x <= Sx + P_W - 1) && (y >= Sy) && (y <= Sy + P_H - 1) ? 1
                  :   0;
   
    //row and col represent the relative coordinates to the below roms to output the correct rgb data
    //This is based on the assumption that the given coordinates won't exceed the border
    //In row, the sprites are mirrored if they are facing the other direction.
    assign col = (~sprite_on) ? 0 :
                (direction == RIGHT) ? (x - Sx) :
                 (direction == LEFT) ? (P_W - 1 - (x - Sx)): 0;
    assign row = sprite_on ? y - Sy:0;
    
    //Output rgb for different player sprite animations
    
    //The correct player's animations is multiplexed into the below wires
    wire [15:0] stand_rgb, walk_rgb, jump_rgb, kick_rgb;
    ///Walking
    
    //Standing animations of player 1 & 2
    wire [15:0] stand1_rgb, stand2_rgb;
    player1_idle_rom p1standing(.pixel_index(pixel_index), .row(row), .col(col), .color_data(stand1_rgb)); 
    player2_idle_rom p2standing(.pixel_index(pixel_index), .row(row), .col(col), .color_data(stand2_rgb)); 
    //Mux into overall stand_rgb
    assign stand_rgb = ~player ? stand1_rgb:stand2_rgb;
    /////
    
    //Walking animations of player 1 & 2, already muxed inside
    walking_animation walk(.pixel_index(pixel_index), .walk_clk(walk_clk), .row(row), .col(col), .player(player),
             .rgb(walk_rgb));
    
    //Jumping animations of player 1 & 2
    wire [15:0] jump1_rgb, jump2_rgb;
    player1_run1_rom p1jump(.pixel_index(pixel_index), .row(row), .col(col), .color_data(jump1_rgb)); 
    player2_run1_rom p2jump(.pixel_index(pixel_index), .row(row), .col(col), .color_data(jump2_rgb)); 
    //Mux into overall jump_rgb
    assign jump_rgb = ~player ? jump1_rgb:jump2_rgb;
    /////
    
    //Kicking animations of player 1 & 2, already muxed inside
    kicking_animation kick(.pixel_index(pixel_index), .kick_clk(kick_clk),
        .row(row), .col(col), .player(player), .movement(movement), .rgb(kick_rgb));
    ////
    
    //Multiplexing the RGB of different player sprite animations
    always @ (pixel_index) begin
        player_on = 0;
        if(movement == KICK) begin
            rgb = kick_rgb;
        end
        else if(movement == JUMP) begin
            rgb = jump_rgb;
        end
        else if(movement == WALK) begin
            rgb = walk_rgb;
        end
        else if(movement == IDLE) begin
            rgb = stand_rgb;
        end
        if(rgb != 16'b1101110111010010) begin
            player_on = 1;
        end
    end
endmodule
