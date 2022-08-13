module Adder_32b(input [31:0]A,B,output [31:0]W);
  assign W=A+B;
endmodule


module Adder_9b(input [8:0]A,B,output [8:0]W);
  assign W=A+B;
endmodule