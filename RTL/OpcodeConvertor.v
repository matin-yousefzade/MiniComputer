module OpcodeConvertor(input [7:0]Name,input Start,Clk,Rst,output [7:0]Opcode,output Ready);
  wire [12:0]OMA;
  wire [7:0]Tens,NMRD,OMWD,OMRD;
  wire [4:0]NMA,Unity;
  wire InitNM,InitNMA,InitTens,InitUnity,CNMA,CTens,CUnity,WNM,RNM,WOM,ROM,LdOpcode,Co1,Co2,Co3;
  Register_8b R1(Tens,Clk,Rst,LdOpcode,Opcode);
  Counter_5b C1(CNMA,InitNMA,Clk,Rst,NMA,Co1);
  Counter_5b C2(CUnity,InitUnity,Clk,Rst,Unity,Co2);
  Counter_8b C3(CTens,InitTens,Clk,Rst,Tens,Co3);
  Adder_13b G1({Tens,5'h0},{8'h0,Unity},OMA);
  NameMemory G2(Name,NMA,WNM,RNM,InitNM,Clk,Rst,NMRD);
  OpcodeMemory G3(OMWD,OMA,WOM,ROM,Clk,Rst,OMRD);
  OC_Controller G4(Name,NMRD,OMRD,Start,Clk,Rst,Ready,InitNM,InitNMA,InitTens,InitUnity,CNMA,CTens,CUnity,WNM,RNM,ROM,LdOpcode);
endmodule






module OpcodeConvertor_TB();
  reg [7:0]Name;
  reg Start,Clk,Rst;
  wire [7:0]Opcode;
  wire Ready;
  OpcodeConvertor G1(Name,Start,Clk,Rst,Opcode,Ready);
  initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    Start=0;
    Rst=1;
    #100
    Rst=0;
    Start=1;
    #100
    Start=0;
    #100
    //num
    Name=8'h6E;
    #100
    Name=8'h75;
    #100
    Name=8'h6D;
    #100
    Name=8'h0;
    #100000
    $stop;
  end
endmodule