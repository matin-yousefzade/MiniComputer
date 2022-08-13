module ALU(input [31:0]A,B,input [4:0]s,output reg [31:0]W);
  reg [31:0]AA,BB,ABmlt,ABdiv;
  wire [31:0]absA,absB;
  abs G1(A,absA);
  abs G2(B,absB);
  always @(A,B,s) begin
    W=32'h0;
    AA=A;
    BB=B;
    ABmlt=absA*absB;
    ABdiv=absA/absB;
    case(s)
      5'h00:W=A+B;
      5'h01:W=A+B;
      5'h02:W=A-B;
      5'h03:W=A-B;
      5'h04:W=A*B;
      5'h05:W=A[31]^B[31]?(~ABmlt[31:0]+1):ABmlt[31:0];
      5'h06:W=A/B;
      5'h07:W=A[31]^B[31]?(~ABdiv[31:0]+1):ABdiv[31:0];
      5'h08:W=A&B;
      5'h09:W=A|B;
      5'h0A:W=A^B;
      5'h0B:W=~A;
      5'h0C:begin
        while(BB>0) begin AA=AA>>1;BB=BB-1;end
        W=AA;
        end
      5'h0D:begin
        while(BB>0) begin AA=AA<<1;BB=BB-1;end
        W=AA;
        end
      5'h0E:begin
        while(BB>0) begin AA={AA[0],AA[31:1]};BB=BB-1;end
        W=AA;
        end
      5'h0F:begin
        while(BB>0) begin AA={AA[30:0],AA[31]};BB=BB-1;end
        W=AA;
        end
      default:W=32'h0;
    endcase
  end
endmodule






module ALU_TB();
  reg [31:0]A,B=32'h0;
  reg [4:0]s=5'h0;
  wire [31:0]W;
  ALU G1(A,B,s,W);
  initial begin
    A=32'h10;
    B=32'h3;
    s=5'h0;
    #100
    s=5'h1;
    #100
    s=5'h2;
    #100
    s=5'h3;
    #100
    s=5'h4;
    #100
    s=5'h5;
    #100
    s=5'h6;
    #100
    s=5'h7;
    #100
    s=5'h8;
    #100
    s=5'h9;
    #100
    s=5'hA;
    #100
    s=5'hB;
    #100
    s=5'hC;
    #100
    s=5'hD;
    #100
    s=5'hE;
    #100
    s=5'hF;
    #100
    $stop;
  end
endmodule