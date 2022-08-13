module VM_Controller(input [31:0]MemRead,input [7:0]Name,NameRead,input [1:0]Mode,Type,NowType,input Start,InitFlag,grt,Clk,Rst,output reg [2:0]SMW,output reg [1:0]WDM,RDM,CMA,output reg Ready,WNM,RNM,LdIV,LdOV,LdOA,LdOT,LdNT,CNA,InitN,InitNA,InitMA,LdM,LdT,LdIF,req,cs);
  reg [5:0]ps,ns;
  parameter [5:0]Idle=6'h0,Init=6'h1,GetName=6'h2,GetValue=6'h3,RequestMemory=6'h4,ReadMemory1=6'h5,LoadNowType1=6'h6;
  parameter [5:0]ReadMemory2=6'h8,TypeCompare=6'h9,FalseType=6'hA,ReadMemory3=6'hB,LoadNowType2=6'hC,AgainInit1=6'hD,ReadNameReadMemory=6'hE;
  parameter [5:0]NameCompare=6'hF,NewWriteOrRead=6'h10,WriteNewValue=6'h11,ReadMemory6=6'h12,LoadValueLoadAddrLoadType=6'h13;
  parameter [5:0]ReadMemory4=6'h15,FindNull=6'h16,FalseNull=6'h17,ReadMemory5=6'h18,LoadNowType3=6'h19,WriteType=6'h1A,AgainInit2=6'h1B;
  parameter [5:0]ReadName=6'h1C,WriteName=6'h1D,WriteSpace=6'h1E,WriteValueLoadAddr=5'h1F,GapForValueLoadAddr=6'h20,WriteNull1=6'h21;
  parameter [5:0]WriteNull2=6'h22;
  always @(ps,MemRead,Name,NameRead,Mode,Type,NowType,Start,InitFlag,grt) begin
    begin ns=Idle;{SMW,WDM,RDM,CMA,Ready,WNM,RNM,LdIV,LdOV,LdOA,LdNT,CNA,InitN,InitNA,InitMA,LdM,LdT,LdIF,req,cs}=24'h0; end
      case(ps)
        Idle:begin ns=Start?Init:Idle;Ready=1; end
        Init:begin ns=Start?Init:GetName;InitN=1;InitNA=1;InitMA=1; end
        GetName:begin ns=(Name==8'h0)?GetValue:GetName;WNM=1;CNA=1; end
        GetValue:begin ns=RequestMemory;LdIV=1;LdM=1;LdT=1;LdIF=1; end
        RequestMemory:begin ns=grt?ReadMemory1:RequestMemory;req=1; end
        ReadMemory1:begin ns=LoadNowType1;RDM=2'h1;req=1;cs=1; end
        LoadNowType1:begin ns=(Mode==2'h3)?ReadMemory4:ReadMemory2;LdNT=1;req=1;cs=1; end
        //****************************************************************************************************************************************
        ReadMemory2:begin ns=TypeCompare;RDM=2'h1;req=1;cs=1; end
        TypeCompare:begin ns=(8'h1<=MemRead[7:0] & MemRead[7:0]<=8'h3)?AgainInit1:(MemRead[7:0]==8'h20)?FalseType:ReadMemory2;CMA=2'h1;req=1;cs=1; end
        FalseType:begin ns=ReadMemory3;CMA=(NowType==2'h2)?2'h2:2'h3;req=1;cs=1; end
        ReadMemory3:begin ns=LoadNowType2;RDM=2'h1;req=1;cs=1; end
        LoadNowType2:begin ns=ReadMemory2;LdNT=1;req=1;cs=1; end
        AgainInit1:begin ns=ReadNameReadMemory;InitNA=1;req=1;cs=1; end
        ReadNameReadMemory:begin ns=NameCompare;RDM=2'h1;RNM=1;req=1;cs=1; end
        NameCompare:begin ns=(NameRead==8'h0 & MemRead[7:0]==8'h20)?NewWriteOrRead:(MemRead[7:0]==NameRead & NameRead!=8'h0 & MemRead[7:0]!=8'h20)?ReadNameReadMemory:ReadMemory2;CMA=2'h1;CNA=1;req=1;cs=1; end
        NewWriteOrRead:begin ns=(Mode==2'h1)?WriteNewValue:(Mode==2'h2)?ReadMemory6:Idle; end
        WriteNewValue:begin ns=Idle;SMW=3'h1;WDM=(NowType==2'h2)?2'h1:2'h3;req=1;cs=1; end
        ReadMemory6:begin ns=LoadValueLoadAddrLoadType;RDM=(NowType==2'h2)?2'h1:2'h3;req=1;cs=1; end
        LoadValueLoadAddrLoadType:begin ns=Idle;LdOV=1;LdOA=1;LdOT=1;req=1;cs=1; end
        //******************************************************************************************************************************************************************************************************
        ReadMemory4:begin ns=FindNull;RDM=2'h1;req=1;cs=1; end
        FindNull:begin ns=(MemRead[7:0]==8'h0)?WriteType:(MemRead[7:0]==8'h20)?FalseNull:ReadMemory4;CMA=(MemRead[7:0]==8'h0)?2'h0:2'h1;req=1;cs=1; end
        FalseNull:begin ns=ReadMemory5;CMA=(NowType==2'h2)?2'h2:2'h3;req=1;cs=1; end
        ReadMemory5:begin ns=LoadNowType3;RDM=2'h1;req=1;cs=1; end
        LoadNowType3:begin ns=ReadMemory4;LdNT=1;req=1;cs=1; end
        WriteType:begin ns=AgainInit2;SMW=3'h4;WDM=2'h1;CMA=2'h1;req=1;cs=1; end
        AgainInit2:begin ns=ReadName;InitNA=1;SMW=3'h4;req=1;cs=1; end
        ReadName:begin ns=WriteName;RNM=1;SMW=3'h4;req=1;cs=1; end
        WriteName:begin ns=(NameRead==8'h0)?WriteSpace:ReadName;WDM=(NameRead==8'h0)?2'h0:2'h1;CMA=(NameRead==8'h0)?2'h0:2'h1;CNA=1;req=1;cs=1; end
        WriteSpace:begin ns=InitFlag?WriteValueLoadAddr:GapForValueLoadAddr;SMW=3'h2;WDM=2'h1;CMA=2'h1;req=1;cs=1; end
        WriteValueLoadAddr:begin ns=WriteNull1;SMW=3'h1;WDM=(Type==2'h2)?2'h1:2'h3;CMA=(Type==2'h2)?2'h2:2'h3;LdOA=1;req=1;cs=1; end
        GapForValueLoadAddr:begin ns=WriteNull1;CMA=(Type==2'h2)?2'h2:2'h3;LdOA=1;req=1;cs=1; end
        WriteNull1:begin ns=WriteNull2;SMW=3'h3;WDM=2'h1;CMA=2'h1;req=1;cs=1; end
        WriteNull2:begin ns=Idle;SMW=3'h3;WDM=2'h1;req=1;cs=1; end
        default:begin ns=Idle;{SMW,WDM,RDM,CMA,Ready,WNM,RNM,LdIV,LdOV,LdOA,LdNT,CNA,InitN,InitNA,InitMA,LdM,LdT,LdIF,req,cs}=24'h0; end
      endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
 end
endmodule