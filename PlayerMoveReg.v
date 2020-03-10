module playerRegister(

    /* Let 00 Represent UP
     * Let 01 Represent RIGHT
     * Let 10 Represent DOWN
     * Let 11 Represent LEFT
     */ 
    input CLOCK_50,
    input [1:0] directionIN,
    output reg [1:0] directionOUT
    );
    reg directionCURR;
    initial
        directionCURR = 2'b00;
    always(posedge CLOCK_50) begin
        case(directionIN)
            2'b00: begin
                if()

            end
    end