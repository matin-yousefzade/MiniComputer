module str2num(input [7:0]str,input Start,Clk,Rst,output [31:0]num,output Ready);
  wire [31:0]coef,char2num,Mult,Add;
  wire [7:0]FC;
  wire InitN,InitFC,LdN,LdFC;
  assign coef=(FC==8'h42)?32'h2:(FC==8'h0 | (8'h30<=FC & FC<=8'h39) | FC==8'h44)?32'hA:(FC==8'h48)?32'h10:32'h0;
  Multiplier_32b G1(num,coef,Mult);
  Adder_32b G2(char2num,Mult,Add);
  char2num G3(str,FC,char2num);
  //********************************************************************************************************
  Register_32b_Init M1(Add,Clk,Rst,InitN,LdN,num);
  Register_8b_Init M2(str,Clk,Rst,InitFC,LdFC,FC);
  //********************************************************************************************************
  str2num_Controller G4(str,Start,Clk,Rst,Ready,InitN,InitFC,LdN,LdFC);
endmodule






module str2num_TB();
  reg [7:0]str;
  reg Start,Clk,Rst;
  wire [31:0]num;
  wire Ready;
  str2num G1(str,Start,Clk,Rst,num,Ready);
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
    Start=1;
    #100
    Start=0;
    #100
    str=8'h44;
    #100
    str=8'h35;
    #100
    str=8'h36;
    #100
    str=8'h31;
    #100
    str=8'h0;
    #200
    //**********************************************************************************************
    Start=1;
    #100
    Start=0;
    #100
    str=8'h42;
    #100
    str=8'h31;
    #100
    str=8'h31;
    #100
    str=8'h30;
    #100
    str=8'h0;
    #200
    //**********************************************************************************************
    Start=1;
    #100
    Start=0;
    #100
    str=8'h48;
    #100
    str=8'h31;
    #100
    str=8'h45;
    #100
    str=8'h0;
    #200
    //**********************************************************************************************
    Start=1;
    #100
    Start=0;
    #100
    str=8'h30;
    #100
    str=8'h32;
    #100
    str=8'h32;
    #100
    str=8'h30;
    #100
    str=8'h0;
    #200
    //**********************************************************************************************
    $stop;
  end
endmodule    