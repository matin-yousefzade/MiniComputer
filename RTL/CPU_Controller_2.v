module CPU_Controller_2(input [5:0]Opcode,input eq,ne,gt,ge,lt,le,nz,IFF,output reg [4:0]SALU,output reg [2:0]SWRD,output reg [1:0]SI,SPC);
  always @(Opcode,eq,ne,gt,ge,lt,le,nz,IFF) begin
    begin SALU=5'h0;SWRD=3'h0;SI=2'h0;SPC=2'h0; end
    case(Opcode)
      //6'h0:
      6'h1:begin SALU=5'h0;SI=2'h0; end
      6'h2:begin SALU=5'h1;SI=2'h0; end
      6'h3:begin SALU=5'h0;SI=2'h1; end
      6'h4:begin SALU=5'h1;SI=2'h2; end
      //************************************************************************
      6'h5:begin SALU=5'h2;SI=2'h0; end
      6'h6:begin SALU=5'h3;SI=2'h0; end
      6'h7:begin SALU=5'h2;SI=2'h1; end
      6'h8:begin SALU=5'h3;SI=2'h2; end
      //************************************************************************
      6'h9:begin SALU=5'h4;SI=2'h0; end
      6'hA:begin SALU=5'h5;SI=2'h0; end
      6'hB:begin SALU=5'h4;SI=2'h1; end
      6'hC:begin SALU=5'h5;SI=2'h2; end
      //************************************************************************
      6'hD:begin SALU=5'h6;SI=2'h0; end
      6'hE:begin SALU=5'h7;SI=2'h0; end
      6'hF:begin SALU=5'h6;SI=2'h1; end
      6'h10:begin SALU=5'h7;SI=2'h2; end
      //************************************************************************
      6'h11:begin SALU=5'h8;SI=2'h0; end
      6'h12:begin SALU=5'h8;SI=2'h1; end
      6'h13:begin SALU=5'h9;SI=2'h0; end
      6'h14:begin SALU=5'h9;SI=2'h1; end
      6'h15:begin SALU=5'hA;SI=2'h0; end
      6'h16:begin SALU=5'hA;SI=2'h1; end
      6'h17:begin SALU=5'hB;SI=2'h0; end
      //************************************************************************
      6'h18:begin SALU=5'hC; end
      6'h19:begin SALU=5'hD; end
      6'h1A:begin SALU=5'hE; end
      6'h1B:begin SALU=5'hF; end
      //************************************************************************
      //6'h1C:
      //6'h1D:
      //6'h1E:
      6'h1F:begin SWRD=3'h1; end
      6'h20:begin SWRD=3'h1; end
      6'h21:begin SWRD=3'h1; end
      //************************************************************************
      6'h22:begin SWRD=eq?3'h3:3'h2; end
      6'h23:begin SWRD=ne?3'h3:3'h2; end
      6'h24:begin SWRD=gt?3'h3:3'h2; end
      6'h25:begin SWRD=ge?3'h3:3'h2; end
      6'h26:begin SWRD=lt?3'h3:3'h2; end
      6'h27:begin SWRD=le?3'h3:3'h2; end
      //************************************************************************
      6'h28:begin SPC=nz?2'h1:2'h3; end
      //************************************************************************
      6'h29:begin SPC=IFF?2'h0:2'h1; end
      6'h2A:begin SPC=IFF?2'h0:2'h2; end
      6'h2B:begin SWRD=3'h4;SPC=IFF?2'h0:2'h1; end
      //************************************************************************
      6'h2C:begin SWRD=3'h5; end
      6'h2D:begin SWRD=3'h6; end
      //************************************************************************
      //6'h3F:
      default:begin SALU=5'h0;SWRD=3'h0;SI=2'h0;SPC=2'h0; end
    endcase
  end
endmodule