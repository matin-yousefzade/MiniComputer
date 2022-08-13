module OC_Controller(input [7:0]Name,NMRD,OMRD,input Start,Clk,Rst,output reg Ready,InitNM,InitNMA,InitTens,InitUnity,CNMA,CTens,CUnity,WNM,RNM,ROM,LdOpcode);
  parameter [2:0]Idle=3'h0,Init1=3'h1,GetName=3'h2,Init2=3'h3,ReadChar=3'h4,Compare=3'h5,CountTens=3'h6,WriteOpcode=3'h7;
  reg [2:0]ps,ns;
  always @(ps,Start,Name,NMRD,OMRD) begin
    begin ns=Idle;{Ready,InitNM,InitNMA,InitTens,InitUnity,CNMA,CTens,CUnity,WNM,RNM,ROM,LdOpcode}=12'h0; end
    case(ps)
      Idle:begin ns=Start?Init1:Idle;Ready=1; end
      Init1:begin ns=Start?Init1:GetName;InitNM=1;InitNMA=1;InitTens=1; end
      GetName:begin ns=(Name==8'h0)?Init2:GetName;WNM=1;CNMA=1; end
      Init2:begin ns=ReadChar;InitNMA=1;InitUnity=1; end
      ReadChar:begin ns=Compare;RNM=1;ROM=1;CNMA=1;CUnity=1; end
      Compare:begin ns=(NMRD==OMRD & NMRD==8'h0)?WriteOpcode:(NMRD==OMRD & NMRD!=8'h0)?ReadChar:CountTens; end
      CountTens:begin ns=Init2;CTens=1; end
      WriteOpcode:begin ns=Idle;LdOpcode=1; end
      default:begin ns=Idle;{Ready,InitNM,InitNMA,InitTens,InitUnity,CNMA,CTens,CUnity,WNM,RNM,ROM,LdOpcode}=12'h0; end
    endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule