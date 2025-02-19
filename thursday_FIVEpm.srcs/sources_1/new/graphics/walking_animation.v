`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 11:26:06 AM
// Design Name: 
// Module Name: walking_animation
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


module walking_animation(input [12:0] pixel_index, input walk_clk, input [3:0]row, input [3:0]col, 
    input player, 
    output [15:0]rgb);
    
    wire [15:0] rgb1, rgb2, rgb3, rgb4;
    reg [2:0]run_state = 0;
    
    //player 1
    wire [15:0] p1rgb1, p1rgb2, p1rgb3, p1rgb4;
    player1_run1_rom p1run1(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p1rgb1)); 
    player1_run2_rom p1run2(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p1rgb2)); 
    player1_run3_rom p1run3(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p1rgb3)); 
    player1_run4_rom p1run4(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p1rgb4)); 
    
    //player 2
    wire [15:0] p2rgb1, p2rgb2, p2rgb3, p2rgb4;
    player2_run1_rom p2run1(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p2rgb1)); 
    player2_run2_rom p2run2(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p2rgb2)); 
    player2_run3_rom p2run3(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p2rgb3)); 
    player2_run4_rom p2run4(.pixel_index(pixel_index), .row(row), .col(col), .color_data(p2rgb4)); 
    
    //Muxing the RGB outputs
    assign rgb1 = ~player ? p1rgb1: p2rgb1;
    assign rgb2 = ~player ? p1rgb2: p2rgb2;
    assign rgb3 = ~player ? p1rgb3: p2rgb3;
    assign rgb4 = ~player ? p1rgb4: p2rgb4;
    
    assign rgb = (run_state == 0) ? rgb1:
                (run_state == 1) ? rgb2:
                (run_state == 2) ? rgb3:
                (run_state == 3) ? rgb4: 0;
            
    always @ (posedge walk_clk) begin
        run_state = run_state + 1;
        if(run_state == 3) begin
            run_state = 0;
        end
    end 
endmodule
