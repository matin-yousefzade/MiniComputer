module str2num_Controller(input [7:0]str,input Start,Clk,Rst,output reg Ready,InitN,InitFC,LdN,LdFC);
  parameter [1:0]Idle=2'h0,Init=2'h1,LoadFirstChar=2'h2,MultiplyAndAdd=2'h3;
  reg [1:0]ps,ns;
  always @(ps,Start,str) begin
    begin ns=Idle;{Ready,InitN,InitFC,LdN,LdFC}=5'h0; end
    case(ps)
      Idle:begin ns=Start?Init:Idle;Ready=1; end
      Init:begin ns=Start?Init:LoadFirstChar;InitN=1;InitFC=1; end
      LoadFirstChar:begin ns=MultiplyAndAdd;LdN=(8'h30<=str & str<=8'h39)?1:0;LdFC=1; end
      MultiplyAndAdd:begin ns=(str!=8'h0)?MultiplyAndAdd:Idle;LdN=(str!=8'h0)?1:0; end
      default:begin ns=Idle;{Ready,InitN,InitFC,LdN,LdFC}=5'h0; end
    endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule