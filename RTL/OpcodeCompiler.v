module OpcodeCompiler(input [7:0]Opcode,input Start,Clk,Rst,output [31:0]CPUIns,output Ready,GiveIns);
  reg [31:0]Ins1,Ins2,Ins3;
  wire [31:0]CPUIns1,CPUIns2,CPUIns3;
  wire [1:0]SIns;
  wire LdIns;
  always @(Opcode) begin
    begin Ins1=32'h0;Ins2=32'h0;Ins3=32'h0; end
    case(Opcode)
      8'h0:begin Ins1={6'h1,5'h12,5'h13,5'h14,11'h0}; end
      8'h1:begin Ins1={6'h2,5'h12,5'h13,5'h14,11'h0}; end
      8'h2:begin Ins1={6'h5,5'h12,5'h13,5'h14,11'h0}; end
      8'h3:begin Ins1={6'h6,5'h12,5'h13,5'h14,11'h0}; end
      8'h4:begin Ins1={6'h9,5'h12,5'h13,5'h14,11'h0}; end
      8'h5:begin Ins1={6'hA,5'h12,5'h13,5'h14,11'h0}; end
      8'h6:begin Ins1={6'hD,5'h12,5'h13,5'h14,11'h0}; end
      8'h7:begin Ins1={6'hE,5'h12,5'h13,5'h14,11'h0}; end
      8'h8:begin Ins1={6'h11,5'h12,5'h13,5'h14,11'h0}; end
      8'h9:begin Ins1={6'h13,5'h12,5'h13,5'h14,11'h0}; end
      8'hA:begin Ins1={6'h15,5'h12,5'h13,5'h14,11'h0}; end
      8'hB:begin Ins1={6'h17,5'h12,5'h13,16'h0}; end
      8'hC:begin Ins1={6'h18,5'h12,5'h13,5'h14,11'h0}; end
      8'hD:begin Ins1={6'h19,5'h12,5'h13,5'h14,11'h0}; end
      8'hE:begin Ins1={6'h1A,5'h12,5'h13,5'h14,11'h0}; end
      8'hF:begin Ins1={6'h1B,5'h12,5'h13,5'h14,11'h0}; end
      8'h10:begin Ins1={6'h22,5'h12,5'h13,5'h14,11'h0}; end
      8'h11:begin Ins1={6'h23,5'h12,5'h13,5'h14,11'h0}; end
      8'h12:begin Ins1={6'h24,5'h12,5'h13,5'h14,11'h0}; end
      8'h13:begin Ins1={6'h25,5'h12,5'h13,5'h14,11'h0}; end
      8'h14:begin Ins1={6'h26,5'h12,5'h13,5'h14,11'h0}; end
      8'h15:begin Ins1={6'h27,5'h12,5'h13,5'h14,11'h0}; end
      8'h16:begin Ins1={6'h17,5'h12,5'h13,16'h0};Ins2={6'h3,5'h12,5'h12,16'h1}; end
      8'h17:begin Ins1={6'h1,5'h12,5'h13,16'h0}; end
      8'h18:begin Ins1={6'h1,5'h12,5'h13,16'h0}; end
      8'h19:begin Ins1={6'h1,5'h12,5'h13,16'h0}; end
      //*************************************************************************************************
      8'h40:begin Ins1={6'h28,5'h13,5'h14,16'h0}; end
      8'h41:begin Ins1={6'h22,5'h11,5'h13,5'h14,11'h0};Ins2={6'h28,5'h11,5'h15,16'h0}; end
      8'h42:begin Ins1={6'h23,5'h11,5'h13,5'h14,11'h0};Ins2={6'h28,5'h11,5'h15,16'h0}; end
      8'h43:begin Ins1={6'h24,5'h11,5'h13,5'h14,11'h0};Ins2={6'h28,5'h11,5'h15,16'h0}; end
      8'h44:begin Ins1={6'h25,5'h11,5'h13,5'h14,11'h0};Ins2={6'h28,5'h11,5'h15,16'h0}; end
      8'h45:begin Ins1={6'h26,5'h11,5'h13,5'h14,11'h0};Ins2={6'h28,5'h11,5'h15,16'h0}; end
      8'h46:begin Ins1={6'h27,5'h11,5'h13,5'h14,11'h0};Ins2={6'h28,5'h11,5'h15,16'h0}; end
      8'h47:begin Ins1={6'h29,5'h0,5'h13,16'h0}; end
      //8'h48:
      8'h49:begin Ins1={6'h2B,5'h0,5'h13,16'h0}; end
      8'h4A:begin Ins1={6'h1,5'h11,5'h13,5'h0,11'h0};Ins2={6'h1,5'h13,5'h14,5'h0,11'h0};Ins3={6'h1,5'h14,5'h11,5'h0,11'h0}; end
      //*************************************************************************************************
      8'h80:begin Ins1={6'h2A,5'h1F,21'h0}; end
      8'h81:begin Ins1={6'h3F,26'h0}; end
      //8'h82:
      //8'h83:
      //8'h84:
      default:begin Ins1=32'h0;Ins2=32'h0;Ins3=32'h0; end
    endcase
  end
  Register_32b R1(Ins1,Clk,Rst,LdIns,CPUIns1);
  Register_32b R2(Ins2,Clk,Rst,LdIns,CPUIns2);
  Register_32b R3(Ins3,Clk,Rst,LdIns,CPUIns3);
  Multiplexer_2s_32b M1(CPUIns1,CPUIns2,CPUIns3,32'h0,SIns,CPUIns);
  OCM_Controller G1(Opcode,Start,Clk,Rst,SIns,Ready,LdIns,GiveIns);
endmodule





module OpcodeCompiler_TB();
 reg [7:0]Opcode;
 reg Start,Clk,Rst;
 wire [31:0]CPUIns;
 wire Ready,GiveIns;
 OpcodeCompiler G1(Opcode,Start,Clk,Rst,CPUIns,Ready,GiveIns);
 initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
 end
 initial begin
   Opcode=8'h0;
   Start=0;
   Rst=1;
   #100
   Rst=0;
   Opcode=8'h4A;
   Start=1;
   #100
   Start=0;
   #1000
   Opcode=8'h41;
   Start=1;
   #100
   Start=0;
   #1000
   Opcode=8'h10;
   Start=1;
   #100
   Start=0;
   #1000
   $stop;
 end
endmodule