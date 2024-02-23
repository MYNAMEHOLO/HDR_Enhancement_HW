module NN #(
parameter NN_IN_BIT     = `NN_IN_BIT ,
parameter NN_IN_CLASS_BIT = `NN_IN_CLASS_BIT,
parameter NN_OUT_BIT    = `NN_OUT_BIT,
parameter NN_BIAS_BIT   = `NN_BIAS_BIT,
parameter NN_KERNEL_BIT = `NN_KERNEL_BIT
)
(
input clk,
input rst_n,
input [2:0] class_i,

// Red Part
input [NN_IN_BIT -1 : 0] NN_R1_i,
input [NN_IN_BIT -1 : 0] NN_R2_i,
input [NN_IN_BIT -1 : 0] NN_R3_i,
input [NN_IN_BIT -1 : 0] NN_R4_i,
input [NN_IN_BIT -1 : 0] NN_R5_i,
input [NN_IN_BIT -1 : 0] NN_R6_i,
input [NN_IN_BIT -1 : 0] NN_R7_i,
input [NN_IN_BIT -1 : 0] NN_R8_i,
input [NN_IN_BIT -1 : 0] NN_R9_i,

// Green Part
input [NN_IN_BIT -1 : 0] NN_G1_i,
input [NN_IN_BIT -1 : 0] NN_G2_i,
input [NN_IN_BIT -1 : 0] NN_G3_i,
input [NN_IN_BIT -1 : 0] NN_G4_i,
input [NN_IN_BIT -1 : 0] NN_G5_i,
input [NN_IN_BIT -1 : 0] NN_G6_i,
input [NN_IN_BIT -1 : 0] NN_G7_i,
input [NN_IN_BIT -1 : 0] NN_G8_i,
input [NN_IN_BIT -1 : 0] NN_G9_i,

// Blue Part
input [NN_IN_BIT -1 : 0] NN_B1_i,
input [NN_IN_BIT -1 : 0] NN_B2_i,
input [NN_IN_BIT -1 : 0] NN_B3_i,
input [NN_IN_BIT -1 : 0] NN_B4_i,
input [NN_IN_BIT -1 : 0] NN_B5_i,
input [NN_IN_BIT -1 : 0] NN_B6_i,
input [NN_IN_BIT -1 : 0] NN_B7_i,
input [NN_IN_BIT -1 : 0] NN_B8_i,
input [NN_IN_BIT -1 : 0] NN_B9_i,

// Output part
output reg [NN_OUT_BIT - 1 : 0] NN_onepxl_R_o,
output reg [NN_OUT_BIT - 1 : 0] NN_onepxl_G_o,
output reg [NN_OUT_BIT - 1 : 0] NN_onepxl_B_o


);
// parameter for Class
parameter [2:0] CLASS_0 = 3'b000;
parameter [2:0] CLASS_1 = 3'b001;
parameter [2:0] CLASS_2 = 3'b010;
parameter [2:0] CLASS_3 = 3'b011;
parameter [2:0] CLASS_4 = 3'b100;



/// Parameter for Class 0 ///
// bias = 1bit signed bit + 16bit flaoting (2's complement)
parameter signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_up_R   = 'b11111111111111010;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_up_G   = 'b11111101110010001;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_up_B   = 'b11111001011001000;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_down_R = 'b11101110001010111;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_down_G = 'b11001100110101110;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_down_B = 'b11000101001000001;

// Kernel = 1bit signed bit + 3bit integer + 16bit floating (2's complement)
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R1 =   'b11111011001000110011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R2 =   'b11111000100011000010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R3 =   'b11111001011010100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R4 =   'b11111011111111100000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R5 =   'b11111001011110010001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R6 =   'b11111011010111011101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R7 =   'b11111011011101100111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R8 =   'b11110111111000001001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_R9 =   'b11111010000011010011;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G1 =   'b11110111011111101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G2 =   'b11110011111001000001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G3 =   'b11110101101111110100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G4 =   'b11111000010000101010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G5 =   'b11110001001011100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G6 =   'b11110011111110010011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G7 =   'b11110110000011101100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G8 =   'b11110011000101000101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_G9 =   'b11110101101011101110;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B1 =   'b11111011001111000111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B2 =   'b11111101000111011010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B3 =   'b11110110110101010110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B4 =   'b11101010011100101111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B5 =   'b11110001011101101110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B6 =   'b11101010110111000110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B7 =   'b11111110111001101010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B8 =   'b11111111000010000101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_uproad_B9 =   'b11110000001100010011;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R1 = 'b11111001011010111101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R2 = 'b11111010011100111101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R3 = 'b11111101000100100010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R4 = 'b11110101110101100000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R5 = 'b11110101001000110111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R6 = 'b11110010011000110001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R7 = 'b11110101110001111111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R8 = 'b11110100101001011100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_R9 = 'b11110011101001001010;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G1 = 'b11110011011111110000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G2 = 'b11110011001010011010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G3 = 'b11110001101111001111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G4 = 'b11101011111101011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G5 = 'b11110001011011001111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G6 = 'b11101101000010010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G7 = 'b11101000111010111101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G8 = 'b11100101000111101000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_G9 = 'b11100110101111000111;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B1 = 'b11100101111101011010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B2 = 'b11011110010100100000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B3 = 'b11101010000111111101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B4 = 'b11100000101101011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B5 = 'b11100100010111011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B6 = 'b11111011000011000111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B7 = 'b11100100101100001100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B8 = 'b11100010100000010101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C0_Big_Kernel_downroad_B9 = 'b11101000101011010000;

/////////////////////////////

/// Parameter for Class 1 ///
// bias = 1bit signed bit + 16bit flaoting (2's complement)
parameter signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_up_R   = 'b00000001011111000;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_up_G   = 'b00000001010011110;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_up_B   = 'b00000001001110100;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_down_R = 'b11110110111010010;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_down_G = 'b00000000000000011;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_down_B = 'b11110100000111010;

// Kernel = 1bit signed bit + 3bit integer + 16bit floating (2's complement)
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R1 =   'b00000000100000111100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R2 =   'b11111111101000001100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R3 =   'b00000000000100111100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R4 =   'b11111100101100010000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R5 =   'b11111110000111100001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R6 =   'b00000010010011100011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R7 =   'b00000001000110001001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R8 =   'b11111111010111101110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_R9 =   'b11111111111001111100;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G1 =   'b00000000100011011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G2 =   'b11111110110100011110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G3 =   'b00000000101000101010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G4 =   'b00000001101101011001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G5 =   'b11111010111001011111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G6 =   'b00000001101111111100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G7 =   'b00000000100001110111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G8 =   'b11111111000001110010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_G9 =   'b00000000011100101001;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B1 =   'b00000000010101001001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B2 =   'b11111111000101111000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B3 =   'b00000000101100000100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B4 =   'b00000001100000101100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B5 =   'b11111101110010011101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B6 =   'b11111110111100011010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B7 =   'b00000000011000100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B8 =   'b11111110111111011010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_uproad_B9 =   'b00000000110100001001;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R1 = 'b11111110100100000101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R2 = 'b11111011101101011001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R3 = 'b11111110111000010000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R4 = 'b11111110100000101101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R5 = 'b11111010010111011000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R6 = 'b11111111110101110001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R7 = 'b11111110010010100000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R8 = 'b11111010111101100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_R9 = 'b11111101100011010111;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G1 = 'b11111101101111010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G2 = 'b00000011010101001111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G3 = 'b11111101101111110001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G4 = 'b11111100111011110111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G5 = 'b11111010101101111010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G6 = 'b00000001010000111101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G7 = 'b11111111010100111000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G8 = 'b00000010000010111000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_G9 = 'b00000000011010000011;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B1 = 'b11111110011100011110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B2 = 'b00000000000000000101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B3 = 'b11111001010011001000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B4 = 'b11111100000010110011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B5 = 'b11111111010011010011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B6 = 'b11111011101110110100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B7 = 'b11111100010011110010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B8 = 'b11111111001110100001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C1_Big_Kernel_downroad_B9 = 'b11111110101011101110;

//////////////////////////////////////
/// Parameter for Class 2 ///
// bias = 1bit signed bit + 16bit flaoting (2's complement)
parameter signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_up_R   = 'b11111010101011001;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_up_G   = 'b11110111100001101;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_up_B   = 'b11111001100000101;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_down_R = 'b11111010111011011;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_down_G = 'b11111001100111011;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_down_B = 'b11110111001000110;

// Kernel = 1bit signed bit + 3bit integer + 16bit floating (2's complement)
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R1 =   'b11111101101100100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R2 =   'b11111110000011101000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R3 =   'b00000001100001100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R4 =   'b00000000010000010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R5 =   'b00000000100001011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R6 =   'b11111001110001011100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R7 =   'b11111101100110100010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R8 =   'b11111111110000101100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_R9 =   'b11111110111110000001;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G1 =   'b11111100000101010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G2 =   'b11111111101011011100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G3 =   'b11111101101010111010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G4 =   'b11111101000011001100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G5 =   'b11111111111000011101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G6 =   'b11111110011010111011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G7 =   'b11111011101000100111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G8 =   'b11111111101011101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_G9 =   'b11111100000000100010;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B1 =   'b11111111110001000000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B2 =   'b11111010000111010010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B3 =   'b11111100111110100001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B4 =   'b11111100100010110100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B5 =   'b11111011101110101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B6 =   'b11111111001111101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B7 =   'b11111011100100111010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B8 =   'b11111011000001101101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_uproad_B9 =   'b11111110100111010100;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R1 = 'b11111111101110100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R2 = 'b00000000110011100010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R3 = 'b11111000101000110000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R4 = 'b11111011101101111110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R5 = 'b00000001101100011110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R6 = 'b11111100101001110100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R7 = 'b11111101110111101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R8 = 'b11111101111010100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_R9 = 'b00000110000000000010;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G1 = 'b11111110100111000000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G2 = 'b11111011010111111100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G3 = 'b11111100110110000100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G4 = 'b11111101000000000011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G5 = 'b11111110100101011001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G6 = 'b00000001001111010010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G7 = 'b11111100110011010001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G8 = 'b11111101100111110001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_G9 = 'b11111011111111010011;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B1 = 'b11111100111101010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B2 = 'b11111110110101001001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B3 = 'b11111101101000000100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B4 = 'b11111010111001100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B5 = 'b11111111100100011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B6 = 'b11111111011000000001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B7 = 'b11111011010111110001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B8 = 'b00000010101011001001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C2_Big_Kernel_downroad_B9 = 'b11111111000000110101;

//////////////////////////////////////////
/// Parameter for Class 3 ///
// bias = 1bit signed bit + 16bit flaoting (2's complement)
parameter signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_up_R   = 'b11111010101011001;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_up_G   = 'b11110111100001101;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_up_B   = 'b11111001100000101;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_down_R = 'b11111010111011011;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_down_G = 'b11111001100111011;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_down_B = 'b11110111001000110;

// Kernel = 1bit signed bit + 3bit integer + 16bit floating (2's complement)
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R1 =   'b11111101101100100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R2 =   'b11111110000011101000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R3 =   'b00000001100001100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R4 =   'b00000000010000010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R5 =   'b00000000100001011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R6 =   'b11111001110001011100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R7 =   'b11111101100110100010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R8 =   'b11111111110000101100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_R9 =   'b11111110111110000001;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G1 =   'b11111100000101010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G2 =   'b11111111101011011100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G3 =   'b11111101101010111010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G4 =   'b11111101000011001100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G5 =   'b11111111111000011101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G6 =   'b11111110011010111011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G7 =   'b11111011101000100111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G8 =   'b11111111101011101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_G9 =   'b11111100000000100010;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B1 =   'b11111111110001000000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B2 =   'b11111010000111010010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B3 =   'b11111100111110100001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B4 =   'b11111100100010110100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B5 =   'b11111011101110101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B6 =   'b11111111001111101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B7 =   'b11111011100100111010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B8 =   'b11111011000001101101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_uproad_B9 =   'b11111110100111010100;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R1 = 'b11111111101110100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R2 = 'b00000000110011100010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R3 = 'b11111000101000110000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R4 = 'b11111011101101111110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R5 = 'b00000001101100011110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R6 = 'b11111100101001110100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R7 = 'b11111101110111101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R8 = 'b11111101111010100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_R9 = 'b00000110000000000010;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G1 = 'b11111110100111000000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G2 = 'b11111011010111111100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G3 = 'b11111100110110000100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G4 = 'b11111101000000000011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G5 = 'b11111110100101011001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G6 = 'b00000001001111010010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G7 = 'b11111100110011010001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G8 = 'b11111101100111110001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_G9 = 'b11111011111111010011;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B1 = 'b11111100111101010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B2 = 'b11111110110101001001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B3 = 'b11111101101000000100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B4 = 'b11111010111001100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B5 = 'b11111111100100011011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B6 = 'b11111111011000000001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B7 = 'b11111011010111110001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B8 = 'b00000010101011001001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C3_Big_Kernel_downroad_B9 = 'b11111111000000110101;

////////////////////////////////////////
/// Parameter for Class 4 ///
// bias = 1bit signed bit + 16bit flaoting (2's complement)
parameter signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_up_R   = 'b11111000011110100;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_up_G   = 'b00000001101100011;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_up_B   = 'b11110111000111110;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_down_R = 'b11111010110111001;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_down_G = 'b11111100111100001;
parameter signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_down_B = 'b11111001011101000;

// Kernel = 1bit signed bit + 3bit integer + 16bit floating (2's complement)
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R1 =   'b11111110001000101010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R2 =   'b11111110110100101011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R3 =   'b11111110100011011010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R4 =   'b00000000110101100011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R5 =   'b11111110001110111011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R6 =   'b11111101011100100000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R7 =   'b11111111010111011001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R8 =   'b11111011010101101110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_R9 =   'b11111101101010010000;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G1 =   'b11111111111001100011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G2 =   'b11111110101011001110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G3 =   'b00000000110011010100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G4 =   'b00000000110000100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G5 =   'b11111011001010100011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G6 =   'b00000001010100001000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G7 =   'b11111110111010100110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G8 =   'b11111111110101110011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_G9 =   'b00000000111111000010;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B1 =   'b11111110001001010010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B2 =   'b11111011100000010000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B3 =   'b11110111111011100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B4 =   'b00000001011011111111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B5 =   'b11111110001111001011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B6 =   'b11111100001000110101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B7 =   'b11111100010100001101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B8 =   'b00000000011000000011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_uproad_B9 =   'b11111101000111011001;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R1 = 'b11111100001100100010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R2 = 'b11111100010010110000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R3 = 'b00000011101011101100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R4 = 'b11111101000001111110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R5 = 'b11111101110101001000;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R6 = 'b11111110101110000101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R7 = 'b11111001011100000101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R8 = 'b11111111010100010010;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_R9 = 'b11111110110011010000;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G1 = 'b11111110100010101001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G2 = 'b11111101110001001100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G3 = 'b11111100111111010001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G4 = 'b11111100111000111001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G5 = 'b11111001110110100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G6 = 'b00000001001011100101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G7 = 'b11111100010001000001;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G8 = 'b11111111101000101110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_G9 = 'b11111101111111111100;

parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B1 = 'b11111111010010100011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B2 = 'b11111100011000111110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B3 = 'b11111101101010100111;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B4 = 'b11111110011110111110;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B5 = 'b11111111100110010101;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B6 = 'b11111100000010100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B7 = 'b11111101011011100100;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B8 = 'b11111010000010001011;
parameter signed [NN_KERNEL_BIT - 1 :0 ] C4_Big_Kernel_downroad_B9 = 'b11111110100000011011;

// comb part


///==================================================//
// Bias Part (check)
//===================================================//

// C0
wire signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_uproad_R  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_uproad_G  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_uproad_B  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_downroad_R; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_downroad_G; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C0_biases_downroad_B; 

assign C0_biases_uproad_R   = C0_biases_up_R   ;
assign C0_biases_uproad_G   = C0_biases_up_G   ;
assign C0_biases_uproad_B   = C0_biases_up_B   ;
assign C0_biases_downroad_R = C0_biases_down_R ;
assign C0_biases_downroad_G = C0_biases_down_G ;
assign C0_biases_downroad_B = C0_biases_down_B ;

// C1
wire signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_uproad_R  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_uproad_G  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_uproad_B  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_downroad_R; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_downroad_G; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C1_biases_downroad_B; 

assign C1_biases_uproad_R   = C1_biases_up_R   ;
assign C1_biases_uproad_G   = C1_biases_up_G   ;
assign C1_biases_uproad_B   = C1_biases_up_B   ;
assign C1_biases_downroad_R = C1_biases_down_R ;
assign C1_biases_downroad_G = C1_biases_down_G ;
assign C1_biases_downroad_B = C1_biases_down_B ;

//C2
wire signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_uproad_R  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_uproad_G  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_uproad_B  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_downroad_R; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_downroad_G; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C2_biases_downroad_B; 

assign C2_biases_uproad_R   = C2_biases_up_R   ;
assign C2_biases_uproad_G   = C2_biases_up_G   ;
assign C2_biases_uproad_B   = C2_biases_up_B   ;
assign C2_biases_downroad_R = C2_biases_down_R ;
assign C2_biases_downroad_G = C2_biases_down_G ;
assign C2_biases_downroad_B = C2_biases_down_B ;
//C3
wire signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_uproad_R  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_uproad_G  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_uproad_B  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_downroad_R; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_downroad_G; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C3_biases_downroad_B; 

assign C3_biases_uproad_R   = C3_biases_up_R  ;
assign C3_biases_uproad_G   = C3_biases_up_G  ;
assign C3_biases_uproad_B   = C3_biases_up_B  ;
assign C3_biases_downroad_R = C3_biases_down_R;
assign C3_biases_downroad_G = C3_biases_down_G;
assign C3_biases_downroad_B = C3_biases_down_B;
//C4
wire signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_uproad_R  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_uproad_G  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_uproad_B  ; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_downroad_R; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_downroad_G; 
wire signed [NN_BIAS_BIT - 1 : 0 ] C4_biases_downroad_B; 

assign C4_biases_uproad_R   = C4_biases_up_R   ;
assign C4_biases_uproad_G   = C4_biases_up_G   ;
assign C4_biases_uproad_B   = C4_biases_up_B   ;
assign C4_biases_downroad_R = C4_biases_down_R ;
assign C4_biases_downroad_G = C4_biases_down_G ;
assign C4_biases_downroad_B = C4_biases_down_B ;

///==================================================//
/// Mult R PART (check)
///==================================================//
// define uproad_R

//C0
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_R9; 

assign C0_mult_uproad_R1 = C0_Big_Kernel_uproad_R1;
assign C0_mult_uproad_R2 = C0_Big_Kernel_uproad_R2;
assign C0_mult_uproad_R3 = C0_Big_Kernel_uproad_R3;
assign C0_mult_uproad_R4 = C0_Big_Kernel_uproad_R4;
assign C0_mult_uproad_R5 = C0_Big_Kernel_uproad_R5;
assign C0_mult_uproad_R6 = C0_Big_Kernel_uproad_R6;
assign C0_mult_uproad_R7 = C0_Big_Kernel_uproad_R7;
assign C0_mult_uproad_R8 = C0_Big_Kernel_uproad_R8;
assign C0_mult_uproad_R9 = C0_Big_Kernel_uproad_R9;

//C1
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_R9; 

assign C1_mult_uproad_R1 = C1_Big_Kernel_uproad_R1;
assign C1_mult_uproad_R2 = C1_Big_Kernel_uproad_R2;
assign C1_mult_uproad_R3 = C1_Big_Kernel_uproad_R3;
assign C1_mult_uproad_R4 = C1_Big_Kernel_uproad_R4;
assign C1_mult_uproad_R5 = C1_Big_Kernel_uproad_R5;
assign C1_mult_uproad_R6 = C1_Big_Kernel_uproad_R6;
assign C1_mult_uproad_R7 = C1_Big_Kernel_uproad_R7;
assign C1_mult_uproad_R8 = C1_Big_Kernel_uproad_R8;
assign C1_mult_uproad_R9 = C1_Big_Kernel_uproad_R9;

//C2
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_R9; 

assign C2_mult_uproad_R1 = C2_Big_Kernel_uproad_R1;
assign C2_mult_uproad_R2 = C2_Big_Kernel_uproad_R2;
assign C2_mult_uproad_R3 = C2_Big_Kernel_uproad_R3;
assign C2_mult_uproad_R4 = C2_Big_Kernel_uproad_R4;
assign C2_mult_uproad_R5 = C2_Big_Kernel_uproad_R5;
assign C2_mult_uproad_R6 = C2_Big_Kernel_uproad_R6;
assign C2_mult_uproad_R7 = C2_Big_Kernel_uproad_R7;
assign C2_mult_uproad_R8 = C2_Big_Kernel_uproad_R8;
assign C2_mult_uproad_R9 = C2_Big_Kernel_uproad_R9;

//C3
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_R9; 

assign C3_mult_uproad_R1 = C3_Big_Kernel_uproad_R1;
assign C3_mult_uproad_R2 = C3_Big_Kernel_uproad_R2;
assign C3_mult_uproad_R3 = C3_Big_Kernel_uproad_R3;
assign C3_mult_uproad_R4 = C3_Big_Kernel_uproad_R4;
assign C3_mult_uproad_R5 = C3_Big_Kernel_uproad_R5;
assign C3_mult_uproad_R6 = C3_Big_Kernel_uproad_R6;
assign C3_mult_uproad_R7 = C3_Big_Kernel_uproad_R7;
assign C3_mult_uproad_R8 = C3_Big_Kernel_uproad_R8;
assign C3_mult_uproad_R9 = C3_Big_Kernel_uproad_R9;

//C4
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_R9; 

assign C4_mult_uproad_R1 = C4_Big_Kernel_uproad_R1;
assign C4_mult_uproad_R2 = C4_Big_Kernel_uproad_R2;
assign C4_mult_uproad_R3 = C4_Big_Kernel_uproad_R3;
assign C4_mult_uproad_R4 = C4_Big_Kernel_uproad_R4;
assign C4_mult_uproad_R5 = C4_Big_Kernel_uproad_R5;
assign C4_mult_uproad_R6 = C4_Big_Kernel_uproad_R6;
assign C4_mult_uproad_R7 = C4_Big_Kernel_uproad_R7;
assign C4_mult_uproad_R8 = C4_Big_Kernel_uproad_R8;
assign C4_mult_uproad_R9 = C4_Big_Kernel_uproad_R9;

// downroad R
//C0
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_R9; 

assign C0_mult_downroad_R1 = C0_Big_Kernel_downroad_R1;
assign C0_mult_downroad_R2 = C0_Big_Kernel_downroad_R2;
assign C0_mult_downroad_R3 = C0_Big_Kernel_downroad_R3;
assign C0_mult_downroad_R4 = C0_Big_Kernel_downroad_R4;
assign C0_mult_downroad_R5 = C0_Big_Kernel_downroad_R5;
assign C0_mult_downroad_R6 = C0_Big_Kernel_downroad_R6;
assign C0_mult_downroad_R7 = C0_Big_Kernel_downroad_R7;
assign C0_mult_downroad_R8 = C0_Big_Kernel_downroad_R8;
assign C0_mult_downroad_R9 = C0_Big_Kernel_downroad_R9;

//C1
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_R9; 

assign C1_mult_downroad_R1 = C1_Big_Kernel_downroad_R1;
assign C1_mult_downroad_R2 = C1_Big_Kernel_downroad_R2;
assign C1_mult_downroad_R3 = C1_Big_Kernel_downroad_R3;
assign C1_mult_downroad_R4 = C1_Big_Kernel_downroad_R4;
assign C1_mult_downroad_R5 = C1_Big_Kernel_downroad_R5;
assign C1_mult_downroad_R6 = C1_Big_Kernel_downroad_R6;
assign C1_mult_downroad_R7 = C1_Big_Kernel_downroad_R7;
assign C1_mult_downroad_R8 = C1_Big_Kernel_downroad_R8;
assign C1_mult_downroad_R9 = C1_Big_Kernel_downroad_R9;

//C2
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_R9; 

assign C2_mult_downroad_R1 = C2_Big_Kernel_downroad_R1;
assign C2_mult_downroad_R2 = C2_Big_Kernel_downroad_R2;
assign C2_mult_downroad_R3 = C2_Big_Kernel_downroad_R3;
assign C2_mult_downroad_R4 = C2_Big_Kernel_downroad_R4;
assign C2_mult_downroad_R5 = C2_Big_Kernel_downroad_R5;
assign C2_mult_downroad_R6 = C2_Big_Kernel_downroad_R6;
assign C2_mult_downroad_R7 = C2_Big_Kernel_downroad_R7;
assign C2_mult_downroad_R8 = C2_Big_Kernel_downroad_R8;
assign C2_mult_downroad_R9 = C2_Big_Kernel_downroad_R9;

//C3
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_R9; 

assign C3_mult_downroad_R1 = C3_Big_Kernel_downroad_R1;
assign C3_mult_downroad_R2 = C3_Big_Kernel_downroad_R2;
assign C3_mult_downroad_R3 = C3_Big_Kernel_downroad_R3;
assign C3_mult_downroad_R4 = C3_Big_Kernel_downroad_R4;
assign C3_mult_downroad_R5 = C3_Big_Kernel_downroad_R5;
assign C3_mult_downroad_R6 = C3_Big_Kernel_downroad_R6;
assign C3_mult_downroad_R7 = C3_Big_Kernel_downroad_R7;
assign C3_mult_downroad_R8 = C3_Big_Kernel_downroad_R8;
assign C3_mult_downroad_R9 = C3_Big_Kernel_downroad_R9;

//C4
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_R9; 

assign C4_mult_downroad_R1 = C4_Big_Kernel_downroad_R1;
assign C4_mult_downroad_R2 = C4_Big_Kernel_downroad_R2;
assign C4_mult_downroad_R3 = C4_Big_Kernel_downroad_R3;
assign C4_mult_downroad_R4 = C4_Big_Kernel_downroad_R4;
assign C4_mult_downroad_R5 = C4_Big_Kernel_downroad_R5;
assign C4_mult_downroad_R6 = C4_Big_Kernel_downroad_R6;
assign C4_mult_downroad_R7 = C4_Big_Kernel_downroad_R7;
assign C4_mult_downroad_R8 = C4_Big_Kernel_downroad_R8;
assign C4_mult_downroad_R9 = C4_Big_Kernel_downroad_R9;

///==================================================//
/// MULT G PART (check)
///==================================================//

// Uproad
// C0
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_G9; 

assign C0_mult_uproad_G1 = C0_Big_Kernel_uproad_G1;
assign C0_mult_uproad_G2 = C0_Big_Kernel_uproad_G2;
assign C0_mult_uproad_G3 = C0_Big_Kernel_uproad_G3;
assign C0_mult_uproad_G4 = C0_Big_Kernel_uproad_G4;
assign C0_mult_uproad_G5 = C0_Big_Kernel_uproad_G5;
assign C0_mult_uproad_G6 = C0_Big_Kernel_uproad_G6;
assign C0_mult_uproad_G7 = C0_Big_Kernel_uproad_G7;
assign C0_mult_uproad_G8 = C0_Big_Kernel_uproad_G8;
assign C0_mult_uproad_G9 = C0_Big_Kernel_uproad_G9;

// C1
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_G9; 

assign C1_mult_uproad_G1 = C1_Big_Kernel_uproad_G1;
assign C1_mult_uproad_G2 = C1_Big_Kernel_uproad_G2;
assign C1_mult_uproad_G3 = C1_Big_Kernel_uproad_G3;
assign C1_mult_uproad_G4 = C1_Big_Kernel_uproad_G4;
assign C1_mult_uproad_G5 = C1_Big_Kernel_uproad_G5;
assign C1_mult_uproad_G6 = C1_Big_Kernel_uproad_G6;
assign C1_mult_uproad_G7 = C1_Big_Kernel_uproad_G7;
assign C1_mult_uproad_G8 = C1_Big_Kernel_uproad_G8;
assign C1_mult_uproad_G9 = C1_Big_Kernel_uproad_G9;

//C2
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_G9; 

assign C2_mult_uproad_G1 = C2_Big_Kernel_uproad_G1;
assign C2_mult_uproad_G2 = C2_Big_Kernel_uproad_G2;
assign C2_mult_uproad_G3 = C2_Big_Kernel_uproad_G3;
assign C2_mult_uproad_G4 = C2_Big_Kernel_uproad_G4;
assign C2_mult_uproad_G5 = C2_Big_Kernel_uproad_G5;
assign C2_mult_uproad_G6 = C2_Big_Kernel_uproad_G6;
assign C2_mult_uproad_G7 = C2_Big_Kernel_uproad_G7;
assign C2_mult_uproad_G8 = C2_Big_Kernel_uproad_G8;
assign C2_mult_uproad_G9 = C2_Big_Kernel_uproad_G9;

//C3
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_G9; 

assign C3_mult_uproad_G1 = C3_Big_Kernel_uproad_G1;
assign C3_mult_uproad_G2 = C3_Big_Kernel_uproad_G2;
assign C3_mult_uproad_G3 = C3_Big_Kernel_uproad_G3;
assign C3_mult_uproad_G4 = C3_Big_Kernel_uproad_G4;
assign C3_mult_uproad_G5 = C3_Big_Kernel_uproad_G5;
assign C3_mult_uproad_G6 = C3_Big_Kernel_uproad_G6;
assign C3_mult_uproad_G7 = C3_Big_Kernel_uproad_G7;
assign C3_mult_uproad_G8 = C3_Big_Kernel_uproad_G8;
assign C3_mult_uproad_G9 = C3_Big_Kernel_uproad_G9;

//C4
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_G9; 

assign C4_mult_uproad_G1 = C4_Big_Kernel_uproad_G1;
assign C4_mult_uproad_G2 = C4_Big_Kernel_uproad_G2;
assign C4_mult_uproad_G3 = C4_Big_Kernel_uproad_G3;
assign C4_mult_uproad_G4 = C4_Big_Kernel_uproad_G4;
assign C4_mult_uproad_G5 = C4_Big_Kernel_uproad_G5;
assign C4_mult_uproad_G6 = C4_Big_Kernel_uproad_G6;
assign C4_mult_uproad_G7 = C4_Big_Kernel_uproad_G7;
assign C4_mult_uproad_G8 = C4_Big_Kernel_uproad_G8;
assign C4_mult_uproad_G9 = C4_Big_Kernel_uproad_G9;

// downroad
//C0
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_G9; 

assign C0_mult_downroad_G1 = C0_Big_Kernel_downroad_G1;
assign C0_mult_downroad_G2 = C0_Big_Kernel_downroad_G2;
assign C0_mult_downroad_G3 = C0_Big_Kernel_downroad_G3;
assign C0_mult_downroad_G4 = C0_Big_Kernel_downroad_G4;
assign C0_mult_downroad_G5 = C0_Big_Kernel_downroad_G5;
assign C0_mult_downroad_G6 = C0_Big_Kernel_downroad_G6;
assign C0_mult_downroad_G7 = C0_Big_Kernel_downroad_G7;
assign C0_mult_downroad_G8 = C0_Big_Kernel_downroad_G8;
assign C0_mult_downroad_G9 = C0_Big_Kernel_downroad_G9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_G9; 

assign C1_mult_downroad_G1 = C1_Big_Kernel_downroad_G1;
assign C1_mult_downroad_G2 = C1_Big_Kernel_downroad_G2;
assign C1_mult_downroad_G3 = C1_Big_Kernel_downroad_G3;
assign C1_mult_downroad_G4 = C1_Big_Kernel_downroad_G4;
assign C1_mult_downroad_G5 = C1_Big_Kernel_downroad_G5;
assign C1_mult_downroad_G6 = C1_Big_Kernel_downroad_G6;
assign C1_mult_downroad_G7 = C1_Big_Kernel_downroad_G7;
assign C1_mult_downroad_G8 = C1_Big_Kernel_downroad_G8;
assign C1_mult_downroad_G9 = C1_Big_Kernel_downroad_G9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_G9; 

assign C2_mult_downroad_G1 = C2_Big_Kernel_downroad_G1;
assign C2_mult_downroad_G2 = C2_Big_Kernel_downroad_G2;
assign C2_mult_downroad_G3 = C2_Big_Kernel_downroad_G3;
assign C2_mult_downroad_G4 = C2_Big_Kernel_downroad_G4;
assign C2_mult_downroad_G5 = C2_Big_Kernel_downroad_G5;
assign C2_mult_downroad_G6 = C2_Big_Kernel_downroad_G6;
assign C2_mult_downroad_G7 = C2_Big_Kernel_downroad_G7;
assign C2_mult_downroad_G8 = C2_Big_Kernel_downroad_G8;
assign C2_mult_downroad_G9 = C2_Big_Kernel_downroad_G9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_G9; 

assign C3_mult_downroad_G1 = C3_Big_Kernel_downroad_G1;
assign C3_mult_downroad_G2 = C3_Big_Kernel_downroad_G2;
assign C3_mult_downroad_G3 = C3_Big_Kernel_downroad_G3;
assign C3_mult_downroad_G4 = C3_Big_Kernel_downroad_G4;
assign C3_mult_downroad_G5 = C3_Big_Kernel_downroad_G5;
assign C3_mult_downroad_G6 = C3_Big_Kernel_downroad_G6;
assign C3_mult_downroad_G7 = C3_Big_Kernel_downroad_G7;
assign C3_mult_downroad_G8 = C3_Big_Kernel_downroad_G8;
assign C3_mult_downroad_G9 = C3_Big_Kernel_downroad_G9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_G9; 

assign C4_mult_downroad_G1 = C4_Big_Kernel_downroad_G1;
assign C4_mult_downroad_G2 = C4_Big_Kernel_downroad_G2;
assign C4_mult_downroad_G3 = C4_Big_Kernel_downroad_G3;
assign C4_mult_downroad_G4 = C4_Big_Kernel_downroad_G4;
assign C4_mult_downroad_G5 = C4_Big_Kernel_downroad_G5;
assign C4_mult_downroad_G6 = C4_Big_Kernel_downroad_G6;
assign C4_mult_downroad_G7 = C4_Big_Kernel_downroad_G7;
assign C4_mult_downroad_G8 = C4_Big_Kernel_downroad_G8;
assign C4_mult_downroad_G9 = C4_Big_Kernel_downroad_G9;

///=========================================///
// MULT B PART (check) //
///=========================================///

// uproad
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_uproad_B9; 

assign C0_mult_uproad_B1 = C0_Big_Kernel_uproad_B1;
assign C0_mult_uproad_B2 = C0_Big_Kernel_uproad_B2;
assign C0_mult_uproad_B3 = C0_Big_Kernel_uproad_B3;
assign C0_mult_uproad_B4 = C0_Big_Kernel_uproad_B4;
assign C0_mult_uproad_B5 = C0_Big_Kernel_uproad_B5;
assign C0_mult_uproad_B6 = C0_Big_Kernel_uproad_B6;
assign C0_mult_uproad_B7 = C0_Big_Kernel_uproad_B7;
assign C0_mult_uproad_B8 = C0_Big_Kernel_uproad_B8;
assign C0_mult_uproad_B9 = C0_Big_Kernel_uproad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_uproad_B9; 

assign C1_mult_uproad_B1 = C1_Big_Kernel_uproad_B1;
assign C1_mult_uproad_B2 = C1_Big_Kernel_uproad_B2;
assign C1_mult_uproad_B3 = C1_Big_Kernel_uproad_B3;
assign C1_mult_uproad_B4 = C1_Big_Kernel_uproad_B4;
assign C1_mult_uproad_B5 = C1_Big_Kernel_uproad_B5;
assign C1_mult_uproad_B6 = C1_Big_Kernel_uproad_B6;
assign C1_mult_uproad_B7 = C1_Big_Kernel_uproad_B7;
assign C1_mult_uproad_B8 = C1_Big_Kernel_uproad_B8;
assign C1_mult_uproad_B9 = C1_Big_Kernel_uproad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_uproad_B9; 

assign C2_mult_uproad_B1 = C2_Big_Kernel_uproad_B1;
assign C2_mult_uproad_B2 = C2_Big_Kernel_uproad_B2;
assign C2_mult_uproad_B3 = C2_Big_Kernel_uproad_B3;
assign C2_mult_uproad_B4 = C2_Big_Kernel_uproad_B4;
assign C2_mult_uproad_B5 = C2_Big_Kernel_uproad_B5;
assign C2_mult_uproad_B6 = C2_Big_Kernel_uproad_B6;
assign C2_mult_uproad_B7 = C2_Big_Kernel_uproad_B7;
assign C2_mult_uproad_B8 = C2_Big_Kernel_uproad_B8;
assign C2_mult_uproad_B9 = C2_Big_Kernel_uproad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_uproad_B9; 

assign C3_mult_uproad_B1 = C3_Big_Kernel_uproad_B1;
assign C3_mult_uproad_B2 = C3_Big_Kernel_uproad_B2;
assign C3_mult_uproad_B3 = C3_Big_Kernel_uproad_B3;
assign C3_mult_uproad_B4 = C3_Big_Kernel_uproad_B4;
assign C3_mult_uproad_B5 = C3_Big_Kernel_uproad_B5;
assign C3_mult_uproad_B6 = C3_Big_Kernel_uproad_B6;
assign C3_mult_uproad_B7 = C3_Big_Kernel_uproad_B7;
assign C3_mult_uproad_B8 = C3_Big_Kernel_uproad_B8;
assign C3_mult_uproad_B9 = C3_Big_Kernel_uproad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_uproad_B9; 

assign C4_mult_uproad_B1 = C4_Big_Kernel_uproad_B1;
assign C4_mult_uproad_B2 = C4_Big_Kernel_uproad_B2;
assign C4_mult_uproad_B3 = C4_Big_Kernel_uproad_B3;
assign C4_mult_uproad_B4 = C4_Big_Kernel_uproad_B4;
assign C4_mult_uproad_B5 = C4_Big_Kernel_uproad_B5;
assign C4_mult_uproad_B6 = C4_Big_Kernel_uproad_B6;
assign C4_mult_uproad_B7 = C4_Big_Kernel_uproad_B7;
assign C4_mult_uproad_B8 = C4_Big_Kernel_uproad_B8;
assign C4_mult_uproad_B9 = C4_Big_Kernel_uproad_B9;

// downroad
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C0_mult_downroad_B9; 

assign C0_mult_downroad_B1 = C0_Big_Kernel_downroad_B1;
assign C0_mult_downroad_B2 = C0_Big_Kernel_downroad_B2;
assign C0_mult_downroad_B3 = C0_Big_Kernel_downroad_B3;
assign C0_mult_downroad_B4 = C0_Big_Kernel_downroad_B4;
assign C0_mult_downroad_B5 = C0_Big_Kernel_downroad_B5;
assign C0_mult_downroad_B6 = C0_Big_Kernel_downroad_B6;
assign C0_mult_downroad_B7 = C0_Big_Kernel_downroad_B7;
assign C0_mult_downroad_B8 = C0_Big_Kernel_downroad_B8;
assign C0_mult_downroad_B9 = C0_Big_Kernel_downroad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C1_mult_downroad_B9; 

assign C1_mult_downroad_B1 = C1_Big_Kernel_downroad_B1;
assign C1_mult_downroad_B2 = C1_Big_Kernel_downroad_B2;
assign C1_mult_downroad_B3 = C1_Big_Kernel_downroad_B3;
assign C1_mult_downroad_B4 = C1_Big_Kernel_downroad_B4;
assign C1_mult_downroad_B5 = C1_Big_Kernel_downroad_B5;
assign C1_mult_downroad_B6 = C1_Big_Kernel_downroad_B6;
assign C1_mult_downroad_B7 = C1_Big_Kernel_downroad_B7;
assign C1_mult_downroad_B8 = C1_Big_Kernel_downroad_B8;
assign C1_mult_downroad_B9 = C1_Big_Kernel_downroad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C2_mult_downroad_B9; 

assign C2_mult_downroad_B1 = C2_Big_Kernel_downroad_B1;
assign C2_mult_downroad_B2 = C2_Big_Kernel_downroad_B2;
assign C2_mult_downroad_B3 = C2_Big_Kernel_downroad_B3;
assign C2_mult_downroad_B4 = C2_Big_Kernel_downroad_B4;
assign C2_mult_downroad_B5 = C2_Big_Kernel_downroad_B5;
assign C2_mult_downroad_B6 = C2_Big_Kernel_downroad_B6;
assign C2_mult_downroad_B7 = C2_Big_Kernel_downroad_B7;
assign C2_mult_downroad_B8 = C2_Big_Kernel_downroad_B8;
assign C2_mult_downroad_B9 = C2_Big_Kernel_downroad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C3_mult_downroad_B9; 

assign C3_mult_downroad_B1 = C3_Big_Kernel_downroad_B1;
assign C3_mult_downroad_B2 = C3_Big_Kernel_downroad_B2;
assign C3_mult_downroad_B3 = C3_Big_Kernel_downroad_B3;
assign C3_mult_downroad_B4 = C3_Big_Kernel_downroad_B4;
assign C3_mult_downroad_B5 = C3_Big_Kernel_downroad_B5;
assign C3_mult_downroad_B6 = C3_Big_Kernel_downroad_B6;
assign C3_mult_downroad_B7 = C3_Big_Kernel_downroad_B7;
assign C3_mult_downroad_B8 = C3_Big_Kernel_downroad_B8;
assign C3_mult_downroad_B9 = C3_Big_Kernel_downroad_B9;

wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B1; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B2; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B3; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B4; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B5; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B6; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B7; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B8; 
wire signed [NN_KERNEL_BIT - 1 :0 ] C4_mult_downroad_B9; 

assign C4_mult_downroad_B1 = C4_Big_Kernel_downroad_B1;
assign C4_mult_downroad_B2 = C4_Big_Kernel_downroad_B2;
assign C4_mult_downroad_B3 = C4_Big_Kernel_downroad_B3;
assign C4_mult_downroad_B4 = C4_Big_Kernel_downroad_B4;
assign C4_mult_downroad_B5 = C4_Big_Kernel_downroad_B5;
assign C4_mult_downroad_B6 = C4_Big_Kernel_downroad_B6;
assign C4_mult_downroad_B7 = C4_Big_Kernel_downroad_B7;
assign C4_mult_downroad_B8 = C4_Big_Kernel_downroad_B8;
assign C4_mult_downroad_B9 = C4_Big_Kernel_downroad_B9;


///===================================///
// define mult for uproad (check)
///===================================///
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R1;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R2;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R3;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R4;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R5;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R6;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R7;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R8;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_R9;

reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G1;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G2;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G3;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G4;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G5;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G6;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G7;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G8;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_G9;

reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B1;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B2;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B3;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B4;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B5;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B6;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B7;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B8;
reg signed [NN_KERNEL_BIT - 1 :0] mult_uproad_B9;

///===================================///
// define mult for downroad (check)
///===================================///
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R1;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R2;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R3;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R4;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R5;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R6;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R7;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R8;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_R9;

reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G1;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G2;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G3;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G4;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G5;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G6;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G7;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G8;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_G9;

reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B1;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B2;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B3;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B4;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B5;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B6;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B7;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B8;
reg signed [NN_KERNEL_BIT - 1 :0] mult_downroad_B9;

//======================================//
// Class Pipeline insertion 
//======================================//
reg [2:0] class_i_stg1;
reg [2:0] class_i_stg2;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        class_i_stg1 <= 'd0;
        class_i_stg2 <= 'd0;
    end
    else begin
        class_i_stg1 <= class_i;
        class_i_stg2 <= class_i_stg1;
    end
end


//======================================//
// Bias choosing (check)
//======================================//

reg signed [NN_BIAS_BIT - 1 : 0] bias_uproad_R;
reg signed [NN_BIAS_BIT - 1 : 0] bias_uproad_G;
reg signed [NN_BIAS_BIT - 1 : 0] bias_uproad_B;
reg signed [NN_BIAS_BIT - 1 : 0] bias_downroad_R;
reg signed [NN_BIAS_BIT - 1 : 0] bias_downroad_G;
reg signed [NN_BIAS_BIT - 1 : 0] bias_downroad_B;

// R part 
always@(*)begin
    case(class_i_stg2)
        CLASS_0: bias_uproad_R = C0_biases_uproad_R;
        CLASS_1: bias_uproad_R = C1_biases_uproad_R;
        CLASS_2: bias_uproad_R = C2_biases_uproad_R;
        CLASS_3: bias_uproad_R = C3_biases_uproad_R;
        default: bias_uproad_R = C4_biases_uproad_R;
    endcase
end

always@(*)begin
    case(class_i_stg2)
        CLASS_0: bias_downroad_R = C0_biases_downroad_R;
        CLASS_1: bias_downroad_R = C1_biases_downroad_R;
        CLASS_2: bias_downroad_R = C2_biases_downroad_R;
        CLASS_3: bias_downroad_R = C3_biases_downroad_R;
        default: bias_downroad_R = C4_biases_downroad_R;
    endcase
end

// G part
always@(*)begin
    case(class_i_stg2)
        CLASS_0: bias_uproad_G = C0_biases_uproad_G;
        CLASS_1: bias_uproad_G = C1_biases_uproad_G;
        CLASS_2: bias_uproad_G = C2_biases_uproad_G;
        CLASS_3: bias_uproad_G = C3_biases_uproad_G;
        default: bias_uproad_G = C4_biases_uproad_G;
    endcase
end

always@(*)begin
    case(class_i_stg2)
        CLASS_0: bias_downroad_G = C0_biases_downroad_G;
        CLASS_1: bias_downroad_G = C1_biases_downroad_G;
        CLASS_2: bias_downroad_G = C2_biases_downroad_G;
        CLASS_3: bias_downroad_G = C3_biases_downroad_G;
        default: bias_downroad_G = C4_biases_downroad_G;
    endcase
end

// B part
always@(*)begin
    case(class_i_stg2)
        CLASS_0: bias_uproad_B = C0_biases_uproad_B;
        CLASS_1: bias_uproad_B = C1_biases_uproad_B;
        CLASS_2: bias_uproad_B = C2_biases_uproad_B;
        CLASS_3: bias_uproad_B = C3_biases_uproad_B;
        default: bias_uproad_B = C4_biases_uproad_B;
    endcase
end

always@(*)begin
    case(class_i_stg2)
        CLASS_0: bias_downroad_B = C0_biases_downroad_B;
        CLASS_1: bias_downroad_B = C1_biases_downroad_B;
        CLASS_2: bias_downroad_B = C2_biases_downroad_B;
        CLASS_3: bias_downroad_B = C3_biases_downroad_B;
        default: bias_downroad_B = C4_biases_downroad_B;
    endcase
end



//======================================//
// multiplicand choosing (check)
//======================================//
// R1 , G1 , B1
always@(*)begin
    case(class_i)
        CLASS_0:begin
            mult_uproad_R1   = C0_mult_uproad_R1  ;
            mult_uproad_G1   = C0_mult_uproad_G1  ;
            mult_uproad_B1   = C0_mult_uproad_B1  ;
            mult_downroad_R1 = C0_mult_downroad_R1;
            mult_downroad_G1 = C0_mult_downroad_G1;
            mult_downroad_B1 = C0_mult_downroad_B1;
        end
        CLASS_1:begin
            mult_uproad_R1   = C1_mult_uproad_R1  ;
            mult_uproad_G1   = C1_mult_uproad_G1  ;
            mult_uproad_B1   = C1_mult_uproad_B1  ;
            mult_downroad_R1 = C1_mult_downroad_R1;
            mult_downroad_G1 = C1_mult_downroad_G1;
            mult_downroad_B1 = C1_mult_downroad_B1;
        end
        CLASS_2:begin
            mult_uproad_R1   = C2_mult_uproad_R1  ;
            mult_uproad_G1   = C2_mult_uproad_G1  ;
            mult_uproad_B1   = C2_mult_uproad_B1  ;
            mult_downroad_R1 = C2_mult_downroad_R1;
            mult_downroad_G1 = C2_mult_downroad_G1;
            mult_downroad_B1 = C2_mult_downroad_B1;
        end
        CLASS_3:begin
            mult_uproad_R1   = C3_mult_uproad_R1  ;
            mult_uproad_G1   = C3_mult_uproad_G1  ;
            mult_uproad_B1   = C3_mult_uproad_B1  ;
            mult_downroad_R1 = C3_mult_downroad_R1;
            mult_downroad_G1 = C3_mult_downroad_G1;
            mult_downroad_B1 = C3_mult_downroad_B1;
        end
        default:begin
            mult_uproad_R1   = C4_mult_uproad_R1  ;
            mult_uproad_G1   = C4_mult_uproad_G1  ;
            mult_uproad_B1   = C4_mult_uproad_B1  ;
            mult_downroad_R1 = C4_mult_downroad_R1;
            mult_downroad_G1 = C4_mult_downroad_G1;
            mult_downroad_B1 = C4_mult_downroad_B1;
        end
    endcase
end

// R2, G2, B2
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R2 = C0_mult_uproad_R2;
            mult_uproad_G2 = C0_mult_uproad_G2;
            mult_uproad_B2 = C0_mult_uproad_B2;
            mult_downroad_R2 = C0_mult_downroad_R2;
            mult_downroad_G2 = C0_mult_downroad_G2;
            mult_downroad_B2 = C0_mult_downroad_B2;
        end
        CLASS_1: begin
            mult_uproad_R2 = C1_mult_uproad_R2;
            mult_uproad_G2 = C1_mult_uproad_G2;
            mult_uproad_B2 = C1_mult_uproad_B2;
            mult_downroad_R2 = C1_mult_downroad_R2;
            mult_downroad_G2 = C1_mult_downroad_G2;
            mult_downroad_B2 = C1_mult_downroad_B2;
        end
        CLASS_2: begin
            mult_uproad_R2 = C2_mult_uproad_R2;
            mult_uproad_G2 = C2_mult_uproad_G2;
            mult_uproad_B2 = C2_mult_uproad_B2;
            mult_downroad_R2 = C2_mult_downroad_R2;
            mult_downroad_G2 = C2_mult_downroad_G2;
            mult_downroad_B2 = C2_mult_downroad_B2;
        end
        CLASS_3: begin
            mult_uproad_R2 = C3_mult_uproad_R2;
            mult_uproad_G2 = C3_mult_uproad_G2;
            mult_uproad_B2 = C3_mult_uproad_B2;
            mult_downroad_R2 = C3_mult_downroad_R2;
            mult_downroad_G2 = C3_mult_downroad_G2;
            mult_downroad_B2 = C3_mult_downroad_B2;
        end
        default: begin
            mult_uproad_R2 = C4_mult_uproad_R2;
            mult_uproad_G2 = C4_mult_uproad_G2;
            mult_uproad_B2 = C4_mult_uproad_B2;
            mult_downroad_R2 = C4_mult_downroad_R2;
            mult_downroad_G2 = C4_mult_downroad_G2;
            mult_downroad_B2 = C4_mult_downroad_B2;
        end
    endcase
end

// R3, G3, B3
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R3 = C0_mult_uproad_R3;
            mult_uproad_G3 = C0_mult_uproad_G3;
            mult_uproad_B3 = C0_mult_uproad_B3;
            mult_downroad_R3 = C0_mult_downroad_R3;
            mult_downroad_G3 = C0_mult_downroad_G3;
            mult_downroad_B3 = C0_mult_downroad_B3;
        end
        CLASS_1: begin
            mult_uproad_R3 = C1_mult_uproad_R3;
            mult_uproad_G3 = C1_mult_uproad_G3;
            mult_uproad_B3 = C1_mult_uproad_B3;
            mult_downroad_R3 = C1_mult_downroad_R3;
            mult_downroad_G3 = C1_mult_downroad_G3;
            mult_downroad_B3 = C1_mult_downroad_B3;
        end
        CLASS_2: begin
            mult_uproad_R3 = C2_mult_uproad_R3;
            mult_uproad_G3 = C2_mult_uproad_G3;
            mult_uproad_B3 = C2_mult_uproad_B3;
            mult_downroad_R3 = C2_mult_downroad_R3;
            mult_downroad_G3 = C2_mult_downroad_G3;
            mult_downroad_B3 = C2_mult_downroad_B3;
        end
        CLASS_3: begin
            mult_uproad_R3 = C3_mult_uproad_R3;
            mult_uproad_G3 = C3_mult_uproad_G3;
            mult_uproad_B3 = C3_mult_uproad_B3;
            mult_downroad_R3 = C3_mult_downroad_R3;
            mult_downroad_G3 = C3_mult_downroad_G3;
            mult_downroad_B3 = C3_mult_downroad_B3;
        end
        default: begin
            mult_uproad_R3 = C4_mult_uproad_R3;
            mult_uproad_G3 = C4_mult_uproad_G3;
            mult_uproad_B3 = C4_mult_uproad_B3;
            mult_downroad_R3 = C4_mult_downroad_R3;
            mult_downroad_G3 = C4_mult_downroad_G3;
            mult_downroad_B3 = C4_mult_downroad_B3;
        end
    endcase
end

// R4, G4, B4
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R4 = C0_mult_uproad_R4;
            mult_uproad_G4 = C0_mult_uproad_G4;
            mult_uproad_B4 = C0_mult_uproad_B4;
            mult_downroad_R4 = C0_mult_downroad_R4;
            mult_downroad_G4 = C0_mult_downroad_G4;
            mult_downroad_B4 = C0_mult_downroad_B4;
        end
        CLASS_1: begin
            mult_uproad_R4 = C1_mult_uproad_R4;
            mult_uproad_G4 = C1_mult_uproad_G4;
            mult_uproad_B4 = C1_mult_uproad_B4;
            mult_downroad_R4 = C1_mult_downroad_R4;
            mult_downroad_G4 = C1_mult_downroad_G4;
            mult_downroad_B4 = C1_mult_downroad_B4;
        end
        CLASS_2: begin
            mult_uproad_R4 = C2_mult_uproad_R4;
            mult_uproad_G4 = C2_mult_uproad_G4;
            mult_uproad_B4 = C2_mult_uproad_B4;
            mult_downroad_R4 = C2_mult_downroad_R4;
            mult_downroad_G4 = C2_mult_downroad_G4;
            mult_downroad_B4 = C2_mult_downroad_B4;
        end
        CLASS_3: begin
            mult_uproad_R4 = C3_mult_uproad_R4;
            mult_uproad_G4 = C3_mult_uproad_G4;
            mult_uproad_B4 = C3_mult_uproad_B4;
            mult_downroad_R4 = C3_mult_downroad_R4;
            mult_downroad_G4 = C3_mult_downroad_G4;
            mult_downroad_B4 = C3_mult_downroad_B4;
        end
        default: begin
            mult_uproad_R4 = C4_mult_uproad_R4;
            mult_uproad_G4 = C4_mult_uproad_G4;
            mult_uproad_B4 = C4_mult_uproad_B4;
            mult_downroad_R4 = C4_mult_downroad_R4;
            mult_downroad_G4 = C4_mult_downroad_G4;
            mult_downroad_B4 = C4_mult_downroad_B4;
        end
    endcase
end

// R5, G5, B5
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R5 = C0_mult_uproad_R5;
            mult_uproad_G5 = C0_mult_uproad_G5;
            mult_uproad_B5 = C0_mult_uproad_B5;
            mult_downroad_R5 = C0_mult_downroad_R5;
            mult_downroad_G5 = C0_mult_downroad_G5;
            mult_downroad_B5 = C0_mult_downroad_B5;
        end
        CLASS_1: begin
            mult_uproad_R5 = C1_mult_uproad_R5;
            mult_uproad_G5 = C1_mult_uproad_G5;
            mult_uproad_B5 = C1_mult_uproad_B5;
            mult_downroad_R5 = C1_mult_downroad_R5;
            mult_downroad_G5 = C1_mult_downroad_G5;
            mult_downroad_B5 = C1_mult_downroad_B5;
        end
        CLASS_2: begin
            mult_uproad_R5 = C2_mult_uproad_R5;
            mult_uproad_G5 = C2_mult_uproad_G5;
            mult_uproad_B5 = C2_mult_uproad_B5;
            mult_downroad_R5 = C2_mult_downroad_R5;
            mult_downroad_G5 = C2_mult_downroad_G5;
            mult_downroad_B5 = C2_mult_downroad_B5;
        end
        CLASS_3: begin
            mult_uproad_R5 = C3_mult_uproad_R5;
            mult_uproad_G5 = C3_mult_uproad_G5;
            mult_uproad_B5 = C3_mult_uproad_B5;
            mult_downroad_R5 = C3_mult_downroad_R5;
            mult_downroad_G5 = C3_mult_downroad_G5;
            mult_downroad_B5 = C3_mult_downroad_B5;
        end
        default: begin
            mult_uproad_R5 = C4_mult_uproad_R5;
            mult_uproad_G5 = C4_mult_uproad_G5;
            mult_uproad_B5 = C4_mult_uproad_B5;
            mult_downroad_R5 = C4_mult_downroad_R5;
            mult_downroad_G5 = C4_mult_downroad_G5;
            mult_downroad_B5 = C4_mult_downroad_B5;
        end
    endcase
end

// R6, G6, B6
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R6 = C0_mult_uproad_R6;
            mult_uproad_G6 = C0_mult_uproad_G6;
            mult_uproad_B6 = C0_mult_uproad_B6;
            mult_downroad_R6 = C0_mult_downroad_R6;
            mult_downroad_G6 = C0_mult_downroad_G6;
            mult_downroad_B6 = C0_mult_downroad_B6;
        end
        CLASS_1: begin
            mult_uproad_R6 = C1_mult_uproad_R6;
            mult_uproad_G6 = C1_mult_uproad_G6;
            mult_uproad_B6 = C1_mult_uproad_B6;
            mult_downroad_R6 = C1_mult_downroad_R6;
            mult_downroad_G6 = C1_mult_downroad_G6;
            mult_downroad_B6 = C1_mult_downroad_B6;
        end
        CLASS_2: begin
            mult_uproad_R6 = C2_mult_uproad_R6;
            mult_uproad_G6 = C2_mult_uproad_G6;
            mult_uproad_B6 = C2_mult_uproad_B6;
            mult_downroad_R6 = C2_mult_downroad_R6;
            mult_downroad_G6 = C2_mult_downroad_G6;
            mult_downroad_B6 = C2_mult_downroad_B6;
        end
        CLASS_3: begin
            mult_uproad_R6 = C3_mult_uproad_R6;
            mult_uproad_G6 = C3_mult_uproad_G6;
            mult_uproad_B6 = C3_mult_uproad_B6;
            mult_downroad_R6 = C3_mult_downroad_R6;
            mult_downroad_G6 = C3_mult_downroad_G6;
            mult_downroad_B6 = C3_mult_downroad_B6;
        end
        default: begin
            mult_uproad_R6 = C4_mult_uproad_R6;
            mult_uproad_G6 = C4_mult_uproad_G6;
            mult_uproad_B6 = C4_mult_uproad_B6;
            mult_downroad_R6 = C4_mult_downroad_R6;
            mult_downroad_G6 = C4_mult_downroad_G6;
            mult_downroad_B6 = C4_mult_downroad_B6;
        end
    endcase
end

// R7, G7, B7
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R7 = C0_mult_uproad_R7;
            mult_uproad_G7 = C0_mult_uproad_G7;
            mult_uproad_B7 = C0_mult_uproad_B7;
            mult_downroad_R7 = C0_mult_downroad_R7;
            mult_downroad_G7 = C0_mult_downroad_G7;
            mult_downroad_B7 = C0_mult_downroad_B7;
        end
        CLASS_1: begin
            mult_uproad_R7 = C1_mult_uproad_R7;
            mult_uproad_G7 = C1_mult_uproad_G7;
            mult_uproad_B7 = C1_mult_uproad_B7;
            mult_downroad_R7 = C1_mult_downroad_R7;
            mult_downroad_G7 = C1_mult_downroad_G7;
            mult_downroad_B7 = C1_mult_downroad_B7;
        end
        CLASS_2: begin
            mult_uproad_R7 = C2_mult_uproad_R7;
            mult_uproad_G7 = C2_mult_uproad_G7;
            mult_uproad_B7 = C2_mult_uproad_B7;
            mult_downroad_R7 = C2_mult_downroad_R7;
            mult_downroad_G7 = C2_mult_downroad_G7;
            mult_downroad_B7 = C2_mult_downroad_B7;
        end
        CLASS_3: begin
            mult_uproad_R7 = C3_mult_uproad_R7;
            mult_uproad_G7 = C3_mult_uproad_G7;
            mult_uproad_B7 = C3_mult_uproad_B7;
            mult_downroad_R7 = C3_mult_downroad_R7;
            mult_downroad_G7 = C3_mult_downroad_G7;
            mult_downroad_B7 = C3_mult_downroad_B7;
        end
        default: begin
            mult_uproad_R7 = C4_mult_uproad_R7;
            mult_uproad_G7 = C4_mult_uproad_G7;
            mult_uproad_B7 = C4_mult_uproad_B7;
            mult_downroad_R7 = C4_mult_downroad_R7;
            mult_downroad_G7 = C4_mult_downroad_G7;
            mult_downroad_B7 = C4_mult_downroad_B7;
        end
    endcase
end

// R8, G8, B8
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R8 = C0_mult_uproad_R8;
            mult_uproad_G8 = C0_mult_uproad_G8;
            mult_uproad_B8 = C0_mult_uproad_B8;
            mult_downroad_R8 = C0_mult_downroad_R8;
            mult_downroad_G8 = C0_mult_downroad_G8;
            mult_downroad_B8 = C0_mult_downroad_B8;
        end
        CLASS_1: begin
            mult_uproad_R8 = C1_mult_uproad_R8;
            mult_uproad_G8 = C1_mult_uproad_G8;
            mult_uproad_B8 = C1_mult_uproad_B8;
            mult_downroad_R8 = C1_mult_downroad_R8;
            mult_downroad_G8 = C1_mult_downroad_G8;
            mult_downroad_B8 = C1_mult_downroad_B8;
        end
        CLASS_2: begin
            mult_uproad_R8 = C2_mult_uproad_R8;
            mult_uproad_G8 = C2_mult_uproad_G8;
            mult_uproad_B8 = C2_mult_uproad_B8;
            mult_downroad_R8 = C2_mult_downroad_R8;
            mult_downroad_G8 = C2_mult_downroad_G8;
            mult_downroad_B8 = C2_mult_downroad_B8;
        end
        CLASS_3: begin
            mult_uproad_R8 = C3_mult_uproad_R8;
            mult_uproad_G8 = C3_mult_uproad_G8;
            mult_uproad_B8 = C3_mult_uproad_B8;
            mult_downroad_R8 = C3_mult_downroad_R8;
            mult_downroad_G8 = C3_mult_downroad_G8;
            mult_downroad_B8 = C3_mult_downroad_B8;
        end
        default: begin
            mult_uproad_R8 = C4_mult_uproad_R8;
            mult_uproad_G8 = C4_mult_uproad_G8;
            mult_uproad_B8 = C4_mult_uproad_B8;
            mult_downroad_R8 = C4_mult_downroad_R8;
            mult_downroad_G8 = C4_mult_downroad_G8;
            mult_downroad_B8 = C4_mult_downroad_B8;
        end
    endcase
end

// R9, G9, B9
always@(*) begin
    case(class_i)
        CLASS_0: begin
            mult_uproad_R9 = C0_mult_uproad_R9;
            mult_uproad_G9 = C0_mult_uproad_G9;
            mult_uproad_B9 = C0_mult_uproad_B9;
            mult_downroad_R9 = C0_mult_downroad_R9;
            mult_downroad_G9 = C0_mult_downroad_G9;
            mult_downroad_B9 = C0_mult_downroad_B9;
        end
        CLASS_1: begin
            mult_uproad_R9 = C1_mult_uproad_R9;
            mult_uproad_G9 = C1_mult_uproad_G9;
            mult_uproad_B9 = C1_mult_uproad_B9;
            mult_downroad_R9 = C1_mult_downroad_R9;
            mult_downroad_G9 = C1_mult_downroad_G9;
            mult_downroad_B9 = C1_mult_downroad_B9;
        end
        CLASS_2: begin
            mult_uproad_R9 = C2_mult_uproad_R9;
            mult_uproad_G9 = C2_mult_uproad_G9;
            mult_uproad_B9 = C2_mult_uproad_B9;
            mult_downroad_R9 = C2_mult_downroad_R9;
            mult_downroad_G9 = C2_mult_downroad_G9;
            mult_downroad_B9 = C2_mult_downroad_B9;
        end
        CLASS_3: begin
            mult_uproad_R9 = C3_mult_uproad_R9;
            mult_uproad_G9 = C3_mult_uproad_G9;
            mult_uproad_B9 = C3_mult_uproad_B9;
            mult_downroad_R9 = C3_mult_downroad_R9;
            mult_downroad_G9 = C3_mult_downroad_G9;
            mult_downroad_B9 = C3_mult_downroad_B9;
        end
        default: begin
            mult_uproad_R9 = C4_mult_uproad_R9;
            mult_uproad_G9 = C4_mult_uproad_G9;
            mult_uproad_B9 = C4_mult_uproad_B9;
            mult_downroad_R9 = C4_mult_downroad_R9;
            mult_downroad_G9 = C4_mult_downroad_G9;
            mult_downroad_B9 = C4_mult_downroad_B9;
        end
    endcase
end

//==============================//
/// Pipeline insertion ///
// medium pxl (R5,G5,B5)

reg [NN_IN_BIT -1 : 0] med_pxl_R_stg1;
reg [NN_IN_BIT -1 : 0] med_pxl_G_stg1;
reg [NN_IN_BIT -1 : 0] med_pxl_B_stg1;

reg [NN_IN_BIT -1 : 0] med_pxl_R_stg2;
reg [NN_IN_BIT -1 : 0] med_pxl_G_stg2;
reg [NN_IN_BIT -1 : 0] med_pxl_B_stg2;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        med_pxl_R_stg1 <= 'd0;
        med_pxl_R_stg2 <= 'd0;
    end
    else begin
        med_pxl_R_stg1 <= NN_R5_i;
        med_pxl_R_stg2 <= med_pxl_R_stg1;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        med_pxl_G_stg1 <= 'd0;
        med_pxl_G_stg2 <= 'd0;
    end
    else begin
        med_pxl_G_stg1 <= NN_G5_i;
        med_pxl_G_stg2 <= med_pxl_G_stg1;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        med_pxl_B_stg1 <= 'd0;
        med_pxl_B_stg2 <= 'd0;
    end
    else begin
        med_pxl_B_stg1 <= NN_B5_i;
        med_pxl_B_stg2 <= med_pxl_B_stg1;
    end
end



///=============================//
// sgn extension (check)
///=============================//

// Red Part
wire signed [NN_IN_BIT  : 0] NN_R1_sgn;
wire signed [NN_IN_BIT  : 0] NN_R2_sgn;
wire signed [NN_IN_BIT  : 0] NN_R3_sgn;
wire signed [NN_IN_BIT  : 0] NN_R4_sgn;
wire signed [NN_IN_BIT  : 0] NN_R5_sgn;
wire signed [NN_IN_BIT  : 0] NN_R6_sgn;
wire signed [NN_IN_BIT  : 0] NN_R7_sgn;
wire signed [NN_IN_BIT  : 0] NN_R8_sgn;
wire signed [NN_IN_BIT  : 0] NN_R9_sgn;

// R part sign extension
assign NN_R1_sgn = {1'b0 , NN_R1_i};
assign NN_R2_sgn = {1'b0 , NN_R2_i};
assign NN_R3_sgn = {1'b0 , NN_R3_i};
assign NN_R4_sgn = {1'b0 , NN_R4_i};
assign NN_R5_sgn = {1'b0 , NN_R5_i};
assign NN_R6_sgn = {1'b0 , NN_R6_i};
assign NN_R7_sgn = {1'b0 , NN_R7_i};
assign NN_R8_sgn = {1'b0 , NN_R8_i};
assign NN_R9_sgn = {1'b0 , NN_R9_i};

// Green Part
wire signed [NN_IN_BIT  : 0] NN_G1_sgn;
wire signed [NN_IN_BIT  : 0] NN_G2_sgn;
wire signed [NN_IN_BIT  : 0] NN_G3_sgn;
wire signed [NN_IN_BIT  : 0] NN_G4_sgn;
wire signed [NN_IN_BIT  : 0] NN_G5_sgn;
wire signed [NN_IN_BIT  : 0] NN_G6_sgn;
wire signed [NN_IN_BIT  : 0] NN_G7_sgn;
wire signed [NN_IN_BIT  : 0] NN_G8_sgn;
wire signed [NN_IN_BIT  : 0] NN_G9_sgn;

assign NN_G1_sgn = {1'b0 , NN_G1_i};
assign NN_G2_sgn = {1'b0 , NN_G2_i};
assign NN_G3_sgn = {1'b0 , NN_G3_i};
assign NN_G4_sgn = {1'b0 , NN_G4_i};
assign NN_G5_sgn = {1'b0 , NN_G5_i};
assign NN_G6_sgn = {1'b0 , NN_G6_i};
assign NN_G7_sgn = {1'b0 , NN_G7_i};
assign NN_G8_sgn = {1'b0 , NN_G8_i};
assign NN_G9_sgn = {1'b0 , NN_G9_i};

// Blue Part
wire signed [NN_IN_BIT  : 0] NN_B1_sgn;
wire signed [NN_IN_BIT  : 0] NN_B2_sgn;
wire signed [NN_IN_BIT  : 0] NN_B3_sgn;
wire signed [NN_IN_BIT  : 0] NN_B4_sgn;
wire signed [NN_IN_BIT  : 0] NN_B5_sgn;
wire signed [NN_IN_BIT  : 0] NN_B6_sgn;
wire signed [NN_IN_BIT  : 0] NN_B7_sgn;
wire signed [NN_IN_BIT  : 0] NN_B8_sgn;
wire signed [NN_IN_BIT  : 0] NN_B9_sgn;

assign NN_B1_sgn = {1'b0 , NN_B1_i};
assign NN_B2_sgn = {1'b0 , NN_B2_i};
assign NN_B3_sgn = {1'b0 , NN_B3_i};
assign NN_B4_sgn = {1'b0 , NN_B4_i};
assign NN_B5_sgn = {1'b0 , NN_B5_i};
assign NN_B6_sgn = {1'b0 , NN_B6_i};
assign NN_B7_sgn = {1'b0 , NN_B7_i};
assign NN_B8_sgn = {1'b0 , NN_B8_i};
assign NN_B9_sgn = {1'b0 , NN_B9_i};


//====================================//
// CONV
//====================================//

// uproad
// R (37bit)
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R1;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R2;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R3;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R4;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R5;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R6;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R7;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R8;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT ) : 0] mult_conv_uproad_R9;



// G (37bit)
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G1;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G2;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G3;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G4;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G5;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G6;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G7;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G8;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_G9;



// B (37bit)
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B1;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B2;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B3;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B4;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B5;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B6;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B7;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B8;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_uproad_B9;



// downroad
// R (37bit)
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R1;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R2;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R3;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R4;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R5;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R6;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R7;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R8;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_R9;



// G (37bit)
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G1;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G2;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G3;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G4;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G5;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G6;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G7;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G8;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_G9;



// B (37bit)
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B1;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B2;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B3;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B4;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B5;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B6;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B7;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B8;
reg signed [(NN_IN_BIT + NN_KERNEL_BIT) : 0] mult_conv_downroad_B9;

///=======================================================///
// uproad mult Stage1 Pipeline insertion
///=======================================================///

// R
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mult_conv_uproad_R1 <= 'd0;
        mult_conv_uproad_R2 <= 'd0;
        mult_conv_uproad_R3 <= 'd0;
        mult_conv_uproad_R4 <= 'd0;
        mult_conv_uproad_R5 <= 'd0;
        mult_conv_uproad_R6 <= 'd0;
        mult_conv_uproad_R7 <= 'd0;
        mult_conv_uproad_R8 <= 'd0;
        mult_conv_uproad_R9 <= 'd0;
    end
    else begin
        mult_conv_uproad_R1 <= NN_R1_sgn * mult_uproad_R1 ;
        mult_conv_uproad_R2 <= NN_R2_sgn * mult_uproad_R2 ;
        mult_conv_uproad_R3 <= NN_R3_sgn * mult_uproad_R3 ;
        mult_conv_uproad_R4 <= NN_R4_sgn * mult_uproad_R4 ;
        mult_conv_uproad_R5 <= NN_R5_sgn * mult_uproad_R5 ;
        mult_conv_uproad_R6 <= NN_R6_sgn * mult_uproad_R6 ;
        mult_conv_uproad_R7 <= NN_R7_sgn * mult_uproad_R7 ;
        mult_conv_uproad_R8 <= NN_R8_sgn * mult_uproad_R8 ;
        mult_conv_uproad_R9 <= NN_R9_sgn * mult_uproad_R9 ;
    end
end



// G
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mult_conv_uproad_G1 <= 'd0;
        mult_conv_uproad_G2 <= 'd0;
        mult_conv_uproad_G3 <= 'd0;
        mult_conv_uproad_G4 <= 'd0;
        mult_conv_uproad_G5 <= 'd0;
        mult_conv_uproad_G6 <= 'd0;
        mult_conv_uproad_G7 <= 'd0;
        mult_conv_uproad_G8 <= 'd0;
        mult_conv_uproad_G9 <= 'd0;
    end
    else begin
        mult_conv_uproad_G1 <= NN_G1_sgn * mult_uproad_G1 ;
        mult_conv_uproad_G2 <= NN_G2_sgn * mult_uproad_G2 ;
        mult_conv_uproad_G3 <= NN_G3_sgn * mult_uproad_G3 ;
        mult_conv_uproad_G4 <= NN_G4_sgn * mult_uproad_G4 ;
        mult_conv_uproad_G5 <= NN_G5_sgn * mult_uproad_G5 ;
        mult_conv_uproad_G6 <= NN_G6_sgn * mult_uproad_G6 ;
        mult_conv_uproad_G7 <= NN_G7_sgn * mult_uproad_G7 ;
        mult_conv_uproad_G8 <= NN_G8_sgn * mult_uproad_G8 ;
        mult_conv_uproad_G9 <= NN_G9_sgn * mult_uproad_G9 ;
    end
end


//B
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mult_conv_uproad_B1 <= 'd0;
        mult_conv_uproad_B2 <= 'd0;
        mult_conv_uproad_B3 <= 'd0;
        mult_conv_uproad_B4 <= 'd0;
        mult_conv_uproad_B5 <= 'd0;
        mult_conv_uproad_B6 <= 'd0;
        mult_conv_uproad_B7 <= 'd0;
        mult_conv_uproad_B8 <= 'd0;
        mult_conv_uproad_B9 <= 'd0;
    end
    else begin
        mult_conv_uproad_B1 <= NN_B1_sgn * mult_uproad_B1 ;
        mult_conv_uproad_B2 <= NN_B2_sgn * mult_uproad_B2 ;
        mult_conv_uproad_B3 <= NN_B3_sgn * mult_uproad_B3 ;
        mult_conv_uproad_B4 <= NN_B4_sgn * mult_uproad_B4 ;
        mult_conv_uproad_B5 <= NN_B5_sgn * mult_uproad_B5 ;
        mult_conv_uproad_B6 <= NN_B6_sgn * mult_uproad_B6 ;
        mult_conv_uproad_B7 <= NN_B7_sgn * mult_uproad_B7 ;
        mult_conv_uproad_B8 <= NN_B8_sgn * mult_uproad_B8 ;
        mult_conv_uproad_B9 <= NN_B9_sgn * mult_uproad_B9 ;
    end
end

// downroad mult
// R (37bit)
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mult_conv_downroad_R1 <= 'd0;
        mult_conv_downroad_R2 <= 'd0;
        mult_conv_downroad_R3 <= 'd0;
        mult_conv_downroad_R4 <= 'd0;
        mult_conv_downroad_R5 <= 'd0;
        mult_conv_downroad_R6 <= 'd0;
        mult_conv_downroad_R7 <= 'd0;
        mult_conv_downroad_R8 <= 'd0;
        mult_conv_downroad_R9 <= 'd0;
    end
    else begin
        mult_conv_downroad_R1 <= NN_R1_sgn * mult_downroad_R1 ;
        mult_conv_downroad_R2 <= NN_R2_sgn * mult_downroad_R2 ;
        mult_conv_downroad_R3 <= NN_R3_sgn * mult_downroad_R3 ;
        mult_conv_downroad_R4 <= NN_R4_sgn * mult_downroad_R4 ;
        mult_conv_downroad_R5 <= NN_R5_sgn * mult_downroad_R5 ;
        mult_conv_downroad_R6 <= NN_R6_sgn * mult_downroad_R6 ;
        mult_conv_downroad_R7 <= NN_R7_sgn * mult_downroad_R7 ;
        mult_conv_downroad_R8 <= NN_R8_sgn * mult_downroad_R8 ;
        mult_conv_downroad_R9 <= NN_R9_sgn * mult_downroad_R9 ;
    end
end


// G (37bit)
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mult_conv_downroad_G1 <= 'd0;
        mult_conv_downroad_G2 <= 'd0;
        mult_conv_downroad_G3 <= 'd0;
        mult_conv_downroad_G4 <= 'd0;
        mult_conv_downroad_G5 <= 'd0;
        mult_conv_downroad_G6 <= 'd0;
        mult_conv_downroad_G7 <= 'd0;
        mult_conv_downroad_G8 <= 'd0;
        mult_conv_downroad_G9 <= 'd0;
    end
    else begin
        mult_conv_downroad_G1 <= NN_G1_sgn * mult_downroad_G1 ;
        mult_conv_downroad_G2 <= NN_G2_sgn * mult_downroad_G2 ;
        mult_conv_downroad_G3 <= NN_G3_sgn * mult_downroad_G3 ;
        mult_conv_downroad_G4 <= NN_G4_sgn * mult_downroad_G4 ;
        mult_conv_downroad_G5 <= NN_G5_sgn * mult_downroad_G5 ;
        mult_conv_downroad_G6 <= NN_G6_sgn * mult_downroad_G6 ;
        mult_conv_downroad_G7 <= NN_G7_sgn * mult_downroad_G7 ;
        mult_conv_downroad_G8 <= NN_G8_sgn * mult_downroad_G8 ;
        mult_conv_downroad_G9 <= NN_G9_sgn * mult_downroad_G9 ;
    end
end



//B (37bit)
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mult_conv_downroad_B1 <= 'd0;
        mult_conv_downroad_B2 <= 'd0;
        mult_conv_downroad_B3 <= 'd0;
        mult_conv_downroad_B4 <= 'd0;
        mult_conv_downroad_B5 <= 'd0;
        mult_conv_downroad_B6 <= 'd0;
        mult_conv_downroad_B7 <= 'd0;
        mult_conv_downroad_B8 <= 'd0;
        mult_conv_downroad_B9 <= 'd0;
    end
    else begin
        mult_conv_downroad_B1 <= NN_B1_sgn * mult_downroad_B1 ;
        mult_conv_downroad_B2 <= NN_B2_sgn * mult_downroad_B2 ;
        mult_conv_downroad_B3 <= NN_B3_sgn * mult_downroad_B3 ;
        mult_conv_downroad_B4 <= NN_B4_sgn * mult_downroad_B4 ;
        mult_conv_downroad_B5 <= NN_B5_sgn * mult_downroad_B5 ;
        mult_conv_downroad_B6 <= NN_B6_sgn * mult_downroad_B6 ;
        mult_conv_downroad_B7 <= NN_B7_sgn * mult_downroad_B7 ;
        mult_conv_downroad_B8 <= NN_B8_sgn * mult_downroad_B8 ;
        mult_conv_downroad_B9 <= NN_B9_sgn * mult_downroad_B9 ;
    end
end


///======================================///
// CONV datapath
///======================================///

// uproad (41bit = 1bit signed bit + 8bit int + 32 bit binary floating point)
reg signed [40 : 0] conv_uproad_R;
reg signed [40 : 0] conv_uproad_G;
reg signed [40 : 0] conv_uproad_B;

//R
always@(*)begin
    conv_uproad_R = (mult_conv_uproad_R1 + mult_conv_uproad_R2) +
                    (mult_conv_uproad_R3 + mult_conv_uproad_R4) + 
                    (mult_conv_uproad_R5 + mult_conv_uproad_R6) +
                    (mult_conv_uproad_R7 + mult_conv_uproad_R8) +
                     mult_conv_uproad_R9 ;
end

//G
always@(*)begin
    conv_uproad_G = (mult_conv_uproad_G1 + mult_conv_uproad_G2) +
                    (mult_conv_uproad_G3 + mult_conv_uproad_G4) + 
                    (mult_conv_uproad_G5 + mult_conv_uproad_G6) +
                    (mult_conv_uproad_G7 + mult_conv_uproad_G8) +
                     mult_conv_uproad_G9 ;
end

//B
always@(*)begin
    conv_uproad_B = (mult_conv_uproad_B1 + mult_conv_uproad_B2) +
                    (mult_conv_uproad_B3 + mult_conv_uproad_B4) + 
                    (mult_conv_uproad_B5 + mult_conv_uproad_B6) +
                    (mult_conv_uproad_B7 + mult_conv_uproad_B8) +
                     mult_conv_uproad_B9 ;
end


// downrad (41bit = 1bit signed bit + 8bit int + 32 bit binary floating point)
reg signed [40 : 0] conv_downroad_R;
reg signed [40 : 0] conv_downroad_G;
reg signed [40 : 0] conv_downroad_B;

//R
always@(*)begin
    conv_downroad_R =   (mult_conv_downroad_R1 + mult_conv_downroad_R2) +
                        (mult_conv_downroad_R3 + mult_conv_downroad_R4) + 
                        (mult_conv_downroad_R5 + mult_conv_downroad_R6) +
                        (mult_conv_downroad_R7 + mult_conv_downroad_R8) +
                         mult_conv_downroad_R9 ;
end

//G
always@(*)begin
    conv_downroad_G =   (mult_conv_downroad_G1 + mult_conv_downroad_G2) +
                        (mult_conv_downroad_G3 + mult_conv_downroad_G4) + 
                        (mult_conv_downroad_G5 + mult_conv_downroad_G6) +
                        (mult_conv_downroad_G7 + mult_conv_downroad_G8) +
                         mult_conv_downroad_G9 ;
end

//B
always@(*)begin
    conv_downroad_B =   (mult_conv_downroad_B1 + mult_conv_downroad_B2) +
                        (mult_conv_downroad_B3 + mult_conv_downroad_B4) + 
                        (mult_conv_downroad_B5 + mult_conv_downroad_B6) +
                        (mult_conv_downroad_B7 + mult_conv_downroad_B8) +
                         mult_conv_downroad_B9 ;
end

///=========================================================///
/// Pipeline stage one
///=========================================================///
// truncation uproad (25bit = 1bit sgn + 8bit int + 16 bit floating point)
reg signed [24:0] conv_trun_uproad_R;
reg signed [24:0] conv_trun_uproad_G;
reg signed [24:0] conv_trun_uproad_B;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        conv_trun_uproad_R <= 'd0;
        conv_trun_uproad_G <= 'd0;
        conv_trun_uproad_B <= 'd0;
    end
    else begin
        conv_trun_uproad_R <= {conv_uproad_R[40:32],conv_uproad_R[31:16]};
        conv_trun_uproad_G <= {conv_uproad_G[40:32],conv_uproad_G[31:16]};
        conv_trun_uproad_B <= {conv_uproad_B[40:32],conv_uproad_B[31:16]};
    end
end


// truncation downroad (25bit = 1bit sgn + 8bit int + 16 bit floating point)
reg signed [24:0] conv_trun_downroad_R;
reg signed [24:0] conv_trun_downroad_G;
reg signed [24:0] conv_trun_downroad_B;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        conv_trun_downroad_R <= 'd0;
        conv_trun_downroad_G <= 'd0;
        conv_trun_downroad_B <= 'd0;
    end
    else begin
        conv_trun_downroad_R <= {conv_downroad_R[40:32],conv_downroad_R[31:16]};
        conv_trun_downroad_G <= {conv_downroad_G[40:32],conv_downroad_G[31:16]};
        conv_trun_downroad_B <= {conv_downroad_B[40:32],conv_downroad_B[31:16]};
    end
end


///======================================///
// Bias adder
///======================================///

/// uproad (25bit = 1bit sgn + 8bit int + 16 bit floating point)
reg signed [24:0] bias_result_uproad_R;
reg signed [24:0] bias_result_uproad_G;
reg signed [24:0] bias_result_uproad_B;

//R
always@(*)begin
    bias_result_uproad_R = conv_trun_uproad_R + bias_uproad_R;
end

//G
always@(*)begin
    bias_result_uproad_G = conv_trun_uproad_G + bias_uproad_G;
end

//B
always@(*)begin
    bias_result_uproad_B = conv_trun_uproad_B + bias_uproad_B;
end


/// downroad (25bit = 1bit sgn + 8bit int + 16 bit floating point)
reg signed [24:0] bias_result_downroad_R;
reg signed [24:0] bias_result_downroad_G;
reg signed [24:0] bias_result_downroad_B;

//R
always@(*)begin
    bias_result_downroad_R = conv_trun_downroad_R + bias_downroad_R;
end

//G
always@(*)begin
    bias_result_downroad_G = conv_trun_downroad_G + bias_downroad_G;
end

//B
always@(*)begin
    bias_result_downroad_B = conv_trun_downroad_B + bias_downroad_B;
end


///======================================///
// Relu :
// input = 25 bit
// output = 24 bit
///======================================///

// uproad
wire [23:0] Relu_uproad_R_w;
wire [23:0] Relu_uproad_G_w;
wire [23:0] Relu_uproad_B_w;

//Relu R
Relu #(.N(25))
    relu_uproad_r(
    .relu_i(bias_result_uproad_R),
    .relu_o(Relu_uproad_R_w)
    );

//Relu G
Relu #(.N(25))
    relu_uproad_g(
    .relu_i(bias_result_uproad_G),
    .relu_o(Relu_uproad_G_w)
    );

//Relu G
Relu #(.N(25))
    relu_uproad_b(
    .relu_i(bias_result_uproad_B),
    .relu_o(Relu_uproad_B_w)
    );


// downroad
wire [23:0] Relu_downroad_R_w;
wire [23:0] Relu_downroad_G_w;
wire [23:0] Relu_downroad_B_w;

//Relu R
Relu #(.N(25))
    relu_downroad_r(
    .relu_i(bias_result_downroad_R),
    .relu_o(Relu_downroad_R_w)
    );

//Relu G
Relu #(.N(25))
    relu_downroad_g(
    .relu_i(bias_result_downroad_G),
    .relu_o(Relu_downroad_G_w)
    );

//Relu G
Relu #(.N(25))
    relu_downroad_b(
    .relu_i(bias_result_downroad_B),
    .relu_o(Relu_downroad_B_w)
    );

// truncation relu ( 8bit int + 16bit floating point)
wire [23:0] Relu_uproad_R;
wire [23:0] Relu_uproad_G;
wire [23:0] Relu_uproad_B;
assign Relu_uproad_R = Relu_uproad_R_w[23:0];
assign Relu_uproad_G = Relu_uproad_G_w[23:0];
assign Relu_uproad_B = Relu_uproad_B_w[23:0];

wire [23:0] Relu_downroad_R;
wire [23:0] Relu_downroad_G;
wire [23:0] Relu_downroad_B;
assign Relu_downroad_R = Relu_downroad_R_w[23:0];
assign Relu_downroad_G = Relu_downroad_G_w[23:0];
assign Relu_downroad_B = Relu_downroad_B_w[23:0];
///======================================///
// Adder after Relu
///======================================///

// uproad
reg [23:0] add_aft_relu_uproad_R;
reg [23:0] add_aft_relu_uproad_G;
reg [23:0] add_aft_relu_uproad_B;

always@(*)begin
    add_aft_relu_uproad_R = Relu_uproad_R + med_pxl_R_stg2;
    add_aft_relu_uproad_G = Relu_uproad_G + med_pxl_G_stg2;
    add_aft_relu_uproad_B = Relu_uproad_B + med_pxl_B_stg2;
end

//downroad
reg [23:0] add_aft_relu_downroad_R;
reg [23:0] add_aft_relu_downroad_G;
reg [23:0] add_aft_relu_downroad_B;

always@(*)begin
    add_aft_relu_downroad_R = Relu_downroad_R + med_pxl_R_stg2;
    add_aft_relu_downroad_G = Relu_downroad_G + med_pxl_G_stg2;
    add_aft_relu_downroad_B = Relu_downroad_B + med_pxl_B_stg2;
end

///======================================///
// Merge Adder
///======================================///

//uproad
reg [23:0] merge_adder_R;
reg [23:0] merge_adder_G;
reg [23:0] merge_adder_B;


always@(*)begin
    merge_adder_R = add_aft_relu_uproad_R + add_aft_relu_downroad_R;
    merge_adder_G = add_aft_relu_uproad_G + add_aft_relu_downroad_G;
    merge_adder_B = add_aft_relu_uproad_B + add_aft_relu_downroad_B;
end


///======================================///
// judger 
///======================================///

reg [16:0] judger_R;
reg [16:0] judger_G;
reg [16:0] judger_B;

always@(*)begin
    judger_R = (merge_adder_R[23] || merge_adder_R[22] || merge_adder_R[21] || merge_adder_R[20] ||
                merge_adder_R[19] || merge_adder_R[18] || merge_adder_R[17] || merge_adder_R[16] )? 17'b1_0000_0000_0000_0000: merge_adder_R[16:0];
end

always@(*)begin
    judger_G = (merge_adder_G[23] ||merge_adder_G[22] ||merge_adder_G[21] ||
                merge_adder_G[20] ||merge_adder_G[19] ||merge_adder_G[18] ||
                merge_adder_G[17] || merge_adder_G[16] )? 17'b1_0000_0000_0000_0000: merge_adder_G[16:0];
end

always@(*)begin
    judger_B = (merge_adder_B[23] ||merge_adder_B[22] ||merge_adder_B[21] ||
                merge_adder_B[20] ||merge_adder_B[19] ||merge_adder_B[18] ||
                merge_adder_B[17] || merge_adder_B[16] )? 17'b1_0000_0000_0000_0000: merge_adder_B[16:0];
end



///======================================///
// final (5bit int + 11bit floating point)
///======================================///
wire [15:0] final_R;
wire [15:0] final_G;
wire [15:0] final_B;

assign final_R = judger_R[16:1]; 
assign final_G = judger_G[16:1]; 
assign final_B = judger_B[16:1]; 

///======================================///
// pipeline final stage
///======================================///
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        NN_onepxl_R_o <= 'd0;
        NN_onepxl_G_o <= 'd0;
        NN_onepxl_B_o <= 'd0;    
    end
    else begin
        NN_onepxl_R_o <= final_R;
        NN_onepxl_G_o <= final_G;
        NN_onepxl_B_o <= final_B;
    end
end
endmodule


