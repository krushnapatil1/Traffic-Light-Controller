`timescale 1ns/1ps

module traffic_light_controller (
    input clk,
    input reset,

    output reg ns_green,
    output reg ns_yellow,
    output reg ns_red,
    output reg ew_green,
    output reg ew_yellow,
    output reg ew_red
);

    //Parameters
    parameter NS_GREEN = 2'b00;
    parameter NS_YELLOW = 2'b01;
    parameter EW_GREEN = 2'b10;
    parameter EW_YELLOW = 2'b11;

    parameter GREEN_TIME = 10;
    parameter YELLOW_TIME = 3;

    //Registers
    reg [1:0] state;
    reg [1:0] next_state;

    reg [3:0] counter;
    reg timer_done;


    //STATE REGISTER
    always @(posedge clk or posedge reset) begin
        if(reset)
            state <= NS_GREEN;
        else
            state <= next_state;
    end
    

    //COUNTER BLOCK
    always@ (posedge clk or posedge reset) begin
        if(reset) begin
            counter <= 0;
            timer_done <= 0;
        end

        else begin
            
            timer_done <= 1'b0;

            case(state)

                NS_GREEN: begin
                    if(counter == GREEN_TIME - 1) begin
                        timer_done <= 1'b1;
                        counter <= 0;
                    end
                    else
                        counter <= counter + 1;
                end

                NS_YELLOW: begin
                    if(counter == YELLOW_TIME - 1) begin
                        timer_done <= 1'b1;
                        counter <= 0;
                    end
                    else
                        counter <= counter + 1;
                end

                EW_GREEN: begin
                    if(counter == GREEN_TIME - 1) begin
                        timer_done <= 1'b1;
                        counter <= 0;
                    end
                    else
                        counter <= counter + 1;
                end

                EW_YELLOW: begin
                    if(counter == YELLOW_TIME - 1) begin
                        timer_done <= 1'b1;
                        counter <= 0;
                    end
                    else
                        counter <= counter + 1;
                end

                default: begin
                    counter <= 0;
                    timer_done <= 1'b0;
                end
            endcase
        end
    end


    //NEXT STATE LOGIC
    always@ (*) begin
        
        //Default
        next_state = state;

        case (state)
            
            NS_GREEN:
            begin
                if(timer_done)
                    next_state = NS_YELLOW; 
            end 

            NS_YELLOW:
            begin
                if(timer_done)
                    next_state = EW_GREEN; 
            end

            EW_GREEN:
            begin
                if(timer_done)
                    next_state = EW_YELLOW; 
            end

            EW_YELLOW:
            begin
                if(timer_done)
                    next_state = NS_GREEN; 
            end

            default: 
                next_state = NS_GREEN;
        endcase
    end



    //OUTPUT LOGIC
    always @(*) begin

        ns_green = 1'b0;
        ns_yellow = 1'b0;
        ns_red = 1'b0;
        ew_green = 1'b0;
        ew_yellow = 1'b0;
        ew_red = 1'b0;

        case(state)

            NS_GREEN: begin
                ns_green = 1'b1;
                ew_red = 1'b1;
            end

            NS_YELLOW: begin
                ns_yellow = 1'b1;
                ew_red = 1'b1;
            end

            EW_GREEN: begin
                ns_red = 1'b1;
                ew_green = 1'b1;
            end

            EW_YELLOW: begin
                ns_red = 1'b1;
                ew_yellow = 1'b1;
            end

        endcase
    end


endmodule