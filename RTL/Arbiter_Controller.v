module Arbiter_Controller(input [7:0]FV,PV,input [2:0]ReadData,input Start,Clk,Rst,output reg WRF,DownShift,InitR,LdR,InitWRA,CWRA,SRA,LdGrt);
  parameter [2:0]Idle=3'h0,InitRegister=3'h1,WaitForChange=3'h2,DownShifting=3'h3,InitCounter=3'h4,FindEnd=3'h5,WriteNewRequest=3'h6,LoadGrant=3'h7;
  reg [2:0]ps,ns;
  always @(ps,FV,PV,ReadData,Start) begin
    begin ns=Idle;{WRF,DownShift,InitR,LdR,InitWRA,CWRA,SRA,LdGrt}=8'h0; end
    case(ps)
      Idle:begin ns=Start?InitRegister:Idle; end
      InitRegister:begin ns=Start?InitRegister:WaitForChange;InitR=1; end
      WaitForChange:begin ns=(FV>PV)?DownShifting:(FV<PV)?InitCounter:WaitForChange; end
      DownShifting:begin ns=LoadGrant;DownShift=1; end
      InitCounter:begin ns=FindEnd;InitWRA=1; end
      FindEnd:begin ns=(ReadData==3'h0)?WriteNewRequest:FindEnd;CWRA=(ReadData!=3'h0)?1:0;SRA=1; end
      WriteNewRequest:begin ns=LoadGrant;WRF=1; end
      LoadGrant:begin ns=WaitForChange;LdGrt=1;LdR=1; end
      default:begin ns=Idle;{WRF,DownShift,InitR,LdR,InitWRA,CWRA,SRA,LdGrt}=8'h0; end
    endcase
  end
  always @(posedge Clk,posedge Rst) begin
   if (Rst) ps<=Idle;
   else ps<=ns;
  end
endmodule