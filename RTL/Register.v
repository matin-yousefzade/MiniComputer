module Register_32b(input [31:0]Data,input Ld,Clk,Rst,output reg [31:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=32'h0;
    else if(Ld) W<=Data;
  end
endmodule




module Register_32b_Init(input [31:0]Data,input Ld,Init,Clk,Rst,output reg [31:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=32'h0;
    else if(Init) W<=32'h0;
    else if(Ld) W<=Data;
  end
endmodule



module Register_16b_Init(input [15:0]Data,input Ld,Init,Clk,Rst,output reg [15:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=16'h0;
    else if(Init) W<=16'h0;
    else if(Ld) W<=Data;
  end
endmodule



module Register_16b(input [15:0]Data,input Ld,Clk,Rst,output reg [15:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=16'h0;
    else if(Ld) W<=Data;
  end
endmodule



module Register_8b(input [7:0]Data,input Ld,Clk,Rst,output reg [7:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=8'h0;
    else if(Ld) W<=Data;
  end
endmodule




module Register_8b_Init(input [7:0]Data,input Ld,Init,Clk,Rst,output reg [7:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=8'h0;
    else if(Init) W<=8'h0;
    else if(Ld) W<=Data;
  end
endmodule



module Register_3b_Init(input [2:0]Data,input Ld,Init,Clk,Rst,output reg [2:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=3'h0;
    else if(Init) W<=3'h0;
    else if(Ld) W<=Data;
  end
endmodule



module Register_3b(input [2:0]Data,input Ld,Clk,Rst,output reg [2:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=3'h0;
    else if(Ld) W<=Data;
  end
endmodule



module Register_2b(input [1:0]Data,input Ld,Clk,Rst,output reg [1:0]W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=2'h0;
    else if(Ld) W<=Data;
  end
endmodule



module Register_1b(input Data,input Ld,Clk,Rst,output reg W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=1'h0;
    else if(Ld) W<=Data;
  end
endmodule




module Register_1b_Init(input Data,input Ld,Init,Clk,Rst,output reg W);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) W<=1'h0;
    else if(Init) W<=1'h0;
    else if(Ld) W<=Data;
  end
endmodule