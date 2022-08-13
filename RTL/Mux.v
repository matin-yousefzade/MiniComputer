module Mux_3s_32b(input [31:0]A,B,C,D,E,F,G,H,input [2:0]s,output reg [31:0]W);
  always @(A,B,C,D,E,F,G,H,s) begin
    W=32'h0;
    case(s)
      3'h0:W=A;
      3'h1:W=B;
      3'h2:W=C;
      3'h3:W=D;
      3'h4:W=E;
      3'h5:W=F;
      3'h6:W=G;
      3'h7:W=H;
      default:W=32'h0;
    endcase
  end
endmodule
//**********************************************************************************************************************
module Mux_2s_32b(input [31:0]A,B,C,D,input [1:0]s,output reg [31:0]W);
  always @(A,B,C,D,s) begin
    W=32'h0;
    case(s)
      2'h0:W=A;
      2'h1:W=B;
      2'h2:W=C;
      2'h3:W=D;
      default:W=32'h0;
    endcase
  end
endmodule
//**********************************************************************************************************************
module Mux_2s_16b(input [15:0]A,B,C,D,input [1:0]s,output reg [15:0]W);
  always @(A,B,C,D,s) begin
    W=16'h0;
    case(s)
      2'h0:W=A;
      2'h1:W=B;
      2'h2:W=C;
      2'h3:W=D;
      default:W=16'h0;
    endcase
  end
endmodule
//**********************************************************************************************************************
module Mux_2s_8b(input [7:0]A,B,C,D,input [1:0]s,output reg [7:0]W);
  always @(A,B,C,D,s) begin
    W=8'h0;
    case(s)
      2'h0:W=A;
      2'h1:W=B;
      2'h2:W=C;
      2'h3:W=D;
      default:W=8'h0;
    endcase
  end
endmodule
//**********************************************************************************************************************
module Mux_2s_4b(input [3:0]A,B,C,D,input [1:0]s,output reg [3:0]W);
  always @(A,B,C,D,s) begin
    W=4'h0;
    case(s)
      2'h0:W=A;
      2'h1:W=B;
      2'h2:W=C;
      2'h3:W=D;
      default:W=4'h0;
    endcase
  end
endmodule
//**********************************************************************************************************************
module Mux_1s_32b(input [31:0]A,B,input s,output [31:0]W);
  assign W=s?B:A;
endmodule
//**********************************************************************************************************************
module Mux_1s_16b(input [15:0]A,B,input s,output [15:0]W);
  assign W=s?B:A;
endmodule
//**********************************************************************************************************************
module Mux_1s_8b(input [7:0]A,B,input s,output [7:0]W);
  assign W=s?B:A;
endmodule
//**********************************************************************************************************************
module Mux_1s_5b(input [4:0]A,B,input s,output [4:0]W);
  assign W=s?B:A;
endmodule
//**********************************************************************************************************************
module Mux_1s_3b(input [2:0]A,B,input s,output [2:0]W);
  assign W=s?B:A;
endmodule
//**********************************************************************************************************************
module Mux_1s_2b(input [1:0]A,B,input s,output [1:0]W);
  assign W=s?B:A;
endmodule