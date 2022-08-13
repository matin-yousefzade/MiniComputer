module VariableManager(input [31:0]InValue,MemReadBus,input [7:0]Name,input [1:0]InMode,InType,input Start,InInitFlag,grt,Clk,Rst,output [31:0]OutValue,OutAddr,MemWriteBus,MemAddrBus,output [1:0]OutType,WDMB,RDMB,output Ready,req);
  wire [31:0]InValueReg,MemWrite,MemAddr,MemRead;
  wire [7:0]NameRead;
  wire [4:0]NameAddr;
  wire [2:0]SMW;
  wire [1:0]CMA,Mode,Type,NowType,WDM,RDM;
  wire InitFlag,WNM,RNM,InitNM,LdIV,LdOV,LdOA,LdOT,LdNT,LdM,LdT,LdIF,Co1,Co2,cs;
  bufif1_32b B1(MemReadBus,cs,MemRead);
  bufif1_32b B2(MemWrite,cs,MemWriteBus);
  bufif1_32b B3(MemAddr,cs,MemAddrBus);
  bufif1_2b B4(RDM,cs,RDMB);
  bufif1_2b B5(WDM,cs,WDMB);
  Multiplexer_3s_32b M1({24'h0,NameRead},InValueReg,{24'h0,8'h20},{24'h0,8'h0},{30'h0,Type},32'h0,32'h0,32'h0,SMW,MemWrite);
  Register_1b R1(InInitFlag,Clk,Rst,LdIF,InitFlag);
  Register_2b R2(InMode,Clk,Rst,LdM,Mode);
  Register_2b R3(InType,Clk,Rst,LdT,Type);
  Register_2b R4(MemRead[1:0],Clk,Rst,LdNT,NowType);
  Register_2b R5(NowType,Clk,Rst,LdOT,OutType);
  Register_32b R6(MemRead,Clk,Rst,LdOV,OutValue);
  Register_32b R7(MemAddr,Clk,Rst,LdOA,OutAddr);
  Register_32b R8(InValue,Clk,Rst,LdIV,InValueReg);
  Counter_5b C1(CNA,InitNA,Clk,Rst,NameAddr,Co1);
  Counter_32b_3m C2(CMA,InitMA,Clk,Rst,MemAddr,Co2);
  NameMemory G1(Name,NameAddr,WNM,RNM,InitNM,Clk,Rst,NameRead);
  VM_Controller G2(MemRead,Name,NameRead,Mode,Type,NowType,Start,InitFlag,grt,Clk,Rst,SMW,WDM,RDM,CMA,Ready,WNM,RNM,LdIV,LdOV,LdOA,LdOT,LdNT,CNA,InitN,InitNA,InitMA,LdM,LdT,LdIF,req,cs);
endmodule








module VariableManager_TB();
  reg [31:0]InValue,ClientMemWrite,ClientMemAddr;
  reg [7:0]Name;
  reg [1:0]Mode,Type,CWDM,CRDM;
  reg Start,InitFlag,grt,Clk,Rst;
  wire [31:0]OutValue,OutAddr,MemWriteBus,MemAddrBus,MemReadBus,ClientMemRead;
  wire [1:0]WDMB,RDMB,OutType;
  wire Ready,req;
  VariableManager G1(InValue,MemReadBus,Name,Mode,Type,Start,InitFlag,grt,Clk,Rst,OutValue,OutAddr,MemWriteBus,MemAddrBus,OutType,WDMB,RDMB,Ready,req);
  DataMemory G2(MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr,WDMB,RDMB,CWDM,CRDM,Clk,Rst,MemReadBus,ClientMemRead);
  initial begin
     Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    grt=1;
    Start=0;
    Rst=1;
    #100
    Rst=0;
    ClientMemWrite=32'h1;
    ClientMemAddr=32'h8000;
    CWDM=2'h1;
    #100
    ClientMemWrite=32'h78;
    ClientMemAddr=32'h8001;
    CWDM=2'h1;
    #100
    ClientMemWrite=32'h79;
    ClientMemAddr=32'h8002;
    CWDM=2'h1;
    #100
    ClientMemWrite=32'h20;
    ClientMemAddr=32'h8003;
    CWDM=2'h1;
    #100
    ClientMemWrite=32'hA;
    ClientMemAddr=32'h8004;
    CWDM=2'h3;
    #100
    ClientMemWrite=32'h0;
    ClientMemAddr=32'h8008;
    CWDM=2'h1;
    #100
    ClientMemWrite=32'h0;
    ClientMemAddr=32'h8009;
    CWDM=2'h1;
    #100
    CWDM=2'h0;
    //************************************************************************************
    //Read
    Start=1;
    #100
    Start=0;
    #100
    Name=8'h78;
    #100
    Name=8'h79;
    #100
    Name=8'h0;
    #100
    Mode=2'h2;
    Type=2'h1;
    InitFlag=0;
    #7000
    //************************************************************************************
    //NewWrite
    Start=1;
    #100
    Start=0;
    #100
    Name=8'h78;
    #100
    Name=8'h79;
    #100
    Name=8'h0;
    #100
    InValue=32'hD;
    Mode=2'h1;
    Type=2'h1;
    InitFlag=0;
    #7000
    //************************************************************************************
    //Write
    Start=1;
    #100
    Start=0;
    #100
    Name=8'h61;
    #100
    Name=8'h62;
    #100
    Name=8'h63;
    #100
    Name=8'h0;
    #100
    InValue=8'h12;
    Mode=2'h3;
    Type=2'h2;
    InitFlag=1;
    #7000
    //************************************************************************************
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
    ClientMemAddr=32'h800A;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800B;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800C;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800D;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800E;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800F;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8010;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8011;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8012;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8013;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8014;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8015;
    CRDM=2'h1;
    #100
    $stop;
  end
endmodule