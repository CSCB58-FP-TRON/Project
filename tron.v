// Made by Manav Patel and Simar Bassi


module main
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
        // Other outputs
        HEX0,
        HEX1,
        HEX2,
        HEX3,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [17:0]   SW;				//SW[11] X register write
	input   [3:0]   KEY;

	// Declare your inputs and outputs here

    output [6:0] HEX0, HEX1, HEX2, HEX3;

	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;//(r,g,b)
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";



	//insantiate control
	control movementControl(
			.clk(CLOCK_50),
			.resetn(resetn),
			.load(),
			.go(),
			.ld_x(),
			.ld_y(),
			.ld_color(),
			.writeEn()
	);

	//instantiate datapath
	datapath movementFlow(
			.clk(CLOCK_50),
			.resestn(resetn),
			.ld_x(),
			.ld_y(),
			.ld_color(),
			.color_in(),
			.coordinate(),
			.x_out(),
			.y_out(),
			.colout_out()
	);


	playerRegister player1(.clk(), .directionIn(), .directionCURRENT(), .directionOUT());
	playerRegister player2(.clk(), .directionIn(), .directionCURRENT(), .directionOUT());


	wire [7:0] scanCodeOut;
	wire scanCodeReady;
	wire case_out;
	keyboard inputKeyboard(
			.clk(CLOCK_50), 
			.reset(resestn),
        	.ps2d(),
			.ps2c(),  
        	.scan_code(scanCodeOut),
        	.scan_code_ready(scanCodeReady),
        	.letter_case_out(case_out)
    );


	wire [7:0] asciiOut;
	
	key2ascii key2asc(
			.letter_case(case_out),
			.scan_code(scanCodeReady),
			.ascii_code(asciiOut)
	);

	wire [1:0] p1Input, p2Input;

	always @(*)
		case ()


endmodule







module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule
