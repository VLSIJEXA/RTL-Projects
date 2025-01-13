`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2025 10:01:29 AM
// Design Name: 
// Module Name: newCSKA
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


module newCSKA( input[15:0]a,input c,input[15:0]b,output[16:0]s);


   wire t1, t6, t7;
wire [3:0] xor_ab; 
RCA_4bit x1(.a(a[3:0]), .b(b[3:0]), .cin(c), .cout(t1), .sum(s[3:0]));
genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin : xor_gen
        assign xor_ab[i] = a[i] ^ b[i];
    end
endgenerate
assign t6 = &xor_ab;
 inverter_cmos hyb_mux1(.control(t6),.in1(t1) ,.in2(c),.out(t7));


  
    wire q1, q6, q7;
wire [3:0] xor_ab2; 
RCA_4bit x2(.a(a[7:4]), .b(b[7:4]), .cin(t7), .cout(q1), .sum(s[7:4]));
genvar j;
generate
    for (j = 0; j < 4; j = j + 1) begin : xor_gen2
        assign xor_ab2[j] = a[4+j] ^ b[4+j];
    end
endgenerate
assign q6 = &xor_ab2; 

inverter_cmos hyb_mux2(.control(q6),.in1(q1) ,.in2(t7),.out(q7));

    
    wire m1, m6, m7;
wire [3:0] xor_ab3;
RCA_4bit x3(.a(a[11:8]), .b(b[11:8]), .cin(q7), .cout(m1), .sum(s[11:8]));
genvar k;
generate
    for (k = 0; k < 4; k = k + 1) begin : xor_gen3
        assign xor_ab3[k] = a[8+k] ^ b[8+k];
    end
endgenerate
assign m6 = &xor_ab3; 
inverter_cmos hyb_mux3(.control(m6),.in1(m1) ,.in2(q7),.out(m7));
    
   wire n1, n6;
wire [3:0] xor_ab4;
RCA_4bit x4(.a(a[15:12]), .b(b[15:12]), .cin(m7), .cout(n1), .sum(s[15:12]));
genvar l;
generate
    for (l = 0; l < 4; l = l + 1) begin : xor_gen4
        assign xor_ab4[l] = a[12+l] ^ b[12+l];
    end
endgenerate
assign n6 = &xor_ab4; 
inverter_cmos hyb_mux4(.control(n6),.in1(n1) ,.in2(m7),.out(s[16]));
    
endmodule


 module RCA_4bit(
    input [3:0] a, b, input cin,output cout,output [3:0] sum);
    wire [3:0] carry;     

    genvar i;  
 generate
        for (i = 0; i < 4; i = i + 1) begin: adder_block
            if (i == 0)
               FA_1bit ff ( .a(a[i]),.b(b[i]),.c(cin),.carry(carry[i]),.s(sum[i]));
           
            else if (i == 3) 
                FA_1bit ff (.a(a[i]),.b(b[i]),.c(carry[i-1]),.carry(cout),.s(sum[i]));
            else 
                 FA_1bit ff (.a(a[i]),.b(b[i]),.c(carry[i-1]),.carry(carry[i]),.s(sum[i]));
             end
    endgenerate
endmodule




module FA_1bit(
    input a, b, c,output carry, s );
    assign s = a ^ b ^ c;  
    assign carry = (a & b) | (b & c) | (c & a);  
endmodule


module inverter_cmos (input  control,in1 , in2, output  out);  
wire t1,y;
 pmos p1 (y,in1,control);  
 nmos n2 (y, in2,control); 
 assign t1=~y;
 assign out =~t1;
  
endmodule
