module playerRegister(

    /* Let 00 Represent UP
     * Let 01 Represent RIGHT
     * Let 11 Represent DOWN
     * Let 10 Represent LEFT
     */ 
    input clk,
    input [1:0] directionIN,directionCURRENT,
    output reg [1:0] directionOUT
    );

//    initial
//        directionCURRENT[1:0] = 2'b00; //Since both player 1 and 2 cannot go up since player 1 is going down and player 2 is already going up
//    
    always @(*) begin
        case(directionIN)
            2'b00: begin
                if(directionCURRENT == 2'b11)
                    directionOUT = directionCURRENT;
                else
                    directionOUT = directionIN;
            end

            2'b01: begin
                if(directionCURRENT == 2'b10)
                    directionOUT = directionCURRENT;
                else
                    directionOUT = directionIN;
            end

            2'b10: begin
                if(directionCURRENT == 2'b01)
                    directionOUT = directionCURRENT;
                else
                    directionOUT = directionIN;
            end

            2'b11: begin
                if(directionCURRENT == 2'b00)
                    directionOUT = directionCURRENT;
                else
                    directionOUT = directionIN;
            end
            default: directionOUT = directionCURRENT;
        endcase
    end

endmodule