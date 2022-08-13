module AloneInstructionMemory(input [8:0]Addr,input [7:0]WriteData,input WAIM,RAIM,InitAIM,Clk,Rst,output reg [7:0]ReadData);
  reg [7:0]Memory[511:0];
  integer i;
  always @(posedge Clk,posedge Rst) begin
    if (WAIM) Memory[Addr]<=WriteData;
    if (RAIM) ReadData<=Memory[Addr];
    if (InitAIM) begin
      for(i=0;i<=511;i=i+1) Memory[i]<=8'h0;
      ReadData<=8'h0;
    end
    if (Rst) begin
      for(i=0;i<=511;i=i+1) Memory[i]<=8'h0;
      ReadData<=8'h0;
    end
  end
endmodule