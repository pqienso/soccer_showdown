module DebouncerSim ();

 reg [31:0] activeClockCycles = 5, waitingClockCycles = 15, in = 1;
 reg CLK = 0;
 
 wire out;

 Debouncer dut(.activeClockCycles(activeClockCycles), .clock(CLK), .waitingClockCycles(waitingClockCycles),
 .in(in), .out(out));

 always begin
    CLK <= ~CLK; #1;
 end
 
 always begin
    in = !in; #10;
 end


endmodule
