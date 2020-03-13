module control(
	input clk, resetn, load, go,
	output reg ld_x, ld_y, ld_color, writeEn);

	reg [2:0] current_state, next_state;

	localparam  LOAD_X = 3'b000,
				LOAD_X_WAIT = 3'b001,
				LOAD_Y = 3'b010,
				LOAD_Y_WAIT = 3'b011,
				PLOT = 3'b100;
	
	always @(*) 
	begin: state_table
		case (current_state)
			LOAD_X: next_state = load ? LOAD_X_WAIT : LOAD_X;
			LOAD_X_WAIT: next_state = load ? LOAD_X_WAIT : LOAD_Y;
			LOAD_Y: next_state = go ? LOAD_Y_WAIT : LOAD_Y;
			LOAD_Y_WAIT: next_state = go ? LOAD_Y_WAIT : PLOT;
			PLOT: next_state = load ? LOAD_X : PLOT;
			default: next_state = LOAD_X;
		endcase
	end

	always @(*)
	begin
		ld_x = 1'b0;
		ld_y = 1'b0;
		ld_color = 1'b0;
		writeEn = 0;
		case (current_state)
			LOAD_X: ld_x = 1;
			LOAD_X_WAIT: ld_x = 1;
			LOAD_Y: 
				begin
					ld_x = 0;
					ld_y = 1;
					ld_color = 1;
				end
			LOAD_Y_WAIT: 
				begin
					ld_x = 0;
					ld_y = 1;
					ld_color = 1;
				end
			PLOT: writeEn = 1;
		endcase
	end

	always @(posedge clk) begin
		if (!resetn)
			current_state <= LOAD_X;
		else
			current_state <= next_state;
	end 

endmodule

module datapath(
	input clk, resetn, ld_x, ld_y, ld_color,
	input [2:0] color_in,
	input [6:0] coordinate, 
	output [7:0] x_out, 
	output [6:0] y_out, 
	output [2:0] color_out
	);

	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] color;
	reg [3:0] counter;

		always @(posedge clk) begin
		if (!resetn) begin
			x <= 8'b0;
			y <= 7'b0;
			color <= 3'b0;
		end
		else begin
			if (ld_x)
				x <= {1'b0, coordinate};
			if (ld_y)
				y <= coordinate;
			if (ld_color)
				color <= color_in;
		end
	end
	
	always @(posedge clk) begin
		if (!resetn)
			counter <= 4'b0000;
		else
			if (counter == 1111)
				counter <= 4'b0000;
			else
				counter <= counter + 1'b1;
	end

	assign x_out = x + counter[1:0];
	assign y_out = y + counter[3:2];
	assign color_out = color;
    
endmodule