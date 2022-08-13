module InstructionMemory(input [31:0]WriteData,WriteAddr,ReadAddr,ClientAddr,input [1:0]WIM,RIM,CRIM,input Clk,Rst,output reg [31:0]ReadData,ClientData);
  reg [31:0] Memory [65535:0];
  integer i;
  always @(posedge Clk,posedge Rst) begin
    if(WIM==2'h1) begin
      Memory[WriteAddr]<=WriteData[7:0];
    end
    if(WIM==2'h2) begin
      Memory[WriteAddr]<=WriteData[7:0];
      Memory[WriteAddr+1]<=WriteData[15:8];
    end
    if(WIM==2'h3) begin
      Memory[WriteAddr]<=WriteData[7:0];
      Memory[WriteAddr+1]<=WriteData[15:8];
      Memory[WriteAddr+2]<=WriteData[23:16];
      Memory[WriteAddr+3]<=WriteData[31:24];
    end
    if(RIM==2'h1) begin
      ReadData[7:0]<=Memory[ReadAddr];
      ReadData[31:8]<=24'h0;
    end
    if(RIM==2'h2) begin
      ReadData[7:0]<=Memory[ReadAddr];
      ReadData[15:8]<=Memory[ReadAddr+1];
      ReadData[31:16]<=16'h0;
    end
    if(RIM==2'h3) begin
      ReadData[7:0]<=Memory[ReadAddr];
      ReadData[15:8]<=Memory[ReadAddr+1];
      ReadData[23:16]<=Memory[ReadAddr+2];
      ReadData[31:24]<=Memory[ReadAddr+3];
    end
    if(CRIM==2'h1) begin
      ClientData[7:0]<=Memory[ClientAddr];
      ClientData[31:8]<=24'h0;
    end
    if(CRIM==2'h2) begin
      ClientData[7:0]<=Memory[ClientAddr];
      ClientData[15:8]<=Memory[ClientAddr+1];
      ClientData[31:16]<=16'h0;
    end
    if(CRIM==2'h3) begin
      ClientData[7:0]<=Memory[ClientAddr];
      ClientData[15:8]<=Memory[ClientAddr+1];
      ClientData[23:16]<=Memory[ClientAddr+2];
      ClientData[31:24]<=Memory[ClientAddr+3];
    end
    if(Rst) begin
      for(i=0;i<=65535;i=i+1) Memory[i]<=8'h0;
    end
  end
endmodule



module InstructionMemory_TB();
  reg [31:0]WriteData,WriteAddr,ReadAddr,ClientAddr;
  reg [1:0]WIM,RIM,CRIM;
  reg Clk,Rst;
  wire [31:0]ReadData,ClientData;
  InstructionMemory G1(WriteData,WriteAddr,ReadAddr,ClientAddr,WIM,RIM,CRIM,Clk,Rst,ReadData,ClientData);
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
    WriteData=32'hFE;
    WriteAddr=32'h0;
    WIM=2'h1;
    #100
    WriteData=32'h6AA2;
    WriteAddr=32'h2;
    WIM=2'h2;
    #100
    WriteData=32'h9BB567CA;
    WriteAddr=32'h5;
    WIM=2'h3;
    #100
    WIM=0;
    ReadAddr=32'h0;
    RIM=2'h1;
    #100
    ReadAddr=32'h1;
    RIM=2'h1;
    #100
    ReadAddr=32'h2;
    RIM=2'h1;
    #100
    ReadAddr=32'h3;
    RIM=2'h1;
    #100
    RIM=0;
    ClientAddr=32'h4;
    CRIM=2'h1;
    #100
    ClientAddr=32'h5;
    CRIM=2'h3;
    #100
    $stop;
  end
endmodule