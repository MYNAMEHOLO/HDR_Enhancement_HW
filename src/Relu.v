//===================================================//
// Module created in 2023.12.29
// Creator: R.T. Lee
// Module name: Activation function relu RTL
//===================================================//


module Relu
#(
parameter N = `N
)
(
input signed [N-1 : 0] relu_i,
output [N-2 : 0] relu_o
);
assign relu_o = ( relu_i <= $signed(0))? 'd0 : relu_i;


endmodule
