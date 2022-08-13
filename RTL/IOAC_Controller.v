module IOAC_Controller(input [7:0]InsPart,Opcode,input [7:0]FC,input [3:0]IPP,input Start,SNReady,VMReady,Clk,Rst,output reg [2:0]SMode,output reg [1:0]SIns,output reg Ready,SNStart,VMStart,LdFC,LdSC,LdIns,LdSR,GiveIns);
 parameter [3:0]Idle=4'h0,Init=4'h1,LoadFC=4'h2,LoadSC=4'h3,LoadTC=4'h4,Compile=4'h5,LoadIns=4'h6,GiveIns1=4'h7,GiveIns2=4'h8,GiveIns3=4'h9;
 reg [3:0]ps,ns;
 always @(ps,FC,Start,SNReady,VMReady) begin
   begin ns=Idle;{SIns,Ready,SNStart,VMStart,LdFC,LdSC,LdIns,LdSR,SMode,GiveIns}=11'h0; end
   case(ps)
     Idle:begin ns=Start?Init:Idle;Ready=1; end
     Init:begin ns=Start?Init:LoadFC; end
     LoadFC:begin ns=LoadSC;LdFC=1;LdSR=1; end
     LoadSC:begin ns=LoadTC;LdSC=(FC==8'h4D)?1:0;SNStart=(FC==8'h52 | FC==8'h49)?1:0;VMStart=(FC==8'h56 | FC==8'h4C)?1:0;LdSR=1; end
     LoadTC:begin ns=Compile;SNStart=(FC==8'h4D)?1:0;LdSR=1; end
     Compile:begin ns=(((FC==8'h52 | FC==8'h4D | FC==8'h49) & SNReady==1) | ((FC==8'h56 | FC==8'h4C) & VMReady==1))?LoadIns:Compile;LdSR=1; end
     LoadIns:begin ns=GiveIns1;SMode=(IPP>=4'h3 & FC==8'h52)?3'h0:(IPP>=4'h3 & FC==8'h4D)?3'h1:(IPP>=4'h3 & FC==8'h49)?3'h2:(IPP>=4'h3 & (FC==8'h56 | FC==8'h4C))?3'h3:(IPP==4'h2 & FC==8'h52)?3'h4:(IPP==4'h2 & FC==8'h4D)?3'h5:(IPP==4'h2 & (FC==8'h56 | FC==8'h4C))?3'h6:3'h7;LdIns=1; end
     GiveIns1:begin ns=GiveIns2;SIns=2'h0;GiveIns=((IPP>=4'h3 & (FC==8'h52 | FC==8'h4D | FC==8'h49 | FC==8'h56 | FC==8'h4C)) | (IPP==4'h2 & (FC==8'h52 | FC==8'h4D | FC==8'h56 | FC==8'h4C)))?1:0; end
     GiveIns2:begin ns=GiveIns3;SIns=2'h1;GiveIns=((IPP>=4'h3 & (FC==8'h4D | FC==8'h49 | FC==8'h56 | FC==8'h4C)) | (IPP==4'h2 & (FC==8'h4D | FC==8'h56 | FC==8'h4C)))?1:0; end
     GiveIns3:begin ns=Idle;SIns=2'h2;GiveIns=((IPP>=4'h3 & (FC==8'h4D)) | (IPP>=4'h3 & (FC==8'h56 | FC==8'h4C) & Opcode!=8'h18 & Opcode!=8'h19) | (IPP==3'h2 & (FC==8'h4D | FC==8'h56 | FC==8'h4C)))?1:0; end
     default:begin ns=Idle;{SIns,Ready,SNStart,VMStart,LdFC,LdSC,LdIns,LdSR,SMode,GiveIns}=11'h0; end
   endcase
 end
 always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule