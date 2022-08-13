module Counter_32b_3m(input [1:0]Count,input Init,Clk,Rst,output reg [31:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=32'h0;
    end
    else if (Init) begin
      Res<=32'h8000;
    end
    else if (Count==2'h1) begin
      Res<=Res+1;
    end
    else if (Count==2'h2) begin
      Res<=Res+2;
    end
    else if (Count==2'h3) begin
      Res<=Res+5;
    end
  end
  assign Co=&Res;
endmodule





module Counter_32b_4p(input Count,input Init,Clk,Rst,output reg [31:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=32'h0;
    end
    else if (Init) begin
      Res<=32'h0;
    end
    else if (Count) begin
      Res<=Res+4;
    end
  end
  assign Co=&Res;
endmodule





module Counter_16b_Par(input [15:0]Par,input Count,Init,ParLd,Clk,Rst,output reg [15:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=16'h0;
    end
    else if (Init) begin
      Res<=16'h0;
    end
    else if (ParLd) begin
      Res<=Par;
    end
    else if (Count) begin
      Res<=Res+1;
    end
  end
  assign Co=&Res;
endmodule




module Counter_8b(input Count,Init,Clk,Rst,output reg [7:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=8'h0;
    end
    else if (Init) begin
      Res<=8'h0;
    end
    else if (Count) begin
      Res<=Res+1;
    end
  end
  assign Co=&Res;
endmodule



module Counter_5b(input Count,Init,Clk,Rst,output reg [4:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=5'h0;
    end
    else if (Init) begin
      Res<=5'h0;
    end
    else if (Count) begin
      Res<=Res+1;
    end
  end
  assign Co=&Res;
endmodule





module Counter_4b_Par(input [3:0]Par,input Count,Init,ParLd,Clk,Rst,output reg [3:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=4'h0;
    end
    else if (Init) begin
      Res<=4'h0;
    end
    else if (ParLd) begin
      Res<=Par;
    end
    else if (Count) begin
      Res<=Res+1;
    end
  end
  assign Co=&Res;
endmodule




module Counter_4b(input Count,Init,Clk,Rst,output reg [3:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=4'h0;
    end
    else if (Init) begin
      Res<=4'h0;
    end
    else if (Count) begin
      Res<=Res+1;
    end
  end
  assign Co=&Res;
endmodule




module Counter_3b(input Count,Init,Clk,Rst,output reg [2:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=3'h0;
    end
    else if (Init) begin
      Res<=3'h0;
    end
    else if (Count) begin
      Res<=Res+1;
    end
  end
  assign Co=&Res;
endmodule




module Counter_2b(input Count,Init,Clk,Rst,output reg [1:0]Res,output Co);
  always @(posedge Clk,posedge Rst) begin
    if (Rst) begin
      Res<=2'h0;
    end
    else if (Init) begin
      Res<=2'h0;
    end
    else if (Count) begin
      Res<=Res+1;
    end
  end
  assign Co=&Res;
endmodule