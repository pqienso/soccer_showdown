`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 15:13:40
// Design Name: 
// Module Name: testflexclock
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


module testflexclock(

    );
    
    reg CLOCK = 0;
    reg [31:0] m = 8;
    wire out;
    
    flexible_clock clock(m, CLOCK, out);
    
    always begin
    CLOCK = ~CLOCK; #1;
    end
endmodule
