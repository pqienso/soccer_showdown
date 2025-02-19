`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 15:09:26
// Design Name: 
// Module Name: flexible_clock
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


module flexible_clock(
    input [31:0] m,
    input CLOCK_IN,
    output reg CLOCK_OUT = 0
    );
    reg [31:0] COUNTER = 0;
    
    always @ (posedge CLOCK_IN) begin
        COUNTER = COUNTER + 1;
        if(COUNTER == m) begin
            COUNTER = 0;
            CLOCK_OUT = ~CLOCK_OUT;
        end
    end
endmodule
