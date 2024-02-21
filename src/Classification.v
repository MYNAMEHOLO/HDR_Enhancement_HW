module Classification#(
parameter Class_in_bit = `Class_in_bit ,
parameter Class_result_bit = `Class_result_bit
)
(
input clk,
input rst_n,
// Red Part
input [Class_in_bit -1 : 0] R1_IN,
input [Class_in_bit -1 : 0] R2_IN,
input [Class_in_bit -1 : 0] R3_IN,
input [Class_in_bit -1 : 0] R4_IN,
input [Class_in_bit -1 : 0] R5_IN,
input [Class_in_bit -1 : 0] R6_IN,
input [Class_in_bit -1 : 0] R7_IN,
input [Class_in_bit -1 : 0] R8_IN,
input [Class_in_bit -1 : 0] R9_IN,

// Green Part
input [Class_in_bit -1 : 0] G1_IN,
input [Class_in_bit -1 : 0] G2_IN,
input [Class_in_bit -1 : 0] G3_IN,
input [Class_in_bit -1 : 0] G4_IN,
input [Class_in_bit -1 : 0] G5_IN,
input [Class_in_bit -1 : 0] G6_IN,
input [Class_in_bit -1 : 0] G7_IN,
input [Class_in_bit -1 : 0] G8_IN,
input [Class_in_bit -1 : 0] G9_IN,

// Blue Part
input [Class_in_bit -1 : 0] B1_IN,
input [Class_in_bit -1 : 0] B2_IN,
input [Class_in_bit -1 : 0] B3_IN,
input [Class_in_bit -1 : 0] B4_IN,
input [Class_in_bit -1 : 0] B5_IN,
input [Class_in_bit -1 : 0] B6_IN,
input [Class_in_bit -1 : 0] B7_IN,
input [Class_in_bit -1 : 0] B8_IN,
input [Class_in_bit -1 : 0] B9_IN,

// output
output reg [Class_result_bit - 1 : 0 ] Class_result
);

// constant 2.15625
parameter [10:0] const_2_15625 = 11'b010_00101000;
// comb. logic here
reg [Class_result_bit - 1 : 0 ] Class_result_w;

////////////////////////////////
wire signed[10:0] R147_SUM , R369_SUM,
                  G147_SUM , G369_SUM,
                  B147_SUM , B369_SUM,
                  R123_SUM , R789_SUM,
                  G123_SUM , G789_SUM,
                  B123_SUM , B789_SUM;

          
wire  signed  [10:0] gh,gv,gx,gy;
wire  signed  [10:0] gr_h,gg_h,gb_h;
wire  signed  [10:0] gr_v,gg_v,gb_v;
wire  signed  [10:0] gr_x,gg_x,gb_x;
wire  signed  [10:0] gr_y,gg_y,gb_y;

wire  [9:0] abs_gh,abs_gv;

wire  [9:0] abs_gx,abs_gy;
wire  [10:0] mp;

wire  p_or_n_y;

assign R147_SUM = R1_IN + R4_IN + R7_IN;
assign R369_SUM = R3_IN + R6_IN + R9_IN; 

assign G147_SUM = G1_IN + G4_IN + G7_IN;
assign G369_SUM = G3_IN + G6_IN + G9_IN;

assign B147_SUM = B1_IN + B4_IN + B7_IN;
assign B369_SUM = B3_IN + B6_IN + B9_IN;

assign R123_SUM = R1_IN + R2_IN + R3_IN;
assign R789_SUM = R7_IN + R8_IN + R9_IN;

assign G123_SUM = G1_IN + G2_IN + G3_IN;
assign G789_SUM = G7_IN + G8_IN + G9_IN;

assign B123_SUM = B1_IN + B2_IN + B3_IN;
assign B789_SUM = B7_IN + B8_IN + B9_IN;

//gh
assign gr_h = R147_SUM - R369_SUM ;
assign gg_h = G147_SUM - G369_SUM ;
assign gb_h = B147_SUM - B369_SUM ;
assign gh = gr_h + gg_h + gb_h;
assign abs_gh = gh[10] ? ((~gh[9:0]) + 1'd1) : gh ;

//gv

assign gr_v = R123_SUM - R789_SUM ;
assign gg_v = G123_SUM - G789_SUM ;
assign gb_v = B123_SUM - B789_SUM ;
assign gv = gr_v + gg_v + gb_v;
assign abs_gv = gv[10] ? ((~gv[9:0]) + 1'd1) : gv ;


assign mp = abs_gh + abs_gv ;


///////////////////////////////////
assign gr_x =  R4_IN - R6_IN;
assign gg_x =  G4_IN - G6_IN;
assign gb_x =  B4_IN - B6_IN;


assign gr_y =  R2_IN - R8_IN;
assign gg_y =  G2_IN - G8_IN; 
assign gb_y =  B2_IN - B8_IN;

assign gx = gr_x + gb_x + gg_x;
assign gy = gr_y + gb_y + gg_y;

assign abs_gx = gx[10] ? ((~gx[9:0])+'d1) : gx ;
assign abs_gy = gy[10] ? ((~gy[9:0])+'d1) : gy ;

assign p_or_n_y = gy[10]? 1'd1:1'd0 ;
//Processing and writing to TFRecord
always @(*) begin
  if (mp < const_2_15625) Class_result_w = 3'd0;
  else if( (p_or_n_y == 'b0)  && (abs_gy >= abs_gx) ) Class_result_w = 3'd1;
  else if( (p_or_n_y == 'b0)  && (abs_gy <  abs_gx) ) Class_result_w = 3'd2;
  // (p_or_n_y == 'b1) && (  abs_gy >= abs_gx )
  else if(  abs_gy >= abs_gx ) Class_result_w = 3'd3;
  // (p_or_n_y == 1)  && (abs_gy < abs_gx) )  
  else Class_result_w = 3'd4;
end


// seq logic here
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) Class_result <= 'd0;
    else Class_result <= Class_result_w;
end




endmodule
