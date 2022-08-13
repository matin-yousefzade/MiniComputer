module char2num(input [7:0]char,FC,output reg [31:0]num);
  always @(char,FC) begin
    if (FC==8'h42) begin
      num=char-48;
    end
    else if (FC==8'h0 | (8'h30<=FC & FC<=8'h39) | FC==8'h44) begin
      num=char-48;
    end
    else if (FC==8'h48) begin
      if (8'h30<=char & char<=8'h39) begin
        num=char-48;
      end
      else if(8'h41<=char & char<=8'h46) begin
        num=char-55;
      end
    end
    else begin
      num=32'h0;
    end
  end
endmodule







module char2num_TB();
  reg [7:0]char,FC;
  wire [31:0]num;
  char2num G1(char,FC,num);
  initial begin
    FC=8'h42;
    char=8'h30;
    #100
    char=8'h31;
    #100
    FC=8'h0;
    char=8'h32;
    #100
    char=8'h35;
    #100
    FC=8'h44;
    char=8'h33;
    #100
    char=8'h37;
    #100
    FC=8'h48;
    char=8'h36;
    #100
    char=8'h41;
    #100
    $stop;
  end
endmodule