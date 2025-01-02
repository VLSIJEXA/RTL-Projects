`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2025 08:59:41 PM
// Design Name: 
// Module Name: Password_Authentication_System_RTL
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


module Password_Authentication_System_RTL(
input clk,reset,input [7:0]password_enter,output reg auth_passed

    );
    
    parameter [7:0]PASSWORD=8'hA6;
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    auth_passed<=0;
    else if(password_enter==PASSWORD)
    auth_passed<=1'b1;
    else
    begin
    auth_passed<=1'b0;
    end
    
    end
endmodule
//Testbench/////////////
module testbench;
  reg clk;
             reg reset;
             reg [7:0] password_enter;
             wire auth_passed;

             
             Password_Authentication_System_RTL uut (
                 .clk(clk),
                 .reset(reset),
                 .password_enter(password_enter),
                 .auth_passed(auth_passed)
             );

           always begin
                 #5 clk = ~clk; 
             end
initial begin
                
                 clk = 0;
                 reset = 0;
                 password_enter = 8'b0;

                 
                 $display("Test 1: Apply reset");
                 reset = 1;
                 #10; 
                 reset = 0;

                
                 $display("Test 2: Enter correct password (8'hA6)");
                 password_enter = 8'hA6;
                 #10;  

                
                 $display("Test 3: Enter wrong password (8'hFF)");
                 password_enter = 8'hFF;
                 #10;  
                 
                 $display("Test 4: Enter correct password again (8'hA6)");
                 password_enter = 8'hA6;
                 #10;  

                 
                 $display("Test 5: Apply reset during wrong password entry");
                 reset = 1;
                 password_enter = 8'hFF;  
                 #10;
                 reset = 0;

               
               $display("Test 6: Enter correct password after reset (8'hA6)");
                 password_enter = 8'hA6;
                 #10;
               $finish;
             end
 initial begin
                 $monitor("At time %t, auth_passed = %b", $time, auth_passed);
             end
 endmodule
