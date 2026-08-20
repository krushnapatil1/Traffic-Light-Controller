`timescale 1ns/1ps

module tb_traffic_light_controller;

reg clk;
reg reset;

wire ns_green;
wire ns_yellow;
wire ns_red;
wire ew_green;
wire ew_yellow;
wire ew_red;


traffic_light_controller dut(
    .clk(clk),
    .reset(reset),
    .ns_green(ns_green),
    .ns_yellow(ns_yellow),
    .ns_red(ns_red),
    .ew_green(ew_green),
    .ew_yellow(ew_yellow),
    .ew_red(ew_red)
);


always #5 clk = ~clk;

initial begin
    
    $monitor("Time = %0t | Clk = %b | Reset = %b | ns_green = %b | ns_yellow = %b | ns_red = %b | ew_green = %b | ew_yellow = %b | ew_red = %b", $time, clk, reset, ns_green, ns_yellow, ns_red, ew_green, ew_yellow, ew_red);

end

initial begin
    
    $dumpfile("traffic_light_controller.vcd");
    $dumpvars(0, tb_traffic_light_controller);

    clk = 0;
    reset = 1;

    #10;
    reset = 0;

    #200;

    $finish;

end
    
endmodule