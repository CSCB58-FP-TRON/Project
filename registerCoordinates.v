module registerCoordinates(
    input CLOCK_50,reset,
    input [1:0] direction,
    input [7:0] xINITIAL,
    input [6:0] yINITIAL,
    output reg [7:0] x,
    output reg [6:0] y
    );
    initial begin
        x = xINITIAL;
        Y = yINITIAL;
    end

    always@(posedge CLOCK_50) begin
        if(reset == 1'b1) begin
            x = xINITIAL;
            Y = yINITIAL;
        end
        else begin
            case(direction)
                2'b00: y = y + 1'b1;

                2'b01: x = x + 1'b1;

                2'b10: y = y - 1'b1;

                2'b11: x = x - 1'b1;
            endcase
        end
    end

endmodule