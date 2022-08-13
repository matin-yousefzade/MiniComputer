module OCM_Controller(input [7:0]Opcode,input Start,Clk,Rst,output reg [1:0]SIns,output reg Ready,LdIns,GiveIns);
 parameter [2:0]Idle=3'h0,Init=3'h1,LoadIns=3'h2,GiveIns1=3'h3,GiveIns2=3'h4,GiveIns3=3'h5;
 reg [2:0]ps,ns;
 always @(Opcode,Start,ps) begin
   begin ns=Idle;{Ready,LdIns,GiveIns}=3'h0; end
   case(ps)
     Idle:begin ns=Start?Init:Idle;Ready=1; end
     Init:begin ns=Start?Init:LoadIns; end
     LoadIns:begin ns=GiveIns1;LdIns=1; end
     GiveIns1:begin ns=GiveIns2;SIns=2'h0;GiveIns=((8'h0<=Opcode & Opcode<=8'h19) | (8'h40<=Opcode & Opcode<=8'h4C) | (8'h80<=Opcode & Opcode<=8'h81))?1:0; end
     GiveIns2:begin ns=GiveIns3;SIns=2'h1;GiveIns=(Opcode==8'h16 | (8'h41<=Opcode & Opcode<=8'h46) | Opcode==8'h4A)?1:0; end
     GiveIns3:begin ns=Idle;SIns=2'h2;GiveIns=(Opcode==8'h4A)?1:0; end
     default:begin ns=Idle;{Ready,LdIns,GiveIns}=3'h0; end
   endcase
 end
 always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule