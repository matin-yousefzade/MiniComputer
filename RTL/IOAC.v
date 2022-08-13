module IOAC(input [31:0]MemReadBus,input [7:0]InsPart,Opcode,input [3:0]IPP,input Start,grt,Clk,Rst,output [31:0]MemWriteBus,MemAddrBus,CPUIns,output [1:0]WDMB,RDMB,output Ready,req,GiveIns);
  wire [31:0]Mux1,Mux2,Mux3,CPUIns1,CPUIns2,CPUIns3,SNV,VMV,VMA,A,B,C;
  wire [7:0]FC,SC,SR1,SR2;
  wire [5:0]It1,It2,It3,It4;
  wire [4:0]Rt;
  wire [2:0]SMode;
  wire [1:0]VMT,SIns;
  wire LdFC,LdSC,LdIns,LdSR,SNStart,VMStart,SNReady,VMReady;
  assign Rt={1'h0,IPP}+5'h10;
  assign It1=(SC==8'h42)?6'h1F:(SC==8'h48)?6'h20:(SC==8'h57)?6'h21:6'h0;
  assign It2=(VMT==2'h2)?6'h1F:(VMT==2'h1 | VMT==2'h3)?6'h21:6'h0;
  assign It3=(SC==8'h42)?6'h1C:(SC==8'h48)?6'h1D:(SC==8'h57)?6'h1E:6'h0;
  assign It4=(VMT==2'h2)?6'h1C:(VMT==2'h1 | VMT==2'h3)?6'h1E:6'h0;
  assign A=(Opcode==8'h18)?{6'h2C,Rt,5'h0,VMA[15:0]}:(Opcode==8'h19)?{6'h2C,Rt,5'h0,{14'h0,VMT}}:{6'h2C,5'h11,5'h0,VMA[15:0]};
  assign B=(Opcode==8'h18)?{6'h2D,Rt,5'h0,VMA[31:16]}:(Opcode==8'h19)?{6'h2D,Rt,5'h0,16'h0}:{6'h2D,5'h11,5'h0,VMA[31:16]};
  assign C=(Opcode==8'h18)?32'h0:(Opcode==8'h19)?32'h0:{It2,Rt,5'h11,16'h0};
  Register_8b R1(InsPart,Clk,Rst,LdFC,FC);
  Register_8b R2(InsPart,Clk,Rst,LdSC,SC);
  Register_8b R3(InsPart,Clk,Rst,LdSR,SR1);
  Register_8b R4(SR1,Clk,Rst,LdSR,SR2);
  Register_32b R5(Mux1,Clk,Rst,LdIns,CPUIns1);
  Register_32b R6(Mux2,Clk,Rst,LdIns,CPUIns2);
  Register_32b R7(Mux3,Clk,Rst,LdIns,CPUIns3);
  Multiplexer_3s_32b M1({6'h1,Rt,5'h0,SNV[4:0],11'h0},{6'h2C,5'h11,5'h0,SNV[15:0]},{6'h2C,Rt,5'h0,SNV[15:0]},A,{6'h1,SNV[4:0],5'h12,5'h0,11'h0},{6'h2C,5'h11,5'h0,SNV[15:0]},{6'h2C,5'h11,5'h0,VMA[15:0]},32'h0,SMode,Mux1);
  Multiplexer_3s_32b M2(32'h0,{6'h2D,5'h11,5'h0,SNV[31:16]},{6'h2D,Rt,5'h0,SNV[31:16]},B,32'h0,{6'h2D,5'h11,5'h0,SNV[31:16]},{6'h2D,5'h11,5'h0,VMA[31:16]},32'h0,SMode,Mux2);
  Multiplexer_3s_32b M3(32'h0,{It1,Rt,5'h11,16'h0},32'h0,C,32'h0,{It3,5'h12,5'h11,16'h0},{It4,5'h12,5'h11,16'h0},32'h0,SMode,Mux3);
  Multiplexer_2s_32b M4(CPUIns1,CPUIns2,CPUIns3,32'h0,SIns,CPUIns);
  str2num G1(SR2,SNStart,Clk,Rst,SNV,SNReady);
  VariableManager G2(32'h0,MemReadBus,SR2,2'h2,2'h0,VMStart,1'h0,grt,Clk,Rst,VMV,VMA,MemWriteBus,MemAddrBus,VMT,WDMB,RDMB,VMReady,req);
  IOAC_Controller G3(InsPart,Opcode,FC,IPP,Start,SNReady,VMReady,Clk,Rst,SMode,SIns,Ready,SNStart,VMStart,LdFC,LdSC,LdIns,LdSR,GiveIns);
endmodule





module IOAC_TB();
  reg [31:0]ClientMemWrite,ClientMemAddr;
  reg [7:0]InsPart,Opcode;
  reg [3:0]IPP;
  reg [1:0]CWDM,CRDM;
  reg Start,grt,Clk,Rst;
  wire [31:0]MemReadBus,MemWriteBus,MemAddrBus,ClientReadData,CPUIns;
  wire [1:0]WDMB,RDMB;
  wire Ready,req,GiveIns;
  IOAC G1(MemReadBus,InsPart,Opcode,IPP,Start,grt,Clk,Rst,MemWriteBus,MemAddrBus,CPUIns,WDMB,RDMB,Ready,req,GiveIns);
  DataMemory G2(MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr,WDMB,RDMB,CWDM,CRDM,Clk,Rst,MemReadBus,ClientReadData);
  initial begin
     Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    Start=0;
    grt=1;
    Rst=1;
    #100
    Rst=0;
    ClientMemWrite=8'h1;
    ClientMemAddr=32'h8000;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h61;
    ClientMemAddr=32'h8001;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h62;
    ClientMemAddr=32'h8002;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h63;
    ClientMemAddr=32'h8003;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h20;
    ClientMemAddr=32'h8004;
    CWDM=2'h1;
    #100
    ClientMemWrite=32'h5;
    ClientMemAddr=32'h8005;
    CWDM=2'h3;
    #100
    ClientMemWrite=8'h0;
    ClientMemAddr=32'h8009;
    CWDM=2'h3;
    #100
    //*************************************************************************************
    ClientMemWrite=8'h2;
    ClientMemAddr=32'h800A;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h63;
    ClientMemAddr=32'h800B;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h68;
    ClientMemAddr=32'h800C;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h61;
    ClientMemAddr=32'h800D;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h72;
    ClientMemAddr=32'h800E;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h20;
    ClientMemAddr=32'h800F;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h78;
    ClientMemAddr=32'h8010;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h0;
    ClientMemAddr=32'h8011;
    CWDM=2'h1;
    #100
    //************************************************************************************
    ClientMemWrite=8'h3;
    ClientMemAddr=32'h8012;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h78;
    ClientMemAddr=32'h8013;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h20;
    ClientMemAddr=32'h8014;
    CWDM=2'h1;
    #100
    ClientMemWrite=32'h1234ABCD;
    ClientMemAddr=32'h8015;
    CWDM=2'h3;
    #100
    ClientMemWrite=8'h0;
    ClientMemAddr=32'h8019;
    CWDM=2'h3;
    #100
    ClientMemWrite=8'h0;
    ClientMemAddr=32'h801A;
    CWDM=2'h3;
    #100
    //*************************************************************************************
    CWDM=2'h0;
    IPP=4'h3;
    Opcode=8'h2;
    Start=1;
    #100
    Start=0;
    #100
    InsPart=8'h49;
    #100
    InsPart=8'h35;
    #100
    InsPart=8'h0;
    #7000
    $stop;
  end
endmodule