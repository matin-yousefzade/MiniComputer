module Arbiter(input [7:1]req,input Start,Clk,Rst,output [7:1]grt);
  wire [7:0]FV,PV,Sub;
  wire [2:0]WRA,WRD,RRA,RRD,SRD;
  wire WRF,DownShift,InitR,LdR,InitWRA,CWRA,SRA,LdGrt,grt0,Co;
  assign PV={req,1'h0};
  Counter_3b C1(CWRA,InitWRA,Clk,Rst,WRA,Co);
  Register_3b R1(RRD,Clk,Rst,LdGrt,SRD);
  Register_8b_Init R2(PV,Clk,Rst,InitR,LdR,FV);
  Multiplexer_1s_3b M1(3'h0,WRA,SRA,RRA);
  Encoder_3b G1(Sub,WRD);
  Decoder_3b G2(SRD,{grt,grt0});
  Subtractor_8b G3(PV,FV,Sub);
  Register_File_3a_3b G4(WRD,WRA,RRA,Clk,Rst,WRF,DownShift,RRD);
  Arbiter_Controller G5(FV,PV,RRD,Start,Clk,Rst,WRF,DownShift,InitR,LdR,InitWRA,CWRA,SRA,LdGrt);
endmodule



module Arbiter_TB();
  reg [7:1]req;
  reg Start,Clk,Rst;
  wire [7:1]grt;
  Arbiter G1(req,Start,Clk,Rst,grt);
  initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    req=7'b0;
    Start=0;
    Rst=1;
    #100
    Rst=0;
    Start=1;
    #100
    Start=0;
    #1000
    req[2]=1;
    #1000
    req[5]=1;
    #1000
    req[2]=0;
    #1000
    req[3]=1;
    #1000
    req[6]=1;
    #1000
    req[5]=0;
    #1000
    req[3]=0;
    #1000
    req[6]=0;
    #1000
    req[4]=1;
    #1000
    req[4]=0;
    #1000
    $stop;
  end
endmodule