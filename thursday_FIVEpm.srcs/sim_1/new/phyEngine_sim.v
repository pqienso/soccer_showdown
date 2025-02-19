module phyEngine_sim ();
wire signed [31:0] sx;
wire signed [31:0] sy;
wire signed [31:0] vx;
wire signed [31:0] vy;
wire signed [31:0] pixelx = sx >> 16;
wire signed [31:0] pixely = sy >> 16;
reg clk = 0;

 physicsEngine_ball physicsEngine (
        .addVx(0),
        .addVy(0),
        .basysClock(clk),
        .reset(0),
        .vx(vx),
        .vy(vy),
        .sx(sx),
        .sy(sy));
        
  always begin
            clk = ~clk; #1;
  end

endmodule