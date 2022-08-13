module MC_Controller(input [7:0]Opcode,CIMWD,CIMRD,AIMRD,input [3:0]IPP,input Start,PAK,ETXF,XF,CReady,OCReady,VCHalfReady,VCReady,CPUReady,Clk,Rst,output reg [5:0]ps,output reg [3:0]ParIPP,output reg [1:0]ParTR,output reg Ready,InitCIMR,LdCIMR,InitETXF,LdETXF,InitXF,LdXF,ParIFR,LdIFR,LdTR,WCIM,RCIM,CCIM,InitCIM,ParLdCIM,WAIM,RAIM,CAIM,InitAIM,CIPP,InitIPP,ParLdIPP,CStart,OCStart,VCStart,CPUStart,AStart,InitAIM2);
  parameter [5:0]Idle=6'h0,Init1=6'h1,WriteText=6'h2,Init2=6'h3,Partition=6'h4,Init3=6'h5,ReadLabel=6'h6,WriteLabel=6'h7,Init10=6'h8,Init11=6'h9;
  parameter [5:0]ReadOpcode=6'hA,WriteOpcode=6'hB,Init12=6'hC,SendChar1=6'hD,WaitForReady1=6'hE,ExtraCount=6'hF,Init4=6'h10,ReadChar=6'h11,WriteChar=6'h12;
  parameter [5:0]CheckFC1=6'h13,CheckFC2=6'h14,SendChar2=6'h15,WaitForReady2=6'h16,Init6=6'h17,CheckFC3=6'h18,CheckFC4=6'h19,SendChar3=6'h1A,WaitForReady3=6'h1B;
  parameter [5:0]Init7=6'h1C,Init8=6'h1D,WaitForReady4=6'h1E,Init9=6'h1F,CheckFC5=6'h20,CheckFC6=6'h21,SendChar4=6'h22,WaitForReady5=6'h23,CPURun=6'h24;
  parameter [5:0]WaitForReady6=6'h25,Init5=6'h26,PreReading1=6'h27,PreReading2=6'h28,SelectPath=6'h29,WriteType=6'h2A,Init13=6'h2B;
  parameter [5:0]CheckFC7=6'h2C,CheckFC8=6'h2D,SendChar5=6'h2F,WaitForHalfReady=6'h30,Init14=6'h31,PreReading4=6'h32;
  parameter [5:0]SendChar6=6'h33,WaitForReady7=6'h34,VarCmpStart=6'h35;
  reg [5:0]ns;
  always @(ps,Opcode,CIMWD,CIMRD,AIMRD,IPP,Start,PAK,ETXF,XF,CReady,OCReady,VCHalfReady,VCReady,CPUReady) begin
    begin ns=Idle;{ParIPP,ParTR,Ready,InitCIMR,LdCIMR,InitETXF,LdETXF,InitXF,LdXF,ParIFR,LdIFR,LdTR,WCIM,RCIM,CCIM,InitCIM,ParLdCIM,WAIM,RAIM,CAIM,InitAIM,CIPP,InitIPP,ParLdIPP,CStart,OCStart,VCStart,CPUStart,AStart,InitAIM2}=34'h0; end
    case(ps)
      Idle:begin ns=Start?Init1:Idle;Ready=1; end
      Init1:begin ns=Start?Init1:WriteText;InitCIM=1;InitCIMR=1;AStart=1; end
      WriteText:begin ns=(CIMWD==8'h3)?Init2:WriteText;WCIM=PAK?1:0;CCIM=PAK?1:0; end
      Init2:begin ns=PreReading1;ParLdCIM=1;InitIPP=1;InitAIM2=1;InitETXF=1;InitXF=1; end
      PreReading1:begin ns=Partition;RCIM=1;CCIM=1; end
      Partition:begin ns=(CIMRD==8'h3 | CIMRD==8'hA |  CIMRD==8'h20)?Init10:(CIMRD==8'h3A)?Init3:Partition;RCIM=1;CCIM=1; end
      Init3:begin ns=ReadLabel;ParLdCIM=1;InitAIM=1; end
      Init10:begin ns=Init11;ParLdCIM=1;InitAIM=1; end
      ReadLabel:begin ns=WriteLabel;RCIM=1;CCIM=1; end
      WriteLabel:begin ns=(CIMRD==8'h3A)?Init11:ReadLabel;WAIM=(CIMRD!=8'h3A)?1:0;CAIM=1; end
      Init11:begin ns=ReadOpcode;InitAIM=1;CIPP=1; end
      ReadOpcode:begin ns=WriteOpcode;RCIM=1;CCIM=1; end
      WriteOpcode:begin ns=(CIMRD==8'h3 | CIMRD==8'hA | CIMRD==8'h20)?Init12:ReadOpcode;CAIM=1;WAIM=(CIMRD!=8'h3 & CIMRD!=8'hA & CIMRD!=8'h20)?1:0;LdXF=(CIMRD==8'h20)?1:0;LdETXF=(CIMRD==8'h3)?1:0;LdCIMR=(CIMRD==8'hA)?1:0; end
      Init12:begin ns=PreReading2;InitAIM=1;OCStart=1; end
      PreReading2:begin ns=SendChar1;RAIM=1;CAIM=1; end
      SendChar1:begin ns=(AIMRD==8'h0)?WaitForReady1:SendChar1;RAIM=1;CAIM=1; end
      WaitForReady1:begin ns=(OCReady==1 & XF==1)?ExtraCount:(OCReady==1 & XF==0)?SelectPath:WaitForReady1; end
      ExtraCount:begin ns=Init4;CIPP=((8'h40<=Opcode & Opcode<=8'h49) | Opcode==8'h82 | Opcode==8'h83 | Opcode==8'h84)?1:0; end
      Init4: begin ns=ReadChar;InitAIM=1;CIPP=1; end
      ReadChar: begin ns=WriteChar;RCIM=1;CCIM=1; end
      WriteChar: begin ns=(CIMRD==8'h3 | CIMRD==8'hA)?SelectPath:(CIMRD==8'h20)?Init4:ReadChar;CAIM=1;WAIM=(CIMRD!=8'h3 & CIMRD!=8'hA & CIMRD!=8'h20)?1:0;LdETXF=(CIMRD==8'h3)?1:0;LdCIMR=(CIMRD==8'hA)?1:0; end
      SelectPath:begin ns=(Opcode==8'h82 | Opcode==8'h83 | Opcode==8'h84)?WriteType:Init5; end
      //*********************************************************************************************
      //*********************************************************************************************
      //FirstPath
      Init5:begin ns=CheckFC1;InitIPP=1;InitAIM=1; end
      CheckFC1: begin ns=CheckFC2;RAIM=1; end
      CheckFC2: begin ns=(AIMRD!=8'h0)?SendChar2:Init6;CStart=(AIMRD!=8'h0)?1:0; end
      SendChar2: begin ns=(AIMRD==8'h0)?WaitForReady2:SendChar2;RAIM=1;CAIM=1; end
      WaitForReady2: begin ns=CReady?Init6:WaitForReady2; end
      Init6: begin ns=CheckFC3;ParIPP=4'h3;ParLdIPP=1;InitAIM=1; end
      CheckFC3: begin ns=CheckFC4;RAIM=1; end
      CheckFC4: begin ns=(AIMRD!=8'h0)?SendChar3:Init8;CStart=(AIMRD!=8'h0)?1:0; end
      SendChar3: begin ns=(AIMRD==8'h0)?WaitForReady3:SendChar3;RAIM=1;CAIM=1; end
      WaitForReady3: begin ns=CReady?Init7:WaitForReady3; end
      Init7: begin ns=(IPP==4'hF)?Init8:CheckFC3;CIPP=1;InitAIM=1; end
      Init8: begin ns=WaitForReady4;ParIPP=4'h1;ParLdIPP=1;CStart=1; end
      WaitForReady4: begin ns=CReady?Init9:WaitForReady4; end
      Init9: begin ns=CheckFC5;CIPP=1;InitAIM=1; end
      CheckFC5: begin ns=CheckFC6;RAIM=1; end
      CheckFC6: begin ns=(AIMRD==8'h0 & ETXF==0)?Init2:(AIMRD==8'h0 & ETXF==1)?CPURun:SendChar4;CStart=(AIMRD!=8'h0)?1:0; end
      SendChar4: begin ns=(AIMRD==8'h0)?WaitForReady5:SendChar4;RAIM=1;CAIM=1; end
      WaitForReady5: begin ns=(CReady==1 & ETXF==0)?Init2:(CReady==1 & ETXF==1)?CPURun:WaitForReady5; end
      //*********************************************************************************************
      //*********************************************************************************************
      //SecondPath
      WriteType: begin ns=Init13;ParTR=(Opcode==8'h82)?2'h1:(Opcode==8'h83)?2'h2:(Opcode==8'h84)?2'h3:2'h0;LdTR=1; end
      Init13: begin ns=CheckFC7;ParIPP=4'h4;ParLdIPP=1;InitAIM=1; end
      CheckFC7: begin ns=CheckFC8;RAIM=1; end
      CheckFC8: begin ns=(AIMRD!=8'h0)?VarCmpStart:Init14;ParIFR=(AIMRD!=8'h0)?1:0;LdIFR=1; end
      VarCmpStart:begin ns=SendChar5;VCStart=1; end
      SendChar5: begin ns=(AIMRD==8'h0)?WaitForHalfReady:SendChar5;RAIM=1;CAIM=1; end
      WaitForHalfReady: begin ns=VCHalfReady?PreReading4:WaitForHalfReady;ParIPP=4'h3;ParLdIPP=VCHalfReady?1:0;InitAIM=VCHalfReady?1:0; end
      Init14: begin ns=PreReading4;ParIPP=4'h3;ParLdIPP=1;InitAIM=1;VCStart=1; end
      PreReading4: begin ns=SendChar6;RAIM=1;CAIM=1; end
      SendChar6: begin ns=(AIMRD==8'h0)?WaitForReady7:SendChar6;RAIM=1;CAIM=1; end
      WaitForReady7: begin ns=(VCReady==1 & ETXF==0)?Init2:(VCReady==1 & ETXF==1)?CPURun:WaitForReady7; end
      //*********************************************************************************************
      //*********************************************************************************************
      //*********************************************************************************************
      CPURun: begin ns=WaitForReady6;CPUStart=1; end
      WaitForReady6: begin ns=CPUReady?Idle:WaitForReady6; end
      default:begin ns=Idle;{ParIPP,ParTR,Ready,InitCIMR,LdCIMR,InitETXF,LdETXF,InitXF,LdXF,ParIFR,LdIFR,LdTR,WCIM,RCIM,CCIM,InitCIM,ParLdCIM,WAIM,RAIM,CAIM,InitAIM,CIPP,InitIPP,ParLdIPP,CStart,OCStart,VCStart,CPUStart,AStart,InitAIM2}=34'h0; end
    endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule