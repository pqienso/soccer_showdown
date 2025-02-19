`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 01:35:20
// Design Name: 
// Module Name: ResultantSim
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


module ResultantSim(

    );
    reg clk = 0;
    reg signed [31:0]x = 640, y = 980;
    wire [31:0] out;
    
    ResultantCalculator dut(
        clk,
        x, y,
        out
        );
    
    always begin
    clk = ~clk; #1;
    end
endmodule
