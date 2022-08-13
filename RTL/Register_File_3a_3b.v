module Register_File_3a_3b(input [2:0]WriteData,input [2:0]WriteAddr,ReadAddr,input Clk,Rst,WRF,DownShift,output reg [2:0]ReadData);
  reg [2:0] RegisterFile [7:0];
  integer i,j;
  always @(ReadAddr) begin
    begin ReadData=3'h0; end
    ReadData=RegisterFile[ReadAddr];
  end
  always @(posedge Clk,posedge Rst) begin
    if (WRF) begin
      RegisterFile[WriteAddr]=WriteData;
      ReadData=RegisterFile[ReadAddr];
    end
    if (DownShift) begin
      for (i=0;i<=6;i=i+1) RegisterFile[i]=RegisterFile[i+1];
      RegisterFile[3'h7]=3'h0;
      ReadData=RegisterFile[ReadAddr];
    end
    if (Rst) begin
      for (j=0;j<=7;j=j+1) RegisterFile[j]=3'h0;
      ReadData=3'h0;
    end
  end
endmodule




module Register_File_3a_3b_TB();
  reg [2:0]WriteData,WriteAddr,ReadAddr;
  reg Clk,Rst,WRF,DownShift;
  wire [2:0]ReadData;
  Register_File_3a_3b G1(WriteData,WriteAddr,ReadAddr,Clk,Rst,WRF,DownShift,ReadData);
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
    ReadAddr=3'h3;
    #100
    WriteAddr=3'h0;
    WriteData=3'h2;
    WRF=1;
    #100
    WriteAddr=3'h1;
    WriteData=3'h5;
    WRF=1;
    #100
    WriteAddr=3'h3;
    WriteData=3'h7;
    WRF=1;
    #100
    WRF=0;
    ReadAddr=3'h0;
    #100
    ReadAddr=3'h1;
    #100
    DownShift=1;
    #100
    DownShift=0;
    ReadAddr=3'h0;
    #100
    ReadAddr=3'h1;
    #100
    ReadAddr=3'h2;
    #100
    $stop;
  end
endmodule