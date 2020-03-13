module control(
	input clk, resetn, load, go,
	output reg ld_plot, writeEn);

	reg [2:0] current_state, next_state;

	localparam  PLOT = 3'b000,
				PLAY = 3'b001;

	always @(*) 
	begin: state_table
		case (current_state)
			PLOT: next_state = go ? PLAY : PLOT;
			PLAY: next_state = PLAY;
			default: next_state = PLOT;
		endcase
	end

	always @(*)
	begin
		ld_plot = 1;
		writeEn = 1;
		case (current_state)
			PLOT: ld_plot = 1;
			PLAY: ld_plot = 0;
		endcase
	end

	always @(posedge clk) begin

		if (!resetn)
			current_state <= PLOT;
		else
			current_state <= next_state;
	end 

endmodule

module datapath(
	input clk, resetn, ld_plot,
	input [2:0] color_in,
	input [6:0] coordinate, 
	output [7:0] x_out, 
	output [6:0] y_out, 
	output [2:0] color_out
	);d25
	reg [7:0] x;
	reg [6:0] y;
	reg [7:0] player1x;
	reg [6:0] player1y;
	reg [2:0] color;
	reg [3:0] counter;
	
	initial begin
		x = 8'd20;
		y = 7'd20;d25
		player1x = 8'd21;
		player1y = 8'd21;
	end
//	always @(posedge clk) begin
//		if (!resetn) begin	ram32x4 myram(SW[8:4],clock,SW[3:0],SW[9], q);

//			x <= 8'b0;d20module playerControl
//			y <= 7'b0;
//			color <= 3'b0;
//		end
//		else begin
//			if (ld_x)
//				x <= {1'b0, coordinate};
//			if (ld_y)
//				y <= coordinate;
//			if (ld_color)
//				color <= color_in;
//		end
//	end
		
	always @(posedge clk) begin
		if (ld_plot) begin
			if (x  < 50 && y == 20)
				x <= x + 1'b1;
			else if (x == 50 && y < 50)
				y <= y + 1'b1;
			else if (x > 20 && y == 50)
				x <= x - 1'b1;
			else if (x == 20 && y > 20)
				y <= y - 1'b1;
		end
		else begin
			player1_x <= player1_x + 1;
			
	end

	assign x_out = (ld_plot) ? x : player1x + coordinate;
	assign y_out = (ld_plot) ? y: player1y;
	assign color_out = color_in;
    
endmodule