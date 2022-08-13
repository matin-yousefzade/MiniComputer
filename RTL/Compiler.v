module Compiler(input [31:0]WIA,MemReadBus,input [7:0]InsPart,Opcode,input [3:0]IPP,input Start,VMgrt,IOACgrt,Clk,Rst,output [31:0]WID,MemWriteBus,MemAddrBus,output [3:0]ps,output [1:0]WDMB,RDMB,WIM,output Ready,VMreq,IOACreq,CLNO);
  wire [31:0]IOACCPUIns,OCCPUIns,OutValue,OutAddr;
  wire [7:0]SR1,SR2;
  wire [1:0]OutType;
  wire LdSR,SCPUIns,VMStart,IOACStart,OCStart,VMReady,IOACReady,OCReady,IOACGiveIns,OCGiveIns;
  Register_8b R1(InsPart,Clk,Rst,LdSR,SR1);
  Register_8b R2(SR1,Clk,Rst,LdSR,SR2);
  Multiplexer_1s_32b M1(IOACCPUIns,OCCPUIns,SCPUIns,WID);
  VariableManager G3(WIA,MemReadBus,SR2,2'h1,2'h3,VMStart,1'h1,VMgrt,Clk,Rst,OutValue,OutAddr,MemWriteBus,MemAddrBus,OutType,WDMB,RDMB,VMReady,VMreq);
  IOAC G4(MemReadBus,SR2,Opcode,IPP,IOACStart,IOACgrt,Clk,Rst,MemWriteBus,MemAddrBus,IOACCPUIns,WDMB,RDMB,IOACReady,IOACreq,IOACGiveIns);
  OpcodeCompiler G5(Opcode,OCStart,Clk,Rst,OCCPUIns,OCReady,OCGiveIns);
  Compiler_Controller G6(IPP,Start,VMReady,IOACReady,OCReady,IOACGiveIns,OCGiveIns,Clk,Rst,ps,WIM,Ready,LdSR,VMStart,IOACStart,OCStart,CLNO,SCPUIns);
endmodule








module Compiler_TB();
  reg [31:0]ClientInsAddr,ClientMemWrite,ClientMemAddr;
  reg [7:0]InsPart,Opcode;
  reg [3:0]IPP;
  reg [1:0]CRIM,CWDM,CRDM;
  reg Start,CPUStart,CPUgrt,VMgrt,IOACgrt,InitLNO,InitPC,Clk,Rst; 
  wire [31:0]WriteInsData,WriteInsAddr,MemReadBus,RegData,MemWriteBus,MemAddrBus,ClientReadData,ClientInsRead;
  wire [4:0]RegAddr,CPUps;
  wire [3:0]ps;
  wire [1:0]WIM,WDMB,RDMB;
  wire CPUReady,CPUreq,Ready,VMreq,IOACreq,CLNO;
  //*****************************************************************************************************************
  CPU G1(WriteInsData,ClientInsRead,ClientInsAddr,MemReadBus,RegAddr,WIM,CRIM,CPUStart,InitPC,InitLNO,CLNO,CPUgrt,Clk,Rst,RegData,WriteInsAddr,MemWriteBus,MemAddrBus,CPUps,WDMB,RDMB,CPUReady,CPUreq);
  Compiler G2(WriteInsAddr,MemReadBus,InsPart,Opcode,IPP,Start,VMgrt,IOACgrt,Clk,Rst,WriteInsData,MemWriteBus,MemAddrBus,ps,WDMB,RDMB,WIM,Ready,VMreq,IOACreq,CLNO);
  DataMemory G3(MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr,WDMB,RDMB,CWDM,CRDM,Clk,Rst,MemReadBus,ClientReadData);
  //*****************************************************************************************************************
  initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    CPUgrt=1;
    VMgrt=1;
    IOACgrt=1;
    CPUStart=0;
    Start=0;
    Rst=1;
    #100
    Rst=0;
    #100
    InitLNO=1;
    InitPC=1;
    #100
    InitLNO=0;
    InitPC=0;
    IPP=4'h0;
    Opcode=8'h2;
    Start=1;
    #100
    Start=0;
    #100
    InsPart=8'h61;
    #100
    InsPart=8'h62;
    #100
    InsPart=8'h63;
    #100
    InsPart=8'h0;
    #7000
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
    CRDM=2'h0;
    //******************************
    ClientInsAddr=32'h0;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h4;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h8;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'hC;
    CRIM=2'h3;
    #100
    $stop;
  end
endmodule