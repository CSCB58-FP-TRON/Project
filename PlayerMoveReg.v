module playerRegister(

    /* Let 00 Represent UP
     * Let 01 Represent RIGHT
     * Let 10 Represent DOWN
     * Let 11 Represent LEFT
     */ 
    input CLOCK_50,
    input [1:0] directionIN,directionCURRENT,
    output reg [1:0] directionOUT
    );
    always(posedge CLOCK_50) begin
        case(directionIN)
            2'b00: begin
                if(directionCURRENT == 2'b10)
                    directionOUT <= directionCURRENT
                else
                    directionOUT <= directionIN
            end

            2'b01: begin
                if(directionCURRENT == 2'b11)
                    directionOUT <= directionCURRENT
                else
                    directionOUT <= directionIN
            end

            2'b10: begin
                if(directionCURRENT == 2'b00)
                    directionOUT <= directionCURRENT
                else
                    directionOUT <= directionIN
            end

            2'b11: begin
                if(directionCURRENT == 2'b01)
                    directionOUT <= directionCURRENT
                else
                    directionOUT <= directionIN
            end
        endcase
    end
    
endmodule