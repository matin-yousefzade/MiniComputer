module ClientInstructionMemory(input [15:0]Addr,input [7:0]WriteData,input WCIM,RCIM,Clk,Rst,output reg [7:0]ReadData);
  reg [7:0]Memory[65535:0];
  integer i;
  always @(posedge Clk,posedge Rst) begin
    if (WCIM) Memory[Addr]<=WriteData;
    if (RCIM) ReadData<=Memory[Addr];
    if (Rst) begin
      for(i=0;i<=56535;i=i+1) Memory[i]<=8'h0;
      ReadData<=8'h0;
    end
  end
endmodule