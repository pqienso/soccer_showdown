`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2024 08:23:12 PM
// Design Name: 
// Module Name: game_state
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


module game_state(input clk, btnC, btnU, btnD, input [31:0] ballSx, ballSy, 
    output reg [3:0] p1_score = 0, p2_score = 0, output reg [2:0] gamestate = 0, output reg player_win = 0, output reg reset = 1, 
    output reg isSinglePlayer = 0, output reg [1:0] menu_state = 0, output reg [1:0] position = 0, output reg [1:0] difficulty = 0
    );
    
    reg p1_scored;
    reg p2_scored;
    
    reg start_scoreScreen_timer = 0;
    wire scoreScreenTimer_out;
    
    reg start_startGame_timer = 0;
    wire startGameTimer_out;
    
    timer timer_3s(clk, start_scoreScreen_timer, 75_000_000, scoreScreenTimer_out);
    timer timer_4s(clk, start_startGame_timer, 100_000_000, startGameTimer_out);
    
    parameter win_score = 9;
    wire single_player;
    wire multi_player;
    
    wire buttonC;
    wire buttonU;
    wire buttonD;
    
    wire p1_scored_debounced;
    wire p2_scored_debounced;
    
    Debouncer btnC_debouncer (.waitingClockCycles(6250000), .activeClockCycles(1), .clock(clk), .in(btnC), .out(buttonC));
    Debouncer btnU_debouncer (.waitingClockCycles(6250000), .activeClockCycles(1), .clock(clk), .in(btnU), .out(buttonU));
    Debouncer btnD_debouncer (.waitingClockCycles(6250000), .activeClockCycles(1), .clock(clk), .in(btnD), .out(buttonD));
    Debouncer p1_debouncer (.waitingClockCycles(6250000), .activeClockCycles(1), .clock(clk), .in(p1_scored), .out(p1_scored_debounced));
    Debouncer p2_debouncer (.waitingClockCycles(6250000), .activeClockCycles(1), .clock(clk), .in(p2_scored), .out(p2_scored_debounced));
     
    always @ (posedge clk)
    begin        
        // MAIN MENU CODE
        if(menu_state == 0) begin
            if(buttonD) begin
                position <= 1;
            end
            if(buttonU) begin
                position <= 0;
            end
            if(buttonC)
            begin
                if(position) begin
                    reset <= 0;
                    p1_score <= 0;
                    p2_score <= 0;
                    isSinglePlayer <= 0;
                    gamestate <= 1;
                end
                else begin
                    p1_score <= 0;
                    p2_score <= 0;
                    menu_state <= 1;
                end
            end
        end
        else if(menu_state == 1) begin
            if(buttonD)
            begin
                if(position != 2)
                begin
                    position <= position + 1;
                end
            end
            else
            if(buttonU)
            begin
                if(position != 0)
                begin
                    position <= position - 1;
                end
            end
            
            if(buttonC)
            begin
                reset <= 0;
                difficulty <= position;
                p1_score <= 0;
                p2_score <= 0;
                isSinglePlayer <= 1;
                gamestate <= 1;
            end
        end
        
        
        // WHILE GAME IS PLAYING
        if(gamestate != 0)
        begin
            
            if((ballSx > 83) && (ballSy < 25))
            begin
                p1_scored <= 1;
            end
            else begin
                p1_scored <= 0;
            end
            
            if((ballSx < 13) && (ballSy < 25))
            begin
                p2_scored <= 1;
            end
            else begin
                p2_scored <= 0;
            end
            
            if(p1_scored_debounced && (p1_score < win_score)) begin
                p1_score <= p1_score + 1;
                reset <= 1;
                start_scoreScreen_timer <= 1;
                start_startGame_timer <= 1;
                gamestate <= 3;
            end
            else if(p2_scored_debounced && (p2_score < win_score)) begin
                p2_score <= p2_score + 1;
                reset <= 1;
                start_scoreScreen_timer <= 1;
                start_startGame_timer <= 1;
                gamestate <= 4;
            end
            else begin
                start_scoreScreen_timer <= 0;
                start_startGame_timer <= 0;
            end
            
            if(p1_score == win_score) begin
                isSinglePlayer <= 0;
                position <= 0;
                reset <= 1;
                player_win <= 0;
                gamestate <= 2;
                start_scoreScreen_timer <= 1;
            end
            else if(p2_score == win_score) begin
                isSinglePlayer <= 0;
                position <= 0;
                reset <= 1;
                player_win <= 1;
                gamestate <= 2;
                start_scoreScreen_timer <= 1;
            end
            
            
            if(scoreScreenTimer_out)
            begin
                start_scoreScreen_timer <= 0;
                if(p1_score == win_score || p2_score == win_score)
                begin
                    gamestate <= 0;
                    menu_state <= 0;
                end
                else
                begin
                    gamestate <= 1;
                end
            end
            
            if(startGameTimer_out) begin
                reset <= 0;
                start_startGame_timer <= 0;
            end
        end
    end
    
endmodule
