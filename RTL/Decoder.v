module Decoder_3b(input [2:0]A,output reg [7:0]W);
  reg [2:0]AA;
  always @(A) begin
    W=8'h0;
    AA=A;
    W[AA]=1;
  end
endmodule









module Decoder_3b_TB();
  reg [2:0]A;
  wire [7:0]W;
  Decoder_3b G1(A,W);
  initial begin
  A=3'h0;
  #100
  A=3'h5;
  #100
  A=8'h7;
  #100
  $stop;
  end
endmodule