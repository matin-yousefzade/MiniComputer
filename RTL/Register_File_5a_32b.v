module Register_File_5a_32b(input [31:0]WriteRegData,input [4:0]WriteRegAddr,AAddr,BAddr,ClientRegAddr,input Clk,Rst,WRF,output reg [31:0]AData,BData,ClientRegData);
  reg [31:0] RegisterFile [31:0];
  integer i;
  always @(AAddr,BAddr,ClientRegAddr) begin
    begin AData=32'h0;BData=32'h0;ClientRegData=32'h0; end
    AData=RegisterFile[AAddr];
    BData=RegisterFile[BAddr];
    ClientRegData=RegisterFile[ClientRegAddr];
  end
  always @(posedge Clk,posedge Rst) begin
    if (WRF) begin
      RegisterFile[WriteRegAddr]=WriteRegData;
      AData=RegisterFile[AAddr];
      BData=RegisterFile[BAddr];
      ClientRegData=RegisterFile[ClientRegAddr];
    end
    if (Rst) begin
      for (i=0;i<=31;i=i+1) RegisterFile[i]=32'h0;
      AData=32'h0;
      BData=32'h0;
      ClientRegData=32'h0;
    end
  end
endmodule




module Register_File_5a_32b_TB();
  reg [31:0]WriteRegData;
  reg [4:0]WriteRegAddr,AAddr,BAddr,ClientRegAddr;
  reg Clk,Rst,WRF;
  wire [31:0]AData,BData,ClientRegData;
  Register_File_5a_32b G1(WriteRegData,WriteRegAddr,AAddr,BAddr,ClientRegAddr,Clk,Rst,WRF,AData,BData,ClientRegData);
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
    AAddr=5'h0;
    BAddr=5'h1;
    ClientRegAddr=5'h5;
    #100
    WriteRegAddr=5'h0;
    WriteRegData=32'h4;
    WRF=1;
    #100
    WriteRegAddr=5'h1;
    WriteRegData=32'h7;
    WRF=1;
    #100
    WriteRegAddr=5'h4;
    WriteRegData=32'h9;
    WRF=1;
    #100
    BAddr=5'h4;
    #100
    $stop;
  end
endmodule