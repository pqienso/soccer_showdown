module ball_4_rom(
    input [12:0] pixel_index,
    input [2:0] row,
    input [2:0] col,
    output reg [15:0] color_data);

	(* rom_style = "block" *)

	always @ pixel_index
	case ({row, col})
		6'b000000: color_data = 16'b0000010010110110;
		6'b000001: color_data = 16'b0000001111110010;
		6'b000010: color_data = 16'b0000000100100101;
		6'b000011: color_data = 16'b1000110011010011;
		6'b000100: color_data = 16'b1001010111011000;
		6'b000101: color_data = 16'b0001010000110011;
		6'b000110: color_data = 16'b0000010010110110;

		6'b001000: color_data = 16'b0000010001110100;
		6'b001001: color_data = 16'b1011111001011001;
		6'b001010: color_data = 16'b1110111101011101;
		6'b001011: color_data = 16'b1111011110011110;
		6'b001100: color_data = 16'b1110011100111100;
		6'b001101: color_data = 16'b0001000011000011;
		6'b001110: color_data = 16'b0000001110110001;

		6'b010000: color_data = 16'b0011001111110001;
		6'b010001: color_data = 16'b1110011100011100;
		6'b010010: color_data = 16'b1100111001111001;
		6'b010011: color_data = 16'b0111001110101110;
		6'b010100: color_data = 16'b1110111101111101;
		6'b010101: color_data = 16'b1010110101110101;
		6'b010110: color_data = 16'b0100110000010001;

		6'b011000: color_data = 16'b0000000111001000;
		6'b011001: color_data = 16'b1110011100111100;
		6'b011010: color_data = 16'b1000010000010000;
		6'b011011: color_data = 16'b0000000000000000;
		6'b011100: color_data = 16'b1000010000010000;
		6'b011101: color_data = 16'b1110011100111100;
		6'b011110: color_data = 16'b1001111000011001;

		6'b100000: color_data = 16'b0011001111110001;
		6'b100001: color_data = 16'b1110011100011100;
		6'b100010: color_data = 16'b1100111001111001;
		6'b100011: color_data = 16'b0111001110101110;
		6'b100100: color_data = 16'b1111011110011110;
		6'b100101: color_data = 16'b1100011000111000;
		6'b100110: color_data = 16'b0101010001110010;

		6'b101000: color_data = 16'b0000010001110100;
		6'b101001: color_data = 16'b1011010111111000;
		6'b101010: color_data = 16'b1100011000011000;
		6'b101011: color_data = 16'b1110111101011101;
		6'b101100: color_data = 16'b1110011100111100;
		6'b101101: color_data = 16'b0010100101000101;
		6'b101110: color_data = 16'b0000001110010000;

		6'b110000: color_data = 16'b0000010010110110;
		6'b110001: color_data = 16'b0000001111010010;
		6'b110010: color_data = 16'b0000000100000100;
		6'b110011: color_data = 16'b1000010010110010;
		6'b110100: color_data = 16'b1001010111010111;
		6'b110101: color_data = 16'b0001010000110011;
		6'b110110: color_data = 16'b0000010010110110;

		default: color_data = 16'b0000000000000000;
	endcase
endmodule