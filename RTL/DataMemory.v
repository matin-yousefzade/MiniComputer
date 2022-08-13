module DataMemory(input [31:0]MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr,input [1:0]WDMB,RDMB,CWDM,CRDM,input Clk,Rst,output reg [31:0]MemReadBus,ClientMemRead);
  reg [7:0] Memory [65535:0];
  integer i;
  always @(posedge Clk,posedge Rst) begin
    if(WDMB==2'h1) begin
      Memory[MemAddrBus]<=MemWriteBus[7:0];
    end
    if(WDMB==2'h2) begin
      Memory[MemAddrBus]<=MemWriteBus[7:0];
      Memory[MemAddrBus+1]<=MemWriteBus[15:8];
    end
    if(WDMB==2'h3) begin
      Memory[MemAddrBus]<=MemWriteBus[7:0];
      Memory[MemAddrBus+1]<=MemWriteBus[15:8];
      Memory[MemAddrBus+2]<=MemWriteBus[23:16];
      Memory[MemAddrBus+3]<=MemWriteBus[31:24];
    end
    if(RDMB==2'h1) begin
      MemReadBus[7:0]<=Memory[MemAddrBus];
      MemReadBus[31:8]<=24'h0;
    end
    if(RDMB==2'h2) begin
      MemReadBus[7:0]<=Memory[MemAddrBus];
      MemReadBus[15:8]<=Memory[MemAddrBus+1];
      MemReadBus[31:16]<=16'h0;
    end
    if(RDMB==2'h3) begin
      MemReadBus[7:0]<=Memory[MemAddrBus];
      MemReadBus[15:8]<=Memory[MemAddrBus+1];
      MemReadBus[23:16]<=Memory[MemAddrBus+2];
      MemReadBus[31:24]<=Memory[MemAddrBus+3];
    end
    //**************************************************************************************************
    if(CWDM==2'h1) begin
      Memory[ClientMemAddr]<=ClientMemWrite[7:0];
    end
    if(CWDM==2'h2) begin
      Memory[ClientMemAddr]<=ClientMemWrite[7:0];
      Memory[ClientMemAddr+1]<=ClientMemWrite[15:8];
    end
    if(CWDM==2'h3) begin
      Memory[ClientMemAddr]<=ClientMemWrite[7:0];
      Memory[ClientMemAddr+1]<=ClientMemWrite[15:8];
      Memory[ClientMemAddr+2]<=ClientMemWrite[23:16];
      Memory[ClientMemAddr+3]<=ClientMemWrite[31:24];
    end
    if(CRDM==2'h1) begin
      ClientMemRead[7:0]<=Memory[ClientMemAddr];
      ClientMemRead[31:8]<=24'h0;
    end
    if(CRDM==2'h2) begin
      ClientMemRead[7:0]<=Memory[ClientMemAddr];
      ClientMemRead[15:8]<=Memory[ClientMemAddr+1];
      ClientMemRead[31:16]<=16'h0;
    end
    if(CRDM==2'h3) begin
      ClientMemRead[7:0]<=Memory[ClientMemAddr];
      ClientMemRead[15:8]<=Memory[ClientMemAddr+1];
      ClientMemRead[23:16]<=Memory[ClientMemAddr+2];
      ClientMemRead[31:24]<=Memory[ClientMemAddr+3];
    end
    if(Rst) begin
      for(i=0;i<=65535;i=i+1) Memory[i]<=8'h0;
    end
  end
endmodule





module DataMemory_TB();
  reg [31:0]MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr;
  reg [1:0]WDMB,RDMB,CWDM,CRDM;
  reg Clk,Rst;
  wire [31:0]MemReadBus,ClientMemRead;
  DataMemory G1(MemWriteBus,MemAddrBus,ClientMemWrite,ClientMemAddr,WDMB,RDMB,CWDM,CRDM,Clk,Rst,MemReadBus,ClientMemRead);
  initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    Rst=1;
    #100
    Rst=0;
    MemWriteBus=8'h3;
    MemAddrBus=32'h8000;
    WDMB=2'h1;
    #100
    MemWriteBus=8'h61;
    MemAddrBus=32'h8001;
    WDMB=2'h1;
    #100
    MemWriteBus=8'h62;
    MemAddrBus=32'h8002;
    WDMB=2'h1;
    #100
    WDMB=2'h0;
    ClientMemWrite=8'h63;
    ClientMemAddr=32'h8003;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h20;
    ClientMemAddr=32'h8004;
    CWDM=2'h1;
    #100
    ClientMemWrite=8'h49;
    ClientMemAddr=32'h8005;
    CWDM=2'h1;
    #100
    CWDM=2'h0;
    //***************************************
    //***************************************
    //***************************************
    MemAddrBus=32'h8000;
    RDMB=2'h1;
    #100
    MemAddrBus=32'h8001;
    RDMB=2'h1;
    #100
    MemAddrBus=32'h8002;
    RDMB=2'h1;
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
    $stop;
  end
endmodule