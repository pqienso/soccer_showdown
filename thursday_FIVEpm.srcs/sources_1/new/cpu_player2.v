`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 15:00:20
// Design Name: 
// Module Name: cpu_player2
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


module cpu_player2(input clk,
                   input clock_8deciHz,
                   input clock_1pt3Hz,
                   input reset,  //reset the controls after each score increment
                   // position of cpu and ball
                   input [31:0] p1Sx, input [31:0] p1Sy,
                   input [31:0] cpuSx, input [31:0] cpuSy,
                   input [31:0] ballSx, input  [31:0] ballSy,
                   // velocity of p1, ball
                   input signed [31:0] ballVx, input signed [31:0] ballVy,
                   input signed [31:0] p1Vx,
                   // difficulty level
                   input [1:0] difficulty_level,
                   input [3:0] p1Score, input [3:0]cpuScore,
                   output reg left, output reg right, output reg kick, output reg jump);
    
    //reg [31:0] predicted_ballSx;
    //reg [31:0] predicted_ballSy;
         
    //reg [31:0] target_cpuSx;
    //reg [31:0] target_cpuSy; 
    
    wire [31:0] easy_L;
    wire [31:0] easy_R;
    wire [31:0] easy_U;
    wire [31:0] easy_K;
           
    lcg_easyL easy_LEFT(clock_1pt3Hz, reset, easy_L);
    //lcg_easyR easy_RIGHT(clock_8deciHz, reset, easy_R);
    lcg_easyU easy_UP(clock_1pt3Hz, reset, easy_U);
    lcg_easyK easy_KICK(clock_1pt3Hz, reset, easy_K);
    
    reg too_largeGap = 0;
    
    reg [7:0] easy_mode = 166;   // 65% of 255
    reg [7:0] medium_mode = 204; // 80% of 255
    reg [7:0] hard_mode = 230;   // 90% of 255 
    wire [7:0] random_num1;
    wire [7:0] random_num2;
    wire [7:0] random_num3;
    wire [7:0] random_num4;

    // initialise Linear Congruential Generator
    linear_congruential_generator lcg1(clock_8deciHz,reset,random_num1);
    linear_congruential_generator lcg2(clock_8deciHz,reset,random_num2);
    linear_congruential_generator lcg3(clock_8deciHz,reset,random_num3);
    linear_congruential_generator lcg4(clock_8deciHz,reset,random_num4);

    always @(posedge clk, posedge reset) begin 
        if (reset) begin
            left <= 0;
            right <= 0;
            jump <= 0;
            kick <= 0;
        end   
        else begin //asssertion game is still on-going
                      
            if (difficulty_level == 0) begin
            
            left = (cpuSx >= 80 && cpuSx <= 96 )? 1 : // if cpu collided to too far right, move left
                   (easy_L >= 128 || (cpuSx >= 0 && cpuSx <= 16)) ? 0 : 1;  // if cpuSx is too near left OR random value >= 128, dont move left
                   
            right = (cpuSx >= 0 && cpuSx <= 16)? 1 :  // if cpu collided to too far left, move right 
                    (easy_L < 128 || (cpuSx >= 80 && cpuSx <= 96)) ? 0 : 1; // if cpuSx is too near right OR random value >= 128, dont move right
                    
            jump = (easy_U <= 70) ? 1 : 0;  // if random value <= 70, it will jump
            
            kick = (easy_K <= 128) ? 1 : 0; // if random value <= 128, it will kick  
            end
            
            else if (difficulty_level == 1 || difficulty_level == 2) begin 
                // CASE 1: ball is currently at CPU's left
                if (ballSx < cpuSx) begin    
                     // CASE 1A: (ball CPU P1): CPU go left, collide ball into left goal
                     // CASE 1B: (ball P1 CPU): CPU hit P1, P1 collide ball into left goal 
                     // CASE 1C: (ball is directly below P1, P1 collide with ball into left goal
                     // CASE 1D: (ball is directly above P1, p1 collide with p2                
                     if (ballSx <= p1Sx) begin 
                         if (p1Sx >= cpuSx) begin
                             left = 1;
                             right = 0;
                             jump = 0;
                             kick = 0;      
                         end else begin        
                             left = 1;
                             right = 0;
                             jump = 0;
                             kick = 1; 
                         end
                     end   
                              
                    // CASE 1E: (P1 ball CPU) 
                    else begin
                        // cpu is on his goalpost
                        if (cpuSx >80 && cpuSy >15) begin 
                            left = 1; 
                            right = 0;
                            kick = 0;
                            jump = 0;
                        end
                        // once cpu move out, cpuSy will decrease below 15
                        // cpu is not on his goal post
                        else begin
                            // CASE 1E: Player1 stay at his goal
                            if (p1Sx <= 20) begin
                                // CASE 1E(i) Player1 stay at his goal + ON GROUND
                                if (p1Sy <= 15) begin
                                    left = (cpuSx <= 76)? 0: 1;  
                                    right = ~left;
                                    jump = (ballSy > 25 && ballSx >78 && ballVy > 0)? 1 : 0; // previousl 0;
                                    kick = (left == 1) ? 1 : 0;
                                
                                // CASE 1E(ii) Player1 stay at his goal + ON GOALPOST (invariant: p1Sy >20)
                                end else begin
                                    left = 1;
                                    right = 0;
                                    jump = 0;
                                    kick = 1;      
                                end
                            end 
                        
                            // CASE 1F
                            // invariant: p1 is trying to run away from his goal post
                            else begin    
                                left = (p1Vx > 0)? 1 : 0;
                                right = 0;
                                // for blocking potential kick
                                jump = ((ballSx >= cpuSx - 15) && (ballSx <= cpuSx) && (ballSy > cpuSy) && (ballSy >= 15) && (ballVx > 12) && (ballVy >15)) ? 1 : 0;
                                kick = 1; 
                            end
                       end                  
                    end
                end
                
               // CASE 2: ball is currently at CPU's right (RISK OF OWN GOAL)            
                else if (ballSx > cpuSx) begin // (CPU BALL)
                    if (ballSx <= p1Sx) begin
                    //CASE 2A: (CPU ball P1) cpu go right jump over ball, CASE 1 take over 
                        left = 0;
                        right = 1;
                        // jump = (0 <= ballSx-cpuSx <= 10) ? 1 : 0;
                        jump = (ballSx <= 15 + cpuSx) ? 1: 0; 
                        kick = 0;
                    end
                    else begin  // invariant ballSx > p1Sx (CONFIRM LOSE if player1 is not stupid
                    // CASE 2B: ( CPU p1 ball)
                    // CASE 2C: (p1 CPU ball)
                        left = 0;
                        right = 1;
                        jump = 1; // jump over to other side of goal
                        kick = 0;
                    end
                end          
            end
            
            // check score gap is too large
            too_largeGap = (p1Score >= cpuScore + 3 || cpuScore >= p1Score + 3)? 3: 
                           (p1Score >= cpuScore + 2 || cpuScore >= p1Score + 2)? 2:
                           (p1Score >= cpuScore + 1 || cpuScore >= p1Score + 1)? 1:
                           0;
                           
            if (too_largeGap == 3) begin
           //     easy_mode = easy_mode + 25;
                medium_mode = 229;
                hard_mode = 255;  // 230 + 25
                               
             end else if(too_largeGap == 2) begin
           //     easy_mode = easy_mode + 15;
                medium_mode = 219;
                hard_mode = 245;
             end else if(too_largeGap == 1) begin
           //     easy_mode = easy_mode + 5;
                medium_mode = 209;
                hard_mode = 235;                
             end else begin // score diff is NOT larger than treshold
           //     easy_mode = 166;
                medium_mode = 204; 
                hard_mode = 230; 
            end
            
            case (difficulty_level)
                0: begin
                    left <= left;
                    right <= right;
                    kick <= kick;
                    jump <= jump;
                   end
                1: begin  
                // medium as intended CPU motion = (95%)^4 = 81.5%
                // if scoreGap too large, intended CPU motion = 88% 
                    left <= (random_num1 <= medium_mode) ? left : ~left;
                    right <= (random_num2 <= medium_mode) ? right : ~right;
                    kick <= (random_num3 <= medium_mode) ? kick : ~kick;
                    jump <= (random_num4 <= medium_mode) ? jump : ~jump;  
                   end
                2: begin  
                // hard as intended CPU motion = (98%)^4 = 92.2%
                // if scoreGap too large, intended CPU motion = 100%
                    left <= (random_num1 <= hard_mode) ? left : ~left;
                    right <= (random_num2 <= hard_mode) ? right : ~right;
                    kick <= (random_num3 <= hard_mode) ? kick : ~kick;
                    jump <= (random_num4 <= hard_mode) ? jump : ~jump;  
                   end
            endcase
        end
    end  
    endmodule