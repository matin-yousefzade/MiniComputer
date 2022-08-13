module RegisterFile_5a_32b(input [31:0]WriteData,input [4:0]WriteAddr,AAddr,BAddr,ClientAddr,input Clk,Rst,WRF,output reg [31:0]AData,BData,ClientData);
  reg [31:0] Memory [31:0];
  integer i;
  always @(AAddr,BAddr,ClientAddr) begin
    Memory[0]=32'h0;
    begin AData=32'h0;BData=32'h0;ClientData=32'h0; end
    AData=Memory[AAddr];
    BData=Memory[BAddr];
    ClientData=Memory[ClientAddr];
  end
  always @(posedge Clk,posedge Rst) begin
    Memory[0]=32'h0;
    if(Rst) begin
      for(i=0;i<=31;i=i+1) Memory[i]<=32'h0;
    end
    else if(WRF) begin
      Memory[WriteAddr]<=WriteData;
      if(AAddr==WriteAddr) AData<=WriteData;
      if(BAddr==WriteAddr) BData<=WriteData;
      if(ClientAddr==WriteAddr) ClientData<=WriteData;
    end
  end
endmodule





module RegisterFile_5a_32b_TB();
  reg [31:0]WriteData;
  reg [4:0]WriteAddr,AAddr,BAddr,ClientAddr;
  reg Clk,Rst,WRF;
  wire [31:0]AData,BData,ClientData;
  RegisterFile_5a_32b G1(WriteData,WriteAddr,AAddr,BAddr,ClientAddr,Clk,Rst,WRF,AData,BData,ClientData);
  initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    Rst=1;
    BAddr=5'h1;
    #100
    Rst=0;
    WriteData=32'hFE;
    WriteAddr=5'h0;
    WRF=1;
    #100
    WriteData=32'hD8;
    WriteAddr=5'h1;
    WRF=1;
    #100
    WriteData=32'h9A;
    WriteAddr=5'h5;
    WRF=1;
    #100
    WRF=0;
    AAddr=5'h0;
    #100
    ClientAddr=5'h5;
    #100
    $stop;
  end
endmodule