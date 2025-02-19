`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2024 10:08:22 AM
// Design Name: 
// Module Name: ball_animation
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


module ball_animation(input ball_clk, input[12:0] pixel_index,
    input [1:0]direction, //direction is either idle, rotating left or right, 
    input [2:0]row, 
    input [2:0]col, output [15:0]rgb);
    
    //Default state is IDLE
    parameter IDLE = 0;
    parameter LEFT = 1;
    parameter RIGHT = 2;
    ///
    
    wire [15:0] rgb1, rgb2, rgb3, rgb4;
    reg [2:0] roll_state = 0;
    
    ball_1_rom roll_1(.pixel_index(pixel_index), .row(row), .col(col), .color_data(rgb1)); 
    ball_2_rom roll_2(.pixel_index(pixel_index), .row(row), .col(col), .color_data(rgb2)); 
    ball_3_rom roll_3(.pixel_index(pixel_index), .row(row), .col(col), .color_data(rgb3)); 
    ball_4_rom roll_4(.pixel_index(pixel_index), .row(row), .col(col), .color_data(rgb4)); 
    
    assign rgb = (roll_state == 0) ? rgb1: //changes output based on roll_state
                (roll_state == 1) ? rgb2:
                (roll_state == 2) ? rgb3:
                (roll_state == 3) ? rgb4: 0;
                    
    always @ (posedge ball_clk) begin      
        if(direction == LEFT) begin //Cycles it backwards
            if(roll_state == 0) begin
                roll_state = 3;
            end 
            else begin
                roll_state <= roll_state - 1; 
            end
        end
        else if(direction == RIGHT) begin //Cycles it forwards
            if(roll_state == 3) begin
                roll_state <= 0;
            end
            else begin
                roll_state <= roll_state + 1;
            end
        end
       //else no change in roll_state, image is constant    
     end
endmodule
