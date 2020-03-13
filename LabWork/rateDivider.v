module RateDivider(clock, speed, clear_b, q);
    input [1:0] speed;
    input clock, clear_b;
    output q;

    reg [27:0] rateDivider;

    assign q = (rateDivider == 28'b0000000000000000000000000000) ? 1 : 0;

    always @(posedge clock)
    begin 
        if(clear_b == 1'b0)
            rateDivider <= 0;
        else if (rateDivider == 0)
            case(speed[1:0])
                2'b00: rateDivider <= 28'b0000000000000000000000000000; //Full (50MHz)
                2'b01: rateDivider <= 28'b0010111110101111000001111111; //1 Hz
                2'b10: rateDivider <= 28'b0101111101011110000011111111; //0.5 Hz
                2'b11: rateDivider <= 28'b1011111010111100000111111111; //0.25 Hz
            endcase
        else
            rateDivider <= rateDivider - 1'b1;

    end
endmodule
