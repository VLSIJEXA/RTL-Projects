`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2025 10:20:50 AM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;
reg [15:0] a;
  reg [15:0] b;
  reg c;
 wire [16:0] s;

  
  newCSKA uut (.a(a),.b(b), .c(c),.s(s) );

 
  initial begin
   
    $monitor("a = %h, b = %h, c = %b, s = %h", a, b, c, s);
     a = 16'hFFFF; b = 16'h0001; c = 0;
    #10; 
    a = 16'h1234; b = 16'h5678; c = 1;
    #10;
    a = 16'hABCD; b = 16'h4321; c = 0;
    #10;
    a = 16'h0000; b = 16'h0000; c = 0;
    #10;
    a = 16'hFFFF; b = 16'hFFFF; c = 1;
    #10;
    a = 16'hAAAA; b = 16'h5555; c = 0;
    #10;
     a = 16'hFFFF; b = 16'hFFFF; c = 1;
    #10;
    $finish;
  end

endmodule
