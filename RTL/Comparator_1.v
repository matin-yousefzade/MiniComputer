module Comparator_1(input [31:0]A,B,output reg eq,ne,gt,ge,lt,le);
  always @(A,B) begin
    begin eq=0;ne=0;gt=0;ge=0;lt=0;le=0; end
    if(A>B) begin ne=1;gt=1;ge=1; end
    else if(A==B) begin eq=1;ge=1;le=1; end
    else if(A<B) begin ne=1;lt=1;le=1; end
  end
endmodule


module Comparator_1_TB();
  reg [31:0]A,B=32'h0;
  wire eq,ne,gt,ge,lt,le;
  Comparator_1 G1(A,B,eq,ne,gt,ge,lt,le);
  initial begin
    A=32'h8;
    B=32'h3;
    #100
    A=32'h6;
    B=32'h6;
    #100
    A=32'h5;
    B=32'hA;
    #100
    $stop;
  end
endmodule