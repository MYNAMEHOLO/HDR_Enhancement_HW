//===================================================//
// Module created in 2024.1.11
// Creator: R.T. Lee
// Module name: Linear Inverse Tonemapping RTL
//===================================================//
module LIT
#(
parameter LIT_IN = `LIT_IN,
parameter LIT_OUT = `LIT_OUT
)
(
input [LIT_IN - 1 : 0] LIT_in,
input clk,
input rst_n,
output reg [LIT_OUT - 1: 0] LIT_out
);

// parameter for condition
parameter const0_6     = 9'b0_10011001;
parameter const0_64444 = 9'b0_10100100;
parameter const0_68889 = 9'b0_10110000;
parameter const0_73333 = 9'b0_10111011;
parameter const0_77778 = 9'b0_11000111;
parameter const0_82222 = 9'b0_11010010;
parameter const0_86667 = 9'b0_11011101;
parameter const0_91111 = 9'b0_11101001;
parameter const0_95556 = 9'b0_11110100;
parameter const1       = 9'b1_00000000;

// parameter for operation;
parameter const0_36     = 19'b000_0101110000101000;
parameter const0_180625 = 19'b000_0010111000111101;
parameter const0_520625 = 19'b000_1000010101000111;
parameter const0_284375 = 19'b000_0100100011001100;
parameter const0_75375  = 19'b000_1100000011110101;
parameter const0_957    = 19'b000_1111010011111101;
parameter const0_445    = 19'b000_0111000111101011;
parameter const1_09125  = 19'b001_0001011101011100;
parameter const0_6925   = 19'b000_1011000101000111;
parameter const1_57875  = 19'b001_1001010000101000;
parameter const1_0725   = 19'b001_0001001010001111;
parameter const2_285625 = 19'b010_0100100100011110;
parameter const1_65375  = 19'b001_1010011101011100;
parameter const3_3075   = 19'b011_0100111010111000;
parameter const2_540625 = 19'b010_1000101001100110;
parameter const4_786875 = 19'b100_1100100101110000;
parameter const3_89     = 19'b011_1110001111010111;
parameter const6_94     = 19'b110_1111000010100011;
parameter const5_949375 = 19'b101_1111001100001010;


// comb logic here
reg [18:0] mult_r;
reg [18:0] sub_r;
wire [16:0] before_sft;
wire [16:0] after_sft;
wire [15:0] after_sft_16b;
wire [27:0] mult_28b;
wire [18:0] mult_19b;
wire [18:0] sub_result;
wire [15:0] sub_result_16b;

// for LIT_in <const0_6
assign before_sft = {LIT_in,{8{1'd0}}};
assign after_sft = (before_sft >> 4);
assign after_sft_16b = after_sft[15:0];

// mult part
assign mult_28b = LIT_in * mult_r;
assign mult_19b = mult_28b[26:8];

// sub part ( result of Linear Transform for const0_64444 < LIT_in )
assign sub_result = mult_19b - sub_r;
assign sub_result_16b = sub_result[15:0];

// multiplicand and subtrehend choosing
always@(*)begin
    if(LIT_in < const0_64444)begin
        mult_r = const0_36;
        sub_r = const0_180625;
    end
    else if(LIT_in < const0_68889)begin
        mult_r = const0_520625;
        sub_r = const0_284375;
    end
    else if(LIT_in < const0_73333)begin
        mult_r = const0_75375;
        sub_r = const0_445;
    end
    else if(LIT_in < const0_77778)begin
        mult_r = const1_09125;
        sub_r = const0_6925;
    end
    else if(LIT_in < const0_82222)begin
        mult_r = const1_57875;
        sub_r = const1_0725;
    end
    else if(LIT_in < const0_86667)begin
        mult_r = const2_285625;
        sub_r = const1_65375;
    end
    else if(LIT_in < const0_91111)begin
        mult_r = const3_3075;
        sub_r = const2_540625;
    end
    else if(LIT_in < const0_95556)begin
        mult_r = const4_786875;
        sub_r = const3_89;
    end
    else begin
        mult_r = const6_94;
        sub_r = const5_949375;
    end
end


// sequential here
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) LIT_out <= 'd0;
    else LIT_out <= (LIT_in < const0_6)? after_sft_16b : sub_result_16b;
end

endmodule