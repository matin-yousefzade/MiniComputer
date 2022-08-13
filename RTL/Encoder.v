module Encoder_8b(input [255:0]A,output reg [7:0]W);
  integer i;
  always @(A) begin
    W=8'h0;
    i=0;
    while(A[i]==0) i=i+1;
    W=i;
  end
endmodule









module Encoder_8b_TB();
  reg [255:0]A;
  wire [7:0]W;
  Encoder_8b G1(A,W);
  initial begin
  A=256'h1;
  #100
  A=256'h40;
  #100
  A=256'h200;
  #100
  A=256'h0;
  #100
  $stop;
  end
endmodule



//*************************************************************************************************************


module Encoder_3b(input [7:0]A,output reg [2:0]W);
  integer i;
  always @(A) begin
    W=3'hz;
    i=0;
    while(A[i]==0) i=i+1;
    W=i;
  end
endmodule









module Encoder_3b_TB();
  reg [7:0]A;
  wire [2:0]W;
  Encoder_3b G1(A,W);
  initial begin
  A=8'h1;
  #100
  A=8'h2;
  #100
  A=8'h10;
  #100
  A=8'h0;
  #100
  $stop;
  end
endmodule