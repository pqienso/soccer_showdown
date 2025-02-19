`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2024 21:11:10
// Design Name: 
// Module Name: Debouncer
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


module Debouncer(
    input [31:0] waitingClockCycles,
    input [31:0] activeClockCycles,
    input clock,
    input [31:0] in,
    output reg [31:0] out = 0
    );
    
    reg [31:0] counter = 0;
    
    always @ (posedge clock) begin
        if (in != 0 && counter == 0) begin
            counter = 1;
            out = in;
        end
        else if (counter <= activeClockCycles) begin
            out = in;
        end
        else begin
            out = 0;
        end
    
        if (counter == 0) begin
        end
        else if (counter <= waitingClockCycles) begin
            counter = counter + 1;
        end
        else begin
            counter = 0;
        end
        
        
    end
    
endmodule
