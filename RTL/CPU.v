module CPU(input [31:0]WriteInsData,ClientInsRead,ClientInsAddr,MemReadBus,input [4:0]ClientRegAddr,input [1:0]WIM,CRIM,input Start,InitPC,InitLNO,CLNO,grt,Clk,Rst,output [31:0]ClientRegData,WriteInsAddr,MemWriteBus,MemAddrBus,output [4:0]ps,output [1:0]WDMB,RDMB,output Ready,req);
  wire [31:0]MemRead,MemAddr,A,B,AData,BData,BI,ALURes,ALU,SEImd,ParPC,PC,IncPC,ParLNO,Ins,IR,WriteRegData,MemData;
  wire [4:0]AAddr,BAddr,WriteRegAddr,SALU;
  wire [2:0]SWRD;
  wire [1:0]SI,RIM,WDM,RDM,SPC;
  wire LdIR,LdA,LdB,LdALU,LdMDR,CPC,WRF,eq,ne,gt,ge,lt,le,nz,IFF,SWA,sssb,cs;
  bufif1_32b B1(MemReadBus,cs,MemRead);
  bufif1_32b B2(A,cs,MemWriteBus);
  bufif1_32b B3(MemAddr,cs,MemAddrBus);
  bufif1_2b B4(RDM,cs,RDMB);
  bufif1_2b B5(WDM,cs,WDMB);
  //************************************************************************************************************
  Register_32b R1(Ins,Clk,Rst,LdIR,IR);
  Register_32b R2(AData,Clk,Rst,LdA,A);
  Register_32b R3(BData,Clk,Rst,LdB,B);
  Register_32b R4(ALURes,Clk,Rst,LdALU,ALU);
  Register_32b R5(MemRead,Clk,Rst,LdMDR,MemData);
  Register_32b_Init R6(ParPC,Clk,Rst,InitPC,CPC,PC);
  Register_32b_Init R7(ParLNO,Clk,Rst,InitLNO,CLNO,WriteInsAddr);
  //************************************************************************************************************
  Multiplexer_3s_32b M1(ALU,MemData,32'h0,32'h1,PC,{A[31:16],IR[15:0]},{IR[15:0],A[15:0]},32'h0,SWRD,WriteRegData);
  Multiplexer_2s_32b M2(B,{16'h0,IR[15:0]},SEImd,32'h0,SI,BI);
  Multiplexer_2s_32b M3(IncPC,MemAddr,A,PC,SPC,ParPC);
  Multiplexer_1s_5b M4(IR[25:21],5'h1F,SWA,WriteRegAddr);
  Multiplexer_1s_5b M5(IR[20:16],IR[25:21],sssb,AAddr);
  Multiplexer_1s_5b M6(IR[15:11],IR[20:16],sssb,BAddr);
  //************************************************************************************************************
  InstructionMemory G1(WriteInsData,WriteInsAddr,PC,ClientInsAddr,WIM,RIM,CRIM,Clk,Rst,Ins,ClientInsRead);
  Register_File_5a_32b G2(WriteRegData,WriteRegAddr,AAddr,BAddr,ClientRegAddr,Clk,Rst,WRF,AData,BData,ClientRegData);
  //************************************************************************************************************
  ALU G3(A,BI,SALU,ALURes);
  Comparator_1 G4(A,B,eq,ne,gt,ge,lt,le);
  Comparator_2 G5(A,nz);
  Plus4 G6(PC,IncPC);
  Plus4 G7(WriteInsAddr,ParLNO);
  Adder_32b G8(B,{16'h0,IR[15:0]},MemAddr);
  SignExtender G9(IR[15:0],SEImd);
  //************************************************************************************************************
  CPU_Controller_1 G10(IR[31:26],Start,grt,Clk,Rst,ps,WDM,RDM,RIM,Ready,LdIR,CPC,LdA,LdB,LdALU,WRF,LdMDR,SWA,sssb,IFF,req,cs);
  CPU_Controller_2 G11(IR[31:26],eq,ne,gt,ge,lt,le,nz,IFF,SALU,SWRD,SI,SPC);
endmodule







module CPU_TB();
  reg [31:0]WriteInsData,ClientInsRead,ClientInsAddr,ClientMemWrite,ClientMemAddr;
  reg [4:0]RegAddr;
  reg [1:0]WIM,CRIM,CWDM,CRDM;
  reg Start,InitPC,InitLNO,CLNO,grt,Clk,Rst;
  wire [31:0]RegData,WriteInsAddr,MemReadBus,MemWriteBus,MemAddrBus,ClientMemRead;
  wire [4:0]ps;
  wire [1:0]WDMB,RDMB;
  wire Ready,req;
  CPU G1(WriteInsData,ClientInsRead,ClientInsAddr,MemReadBus,RegAddr,WIM,CRIM,Start,InitPC,InitLNO,CLNO,1'h1,Clk,Rst,RegData,WriteInsAddr,MemWriteBus,MemAddrBus,ps,WDMB,RDMB,Ready,req);
  DataMemory G2(MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr,WDMB,RDMB,CWDM,CRDM,Clk,Rst,MemReadBus,ClientMemRead);
  initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    Start=0;
    Rst=1;
    #100
    Rst=0;
    ClientMemWrite=32'h5;
    ClientMemAddr=32'h0;
    CWDM=2'h3;
    #100
    ClientMemWrite=32'h2;
    ClientMemAddr=32'h4;
    CWDM=2'h3;
    #100
    ClientMemWrite=32'h1234;
    ClientMemAddr=32'h8;
    CWDM=2'h3;
    #100
    ClientMemWrite=32'h8;
    ClientMemAddr=32'hC;
    CWDM=2'h3;
    #100
    //********************************************************************************************************
    CWDM=0;
    InitPC=1;
    InitLNO=1;
    #100
    InitPC=0;
    InitLNO=0;
    WriteInsData={6'h21,5'h1,5'h0,16'hC};
    WIM=2'h3;
    CLNO=1;
    #100
    WriteInsData={6'h21,5'h2,5'h1,16'h0};
    WIM=2'h3;
    CLNO=1;
    #100
    //**********************************************************************************************************
    WriteInsData={6'h3F,26'h0};
    WIM=2'h3;
    CLNO=1;
    #100
    //**********************************************************************************************************
    WIM=0;
    CLNO=0;
    Start=1;
    #100
    Start=0;
    #7000
    RegAddr=5'h1;
    #100
    RegAddr=5'h2;
    #100
    RegAddr=5'h3;
    #100
    RegAddr=5'h4;
    #100
    $stop;
  end
endmodule