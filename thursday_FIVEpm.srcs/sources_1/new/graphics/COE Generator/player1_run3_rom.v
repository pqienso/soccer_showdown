module player1_run3_rom(
    input [12:0] pixel_index,
    input [3:0] row,
    input [3:0] col,
    output reg [15:0] color_data);

	(* rom_style = "block" *)

	always @ pixel_index
	case ({row, col})
		8'b00000000: color_data = 16'b1101110111010010;
		8'b00000001: color_data = 16'b1101110111010010;
		8'b00000010: color_data = 16'b1101110111010010;
		8'b00000011: color_data = 16'b1001001111101100;
		8'b00000100: color_data = 16'b0100001000100111;
		8'b00000101: color_data = 16'b0011101011101001;
		8'b00000110: color_data = 16'b0100101001100111;
		8'b00000111: color_data = 16'b1011010011101111;
		8'b00001000: color_data = 16'b1101110111010010;
		8'b00001001: color_data = 16'b1101110111010010;

		8'b00010000: color_data = 16'b1101110111010010;
		8'b00010001: color_data = 16'b1101010110110001;
		8'b00010010: color_data = 16'b1011110100110000;
		8'b00010011: color_data = 16'b0001001010101001;
		8'b00010100: color_data = 16'b0011011111011010;
		8'b00010101: color_data = 16'b0010111000010100;
		8'b00010110: color_data = 16'b0010010100110001;
		8'b00010111: color_data = 16'b0010100101000100;
		8'b00011000: color_data = 16'b1100110101110001;
		8'b00011001: color_data = 16'b1101110111010010;

		8'b00100000: color_data = 16'b1001110001001101;
		8'b00100001: color_data = 16'b0001001010001000;
		8'b00100010: color_data = 16'b0000100110000101;
		8'b00100011: color_data = 16'b0010111010010110;
		8'b00100100: color_data = 16'b0001001000000111;
		8'b00100101: color_data = 16'b0101001101101110;
		8'b00100110: color_data = 16'b1001010100010100;
		8'b00100111: color_data = 16'b1001010011110100;
		8'b00101000: color_data = 16'b0011000110100110;
		8'b00101001: color_data = 16'b1101010110110001;

		8'b00110000: color_data = 16'b0110001010101000;
		8'b00110001: color_data = 16'b0010111011011000;
		8'b00110010: color_data = 16'b0000101001001001;
		8'b00110011: color_data = 16'b0011011100011000;
		8'b00110100: color_data = 16'b0010000110100111;
		8'b00110101: color_data = 16'b1000110110111000;
		8'b00110110: color_data = 16'b1001011000111010;
		8'b00110111: color_data = 16'b1001111000111010;
		8'b00111000: color_data = 16'b0100001011001011;
		8'b00111001: color_data = 16'b1100010100110000;

		8'b01000000: color_data = 16'b0101101001100111;
		8'b01000001: color_data = 16'b0010010100110111;
		8'b01000010: color_data = 16'b0000101001001010;
		8'b01000011: color_data = 16'b0011011101011001;
		8'b01000100: color_data = 16'b0001000011100100;
		8'b01000101: color_data = 16'b0011001001001001;
		8'b01000110: color_data = 16'b0011001001001001;
		8'b01000111: color_data = 16'b0011001000101001;
		8'b01001000: color_data = 16'b0010000100100100;
		8'b01001001: color_data = 16'b1101010110110001;

		8'b01010000: color_data = 16'b0100101001000111;
		8'b01010001: color_data = 16'b0010010100110111;
		8'b01010010: color_data = 16'b0000101000001001;
		8'b01010011: color_data = 16'b0011011110111010;
		8'b01010100: color_data = 16'b0010111010010110;
		8'b01010101: color_data = 16'b0010010011110001;
		8'b01010110: color_data = 16'b0010010011110001;
		8'b01010111: color_data = 16'b0001001101001011;
		8'b01011000: color_data = 16'b1010010001101101;
		8'b01011001: color_data = 16'b1101110111010010;

		8'b01100000: color_data = 16'b0110101011101001;
		8'b01100001: color_data = 16'b0001110011010101;
		8'b01100010: color_data = 16'b0000101001001010;
		8'b01100011: color_data = 16'b0010111010011001;
		8'b01100100: color_data = 16'b0011011111111011;
		8'b01100101: color_data = 16'b0011011111111011;
		8'b01100110: color_data = 16'b0011011111111011;
		8'b01100111: color_data = 16'b0010010100010001;
		8'b01101000: color_data = 16'b1010110010001110;
		8'b01101001: color_data = 16'b1101110111010010;

		8'b01110000: color_data = 16'b1001001111101100;
		8'b01110001: color_data = 16'b0001001001101011;
		8'b01110010: color_data = 16'b0000100110000111;
		8'b01110011: color_data = 16'b0010010101010111;
		8'b01110100: color_data = 16'b0010111010111001;
		8'b01110101: color_data = 16'b0011011100111010;
		8'b01110110: color_data = 16'b0011011100111010;
		8'b01110111: color_data = 16'b0001001010001010;
		8'b01111000: color_data = 16'b1100110110010001;
		8'b01111001: color_data = 16'b1101110111010010;

		8'b10000000: color_data = 16'b1001110000101101;
		8'b10000001: color_data = 16'b0000100110100111;
		8'b10000010: color_data = 16'b0000101000001001;
		8'b10000011: color_data = 16'b0001001110010000;
		8'b10000100: color_data = 16'b0010010100110111;
		8'b10000101: color_data = 16'b0010010100110111;
		8'b10000110: color_data = 16'b0010010100110111;
		8'b10000111: color_data = 16'b0001001001001010;
		8'b10001000: color_data = 16'b1011110011101111;
		8'b10001001: color_data = 16'b1101110111010010;

		8'b10010000: color_data = 16'b1001001111001100;
		8'b10010001: color_data = 16'b0001001101001111;
		8'b10010010: color_data = 16'b0010010100010111;
		8'b10010011: color_data = 16'b0001001011101101;
		8'b10010100: color_data = 16'b0001000011100011;
		8'b10010101: color_data = 16'b0001001000101001;
		8'b10010110: color_data = 16'b0010010100010111;
		8'b10010111: color_data = 16'b0010010011110110;
		8'b10011000: color_data = 16'b0010100110100110;
		8'b10011001: color_data = 16'b1101010110010001;

		8'b10100000: color_data = 16'b1101110111010010;
		8'b10100001: color_data = 16'b0110001010101000;
		8'b10100010: color_data = 16'b0001000111101000;
		8'b10100011: color_data = 16'b0000101000001001;
		8'b10100100: color_data = 16'b1000001101101010;
		8'b10100101: color_data = 16'b1001110000101101;
		8'b10100110: color_data = 16'b0001001010101100;
		8'b10100111: color_data = 16'b0010010100110111;
		8'b10101000: color_data = 16'b0001001101001110;
		8'b10101001: color_data = 16'b1010110010001110;

		8'b10110000: color_data = 16'b1101110111010010;
		8'b10110001: color_data = 16'b1101110111010010;
		8'b10110010: color_data = 16'b1101010110110001;
		8'b10110011: color_data = 16'b1100110110010001;
		8'b10110100: color_data = 16'b1101110111010010;
		8'b10110101: color_data = 16'b1101110111010010;
		8'b10110110: color_data = 16'b0110101011101001;
		8'b10110111: color_data = 16'b0000100111101000;
		8'b10111000: color_data = 16'b0010000110100110;
		8'b10111001: color_data = 16'b1100110101110001;

		default: color_data = 16'b0000000000000000;
	endcase
endmodule