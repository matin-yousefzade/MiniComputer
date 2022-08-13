module Compiler_Controller(input [3:0]IPP,input Start,VMReady,IOACReady,OCReady,IOACGiveIns,OCGiveIns,Clk,Rst,output reg [3:0]ps,output reg [1:0]WIM,output reg Ready,LdSR,VMStart,IOACStart,OCStart,CLNO,SCPUIns);
  parameter [3:0]Idle=4'h0,Init=4'h1,VMStarting=4'h2,VMCompile=4'h3,IOACStarting=4'h4,IOACCompile=4'h5,WriteIns1=4'h6,OCStarting=4'h7,OCCompile=4'h8,WriteIns2=4'h9;
  reg [3:0]ns;
  always @(ps,IPP,Start,VMReady,IOACReady,OCReady,IOACGiveIns,OCGiveIns) begin
    begin ns=Idle;{WIM,Ready,LdSR,VMStart,IOACStart,OCStart,CLNO,SCPUIns}=9'h0; end
    case(ps)
      Idle:begin ns=Start?Init:Idle;Ready=1; end
      Init:begin ns=(Start==0 & IPP==4'h0)?VMStarting:(Start==0 & IPP==4'h1)?OCStarting:(Start==0 & 4'h2<=IPP)?IOACStarting:Init; end
      VMStarting:begin ns=VMCompile;LdSR=1;VMStart=1; end
      VMCompile:begin ns=VMReady?Idle:VMCompile;LdSR=1; end
      IOACStarting:begin ns=IOACCompile;LdSR=1;IOACStart=1; end
      IOACCompile:begin ns=IOACGiveIns?WriteIns1:IOACCompile;LdSR=1;WIM=IOACGiveIns?2'h3:2'h0;CLNO=IOACGiveIns?1:0; end
      WriteIns1:begin ns=IOACGiveIns?WriteIns1:Idle;WIM=IOACGiveIns?2'h3:2'h0;CLNO=IOACGiveIns?1:0; end
      OCStarting:begin ns=OCCompile;OCStart=1; end
      OCCompile:begin ns=OCGiveIns?WriteIns2:OCCompile;WIM=OCGiveIns?2'h3:2'h0;CLNO=OCGiveIns?1:0;SCPUIns=1; end
      WriteIns2:begin ns=OCGiveIns?WriteIns2:Idle;WIM=OCGiveIns?2'h3:2'h0;CLNO=OCGiveIns?1:0;SCPUIns=1; end
      default:begin ns=Idle;{WIM,Ready,LdSR,VMStart,IOACStart,OCStart,CLNO,SCPUIns}=9'h0; end
    endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule