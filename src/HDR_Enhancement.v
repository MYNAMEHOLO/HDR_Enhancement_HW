//===================================================//
// Module created in 2024.2.15
// Creator: R.T. Lee
// Module name: HDR_Enhancement
//===================================================//

module HDR_Enhancement(
    // clk
    input clk,

    // input async low reset
    input rst_n,

    // src R,G,B data input
    input [ (`LIT_IN - 1) : 0] R1_DATA_i,
    input [ (`LIT_IN - 1) : 0] R2_DATA_i,
    input [ (`LIT_IN - 1) : 0] R3_DATA_i,
    input [ (`LIT_IN - 1) : 0] R4_DATA_i,
    input [ (`LIT_IN - 1) : 0] R5_DATA_i,
    input [ (`LIT_IN - 1) : 0] R6_DATA_i,
    input [ (`LIT_IN - 1) : 0] R7_DATA_i,
    input [ (`LIT_IN - 1) : 0] R8_DATA_i,
    input [ (`LIT_IN - 1) : 0] R9_DATA_i, 
 
    input [ (`LIT_IN - 1) : 0] G1_DATA_i,
    input [ (`LIT_IN - 1) : 0] G2_DATA_i,
    input [ (`LIT_IN - 1) : 0] G3_DATA_i,
    input [ (`LIT_IN - 1) : 0] G4_DATA_i,
    input [ (`LIT_IN - 1) : 0] G5_DATA_i,
    input [ (`LIT_IN - 1) : 0] G6_DATA_i,
    input [ (`LIT_IN - 1) : 0] G7_DATA_i,
    input [ (`LIT_IN - 1) : 0] G8_DATA_i,
    input [ (`LIT_IN - 1) : 0] G9_DATA_i, 
 
    input [ (`LIT_IN - 1) : 0] B1_DATA_i,
    input [ (`LIT_IN - 1) : 0] B2_DATA_i,
    input [ (`LIT_IN - 1) : 0] B3_DATA_i,
    input [ (`LIT_IN - 1) : 0] B4_DATA_i,
    input [ (`LIT_IN - 1) : 0] B5_DATA_i,
    input [ (`LIT_IN - 1) : 0] B6_DATA_i,
    input [ (`LIT_IN - 1) : 0] B7_DATA_i,
    input [ (`LIT_IN - 1) : 0] B8_DATA_i,
    input [ (`LIT_IN - 1) : 0] B9_DATA_i,

    // output one pxl R,G,B
    output [ (`NN_OUT_BIT - 1) : 0] one_pxl_R_o,
    output [ (`NN_OUT_BIT - 1) : 0] one_pxl_G_o,
    output [ (`NN_OUT_BIT - 1) : 0] one_pxl_B_o
);

// wire define
// class
wire [ (`Class_result_bit - 1): 0] class_w;

// pxl after Linear Inverse Tonemapping
// R Channel
wire [ (`NN_IN_BIT - 1) : 0] R1_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R2_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R3_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R4_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R5_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R6_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R7_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R8_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] R9_LIT_w;

