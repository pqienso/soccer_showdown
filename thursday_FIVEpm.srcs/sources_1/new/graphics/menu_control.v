`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2024 11:32:21 AM
// Design Name: 
// Module Name: menu_control
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


module menu_control(input CLOCK, clk25mhz,
    input [6:0]x, input [5:0] y, 
    input menu_state, // 0: start page, 1: single player page
    input [1:0]pos, //position of selection, up to 2
    output reg [15:0] rgb = 0);
    
    parameter thickness= 2;
    parameter box_width = 57;
    parameter box_height = 11;
    
    //reference to upper left x and y coordinates
    parameter default_x = 19;
    parameter default_y = 24;
    parameter distance_y = 12; //y distance between top left coordinate of each box
    reg [6:0] x1, x2, x3, x4, centre_x;
    reg [5:0] y1, y2, y3, y4;
        
    wire [15:0] menu1_rgb, menu2_rgb;
    menu_1_rom menu1(.clk(CLOCK), .row(y), .col(x), .color_data(menu1_rgb));
    menu_2_rom menu2(.clk(CLOCK), .row(y), .col(x), .color_data(menu2_rgb));
    
    always @ (posedge clk25mhz) begin
        //x1 and y1 coordinates are top left
        //x1 to x4 is left to right
        //y1 to y4 is top to bottom
        x1 = default_x;
        x2 = x1 + thickness;
        x3 = x1 + box_width - thickness;
        x4 = x1 + box_width;
        
        y1 = default_y + pos*distance_y;
        y2 = y1 + thickness;
        y3 = y1 + box_height - thickness;
        y4 = y1 + box_height;
    
        if( (x >= x1 && x <= x4 && y >= y1 && y <= y4)
         && !(x >= x2 && x <= x3 && y <= y3 && y >= y2)) begin // for green border, overlays the menu rgb
            rgb <= 16'h7E0;
        end
        else if(~menu_state) begin 
            rgb <= menu1_rgb;
        end
        else begin
            rgb <= menu2_rgb;
        end
    end
endmodule
