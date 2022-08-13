module VC_Controller(input [7:0]InsPart,SR2,input [1:0]TR,input Start,IFR,SNReady,VMReady,Clk,Rst,output reg Ready,HalfReady,SNStart,VMStart,LdSR,LdSNVR,SN);
  parameter [3:0]Idle=4'h0,Init=4'h1,RunModules=4'h2,GetValue1=4'h3,GetValue2=4'h4,WaitForReady1=4'h5,LoadSNVR=4'h6,GetName1=4'h7,GetName2=4'h8,GetName3=4'h9;
  parameter [3:0]WaitForReady2=4'hA,abc=4'hB;
  reg [3:0]ps,ns;
  always @(ps,InsPart,SR2,TR,Start,IFR,SNReady,VMReady) begin
    begin ns=Idle;{Ready,HalfReady,SNStart,VMStart,LdSR,LdSNVR,SN}=7'h0; end
    case(ps)
      Idle:begin ns=Start?Init:Idle;Ready=1; end
      Init:begin ns=Start?Init:RunModules; end
      RunModules:begin ns=IFR?GetValue1:GetName2;LdSR=1;SNStart=IFR?1:0;VMStart=IFR?0:1; end
      GetValue1:begin ns=GetValue2;LdSR=1; end
      GetValue2:begin ns=(SR2==8'h0)?WaitForReady1:GetValue2;LdSR=1; end
      WaitForReady1:begin ns=SNReady?LoadSNVR:WaitForReady1; end
      abc:begin ns=LoadSNVR; end
      LoadSNVR:begin ns=GetName1;VMStart=1;LdSNVR=1;HalfReady=1; end
      GetName1:begin ns=(InsPart==8'h0)?WaitForReady2:GetName1; end
      GetName2:begin ns=GetName3;LdSR=1; end
      GetName3:begin ns=(SR2==8'h0)?WaitForReady2:GetName3;SN=1;LdSR=1; end
      WaitForReady2:begin ns=VMReady?Idle:WaitForReady2; end
      default:begin ns=Idle;{Ready,HalfReady,SNStart,VMStart,LdSR,LdSNVR,SN}=7'h0; end
    endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule