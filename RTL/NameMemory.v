module NameMemory(input [7:0]WriteData,input [4:0]Addr,input WNM,RNM,InitNM,Clk,Rst,output reg [7:0]ReadData);
  reg [7:0]Memory[31:0];
  integer i;
  always @(posedge Clk,posedge Rst) begin
    if (WNM) Memory[Addr]<=WriteData;
    if (RNM) ReadData<=Memory[Addr];
    if (InitNM) begin
      for(i=0;i<=31;i=i+1) Memory[i]<=8'h0;
    end
    if (Rst) begin
      for(i=0;i<=31;i=i+1) Memory[i]<=8'h0;
      ReadData<=8'h0;
    end
  end
endmodule