module CPU_Controller_1(input [5:0]Opcode,input Start,grt,Clk,Rst,output reg [4:0]ps,output reg [1:0]WDM,RDM,RIM,output reg Ready,LdIR,CPC,LdA,LdB,LdALU,WRF,LdMDR,SWA,sssb,IFF,req,cs);
  reg [4:0]ns;
  parameter [4:0]Idle=5'h0,Init=5'h1,IF1=5'h2,IF2=5'h3,IF3=5'h4,ALU1=5'h5,ALU2=5'h6,ALU3=5'h7,Store1=5'h8,Store2=5'h9,Store3=5'hA;
  parameter [4:0]Load1=5'hB,Load2=5'hC,Load3=5'hD,Load4=5'hE,Load5=5'hF,set1=5'h10,set2=5'h11,bnz1=5'h12,bnz2=5'h13,jmp1=5'h14,jmp2=5'h15,jr1=5'h16;
  parameter [4:0]jr2=5'h17,jal1=5'h18,jal2=5'h19,LI1=5'h1A,LI2=5'h1B;
  always @(ps,Start,grt) begin
    begin ns=Idle;{WDM,RDM,RIM,Ready,LdIR,CPC,LdA,LdB,LdALU,WRF,LdMDR,SWA,sssb,IFF,req,cs}=19'h0; end
    case(ps)
      Idle:begin ns=Start?Init:Idle;Ready=1; end
      Init:ns=Start?Init:IF1;
      IF1:begin ns=IF2;RIM=2'h3; end
      IF2:begin ns=IF3;LdIR=1;CPC=1;IFF=1; end
      IF3:ns=(Opcode==6'h0)?IF1:(6'h0<Opcode & Opcode<6'h1C)?ALU1:(6'h1B<Opcode & Opcode<6'h1F)?Store1:(6'h1E<Opcode & Opcode<6'h22)?Load1:(6'h21<Opcode & Opcode<6'h28)?set1:(Opcode==6'h28)?bnz1:(Opcode==6'h29)?jmp1:(Opcode==6'h2A)?jr1:(Opcode==6'h2B)?jal1:(6'h2B<Opcode & Opcode<6'h2E)?LI1:(Opcode==6'h3F)?Idle:IF3;
      //*****************************************************************************************
      ALU1:begin ns=ALU2;LdA=1;LdB=1; end
      ALU2:begin ns=ALU3;LdALU=1; end
      ALU3:begin ns=IF1;WRF=1; end
      //*****************************************************************************************
      Store1:begin ns=grt?Store2:Store1;req=1; end
      Store2:begin ns=Store3;LdA=1;LdB=1;sssb=1;req=1;cs=1; end
      Store3:begin ns=IF1;WDM=(Opcode==6'h1C)?2'h1:(Opcode==6'h1D)?2'h2:(Opcode==6'h1E)?2'h3:2'h0;req=1;cs=1; end
      Load1:begin ns=grt?Load2:Load1;req=1; end
      Load2:begin ns=Load3;LdB=1;sssb=1;req=1;cs=1; end
      Load3:begin ns=Load4;RDM=(Opcode==6'h1F)?2'h1:(Opcode==6'h20)?2'h2:(Opcode==6'h21)?2'h3:2'h0;req=1;cs=1; end
      Load4:begin ns=Load5;LdMDR=1;cs=1; end
      Load5:begin ns=IF1;WRF=1; end
      //******************************************************************************************
      set1:begin ns=set2;LdA=1;LdB=1; end
      set2:begin ns=IF1;WRF=1; end
      //*******************************************************************************************
      bnz1:begin ns=bnz2;LdA=1;LdB=1;sssb=1; end
      bnz2:begin ns=IF1;CPC=1; end
      //*******************************************************************************************
      jmp1:begin ns=jmp2;LdB=1;sssb=1; end
      jmp2:begin ns=IF1;CPC=1; end
      jr1:begin ns=jr2;LdA=1;sssb=1; end
      jr2:begin ns=IF1;CPC=1; end
      jal1:begin ns=jal2;SWA=1;WRF=1;LdB=1;sssb=1; end
      jal2:begin ns=IF1;CPC=1; end
      //*******************************************************************************************
      LI1:begin ns=LI2;sssb=1;LdA=1; end
      LI2:begin ns=IF1;WRF=1; end
      //*******************************************************************************************
      default:begin ns=Idle;{WDM,RDM,RIM,Ready,LdIR,CPC,LdA,LdB,LdALU,WRF,LdMDR,SWA,sssb,IFF,req,cs}=19'h0; end
    endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule