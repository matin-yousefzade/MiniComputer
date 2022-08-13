module EncoderMux_4s_8b(input [7:0]A,B,C,D,input [3:0]s,output reg [7:0]W);
  always @(A,B,C,D,s) begin
    W=8'h0;
    case(s)
      4'h1:W=A;
      4'h2:W=B;
      4'h4:W=C;
      4'h8:W=D;
      default:W=8'h0;
    endcase
  end
endmodule




module EncoderMux_4s_2b(input [1:0]A,B,C,D,input [3:0]s,output reg [1:0]W);
  always @(A,B,C,D,s) begin
    W=2'h0;
    case(s)
      4'h1:W=A;
      4'h2:W=B;
      4'h4:W=C;
      4'h8:W=D;
      default:W=2'h0;
    endcase
  end
endmodule