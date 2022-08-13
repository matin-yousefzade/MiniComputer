module Comparator_2(input [31:0]A,output reg nz);
  always @(A) begin
    nz=0;
    if(A!=32'h0) nz=1;
  end
endmodule


module Comparator_2_TB();
  reg [31:0]A;
  wire nz;
  Comparator_2 G1(A,nz);
  initial begin
    A=32'h8;
    #100
    A=32'h0;
    #100
    A=32'h5;
    #100
    $stop;
  end
endmodule