// G Channel
wire [ (`NN_IN_BIT - 1) : 0] G1_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G2_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G3_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G4_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G5_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G6_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G7_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G8_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] G9_LIT_w;

// B Channel
wire [ (`NN_IN_BIT - 1) : 0] B1_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B2_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B3_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B4_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B5_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B6_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B7_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B8_LIT_w;
wire [ (`NN_IN_BIT - 1) : 0] B9_LIT_w;


// porting connection


///=============================///
// Linear Transform
///=============================///
// R Channel
LIT #(
    .LIT_IN  (`LIT_IN), 
    .LIT_OUT (`LIT_OUT) 
) u_R1 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R1_DATA_i),
    .LIT_out(R1_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R2 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R2_DATA_i),
    .LIT_out(R2_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R3 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R3_DATA_i),
    .LIT_out(R3_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R4 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R4_DATA_i),
    .LIT_out(R4_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R5 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R5_DATA_i),
    .LIT_out(R5_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R6 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R6_DATA_i),
    .LIT_out(R6_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R7 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R7_DATA_i),
    .LIT_out(R7_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R8 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R8_DATA_i),
    .LIT_out(R8_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_R9 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(R9_DATA_i),
    .LIT_out(R9_LIT_w)
);


// G Channel
LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G1 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G1_DATA_i),
    .LIT_out(G1_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G2 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G2_DATA_i),
    .LIT_out(G2_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G3 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G3_DATA_i),
    .LIT_out(G3_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G4 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G4_DATA_i),
    .LIT_out(G4_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G5 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G5_DATA_i),
    .LIT_out(G5_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G6 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G6_DATA_i),
    .LIT_out(G6_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G7 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G7_DATA_i),
    .LIT_out(G7_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G8 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G8_DATA_i),
    .LIT_out(G8_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_G9 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(G9_DATA_i),
    .LIT_out(G9_LIT_w)
);

// B Channel
LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B1 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B1_DATA_i),
    .LIT_out(B1_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B2 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B2_DATA_i),
    .LIT_out(B2_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B3 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B3_DATA_i),
    .LIT_out(B3_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B4 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B4_DATA_i),
    .LIT_out(B4_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B5 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B5_DATA_i),
    .LIT_out(B5_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B6 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B6_DATA_i),
    .LIT_out(B6_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B7 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B7_DATA_i),
    .LIT_out(B7_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B8 (
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B8_DATA_i),
    .LIT_out(B8_LIT_w)
);

LIT #(
    .LIT_IN  (`LIT_IN),
    .LIT_OUT (`LIT_OUT)
) u_B9(
    .clk(clk),
    .rst_n(rst_n),
    .LIT_in(B9_DATA_i),
    .LIT_out(B9_LIT_w)
);




// Classfication (check)
Classification #(
    .Class_in_bit(`Class_in_bit),
    .Class_result_bit(`Class_result_bit)
) u_Classification (
    // clk
    .clk(clk),

    // active low rst
    .rst_n(rst_n),

    // R Channel in
    .R1_IN(R1_DATA_i),
    .R2_IN(R2_DATA_i),
    .R3_IN(R3_DATA_i),
    .R4_IN(R4_DATA_i),
    .R5_IN(R5_DATA_i),
    .R6_IN(R6_DATA_i),
    .R7_IN(R7_DATA_i),
    .R8_IN(R8_DATA_i),
    .R9_IN(R9_DATA_i),

    // G Channel in
    .G1_IN(G1_DATA_i),
    .G2_IN(G2_DATA_i),
    .G3_IN(G3_DATA_i),
    .G4_IN(G4_DATA_i),
    .G5_IN(G5_DATA_i),
    .G6_IN(G6_DATA_i),
    .G7_IN(G7_DATA_i),
    .G8_IN(G8_DATA_i),
    .G9_IN(G9_DATA_i),

    // B Channel in
    .B1_IN(B1_DATA_i),
    .B2_IN(B2_DATA_i),
    .B3_IN(B3_DATA_i),
    .B4_IN(B4_DATA_i),
    .B5_IN(B5_DATA_i),
    .B6_IN(B6_DATA_i),
    .B7_IN(B7_DATA_i),
    .B8_IN(B8_DATA_i),
    .B9_IN(B9_DATA_i),

    // output class
    .Class_result(class_w)
);

// NN (check)
NN #(
    .NN_IN_BIT        (`NN_IN_BIT      ),
    .NN_IN_CLASS_BIT  (`NN_IN_CLASS_BIT),
    .NN_OUT_BIT       (`NN_OUT_BIT     ),
    .NN_BIAS_BIT      (`NN_BIAS_BIT    ),
    .NN_KERNEL_BIT    (`NN_KERNEL_BIT  )
) u_NN (
    // clk
    .clk(clk),

    // active low rst
    .rst_n(rst_n),

    // Class in
    .class_i(class_w),

    // R Channel
    .NN_R1_i(R1_LIT_w),
    .NN_R2_i(R2_LIT_w),
    .NN_R3_i(R3_LIT_w),
    .NN_R4_i(R4_LIT_w),
    .NN_R5_i(R5_LIT_w),
    .NN_R6_i(R6_LIT_w),
    .NN_R7_i(R7_LIT_w),
    .NN_R8_i(R8_LIT_w),
    .NN_R9_i(R9_LIT_w),

    // G Channel
    .NN_G1_i(G1_LIT_w),
    .NN_G2_i(G2_LIT_w),
    .NN_G3_i(G3_LIT_w),
    .NN_G4_i(G4_LIT_w),
    .NN_G5_i(G5_LIT_w),
    .NN_G6_i(G6_LIT_w),
    .NN_G7_i(G7_LIT_w),
    .NN_G8_i(G8_LIT_w),
    .NN_G9_i(G9_LIT_w),

    // B Channel
    .NN_B1_i(B1_LIT_w),
    .NN_B2_i(B2_LIT_w),
    .NN_B3_i(B3_LIT_w),
    .NN_B4_i(B4_LIT_w),
    .NN_B5_i(B5_LIT_w),
    .NN_B6_i(B6_LIT_w),
    .NN_B7_i(B7_LIT_w),
    .NN_B8_i(B8_LIT_w),
    .NN_B9_i(B9_LIT_w),

    // output 
    .NN_onepxl_R_o(one_pxl_R_o),
    .NN_onepxl_G_o(one_pxl_G_o),
    .NN_onepxl_B_o(one_pxl_B_o)
);


endmodule
