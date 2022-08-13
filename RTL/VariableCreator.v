module VariableCreator(input [31:0]MemReadBus,input [7:0]InsPart,input [1:0]ParTR,input Start,ParIFR,LdTR,LdIFR,grt,Clk,Rst,output [31:0]MemWriteBus,MemAddrBus,output [1:0]WDMB,RDMB,output Ready,HalfReady,req);
  wire [31:0]SNV,SNVR,OutValue,OutAddr;
  wire [7:0]SR1,SR2,Name;
  wire [1:0]TR,OutType;
  wire IFR,LdSR,LdSNVR,SN,SNStart,SNReady;
  Register_1b R1(ParIFR,Clk,Rst,LdIFR,IFR);
  Register_2b R2(ParTR,Clk,Rst,LdTR,TR);
  Register_8b R3(InsPart,Clk,Rst,LdSR,SR1);
  Register_8b R4(SR1,Clk,Rst,LdSR,SR2);
  Register_32b R5(SNV,Clk,Rst,LdSNVR,SNVR);
  Multiplexer_1s_8b M1(InsPart,SR2,SN,Name);
  str2num G1(SR2,SNStart,Clk,Rst,SNV,SNReady);
  VariableManager G2(SNVR,MemReadBus,Name,2'h3,TR,VMStart,IFR,grt,Clk,Rst,OutValue,OutAddr,MemWriteBus,MemAddrBus,OutType,WDMB,RDMB,VMReady,req);
  VC_Controller G3(InsPart,SR2,TR,Start,IFR,SNReady,VMReady,Clk,Rst,Ready,HalfReady,SNStart,VMStart,LdSR,LdSNVR,SN);
endmodule





module VariableCreator_TB();
  reg [31:0]ClientMemWrite,ClientMemAddr;
  reg [7:0]InsPart;
  reg [1:0]ParTR,CWDM,CRDM;
  reg Start,ParIFR,LdTR,LdIFR,grt,Clk,Rst;
  wire [31:0]MemReadBus,MemWriteBus,MemAddrBus,ClientMemRead;
  wire [1:0]WDMB,RDMB;
  wire Ready,HalfReady,req;
  VariableCreator G1(MemReadBus,InsPart,ParTR,Start,ParIFR,LdTR,LdIFR,grt,Clk,Rst,MemWriteBus,MemAddrBus,WDMB,RDMB,Ready,HalfReady,req);
  DataMemory G2(MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr,WDMB,RDMB,CWDM,CRDM,Clk,Rst,MemReadBus,ClientMemRead);
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
    ParIFR=1;
    ParTR=2'h1;
    LdIFR=1;
    LdTR=1;
    #100
    LdIFR=0;
    LdTR=0;
    Start=1;
    #100
    Start=0;
    #100
    InsPart=8'h36;
    #100
    InsPart=8'h39;
    #100
    InsPart=8'h0;
    #600
    InsPart=8'h61;
    #100
    InsPart=8'h62;
    #100
    InsPart=8'h63;
    #100
    InsPart=8'h0;
    #3000
    ClientMemAddr=32'h8000;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8001;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8002;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8003;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8004;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8005;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8006;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8007;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8008;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8009;
    CRDM=2'h1;
    #100
    $stop;
  end
endmodule