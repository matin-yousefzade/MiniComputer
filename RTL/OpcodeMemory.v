module OpcodeMemory(input [7:0]WriteData,input [12:0]Addr,input WOM,ROM,Clk,Rst,output reg [7:0]ReadData);
  reg [7:0]Memory[8191:0];
  integer i;
  always @(posedge Clk,posedge Rst) begin
      if (Rst) begin
        for(i=0;i<=8191;i=i+1) Memory[i]<=8'h0;
      end
      //add
      Memory[13'h0]<=8'h61;
      Memory[13'h1]<=8'h64;
      Memory[13'h2]<=8'h64;
      //adds
      Memory[13'h20]<=8'h61;
      Memory[13'h21]<=8'h64;
      Memory[13'h22]<=8'h64;
      Memory[13'h23]<=8'h73;
      //sub
      Memory[13'h40]<=8'h73;
      Memory[13'h41]<=8'h75;
      Memory[13'h42]<=8'h62;
      //subs
      Memory[13'h60]<=8'h73;
      Memory[13'h61]<=8'h75;
      Memory[13'h62]<=8'h62;
      Memory[13'h63]<=8'h73;
      //mlt
      Memory[13'h80]<=8'h6D;
      Memory[13'h81]<=8'h6C;
      Memory[13'h82]<=8'h74;
      //mlts
      Memory[13'hA0]<=8'h6D;
      Memory[13'hA1]<=8'h6C;
      Memory[13'hA2]<=8'h74;
      Memory[13'hA3]<=8'h73;
      //div
      Memory[13'hC0]<=8'h64;
      Memory[13'hC1]<=8'h69;
      Memory[13'hC2]<=8'h76;
      //divs
      Memory[13'hE0]<=8'h64;
      Memory[13'hE1]<=8'h69;
      Memory[13'hE2]<=8'h76;
      Memory[13'hE3]<=8'h73;
      //and
      Memory[13'h100]<=8'h61;
      Memory[13'h101]<=8'h6E;
      Memory[13'h102]<=8'h64;
      //or
      Memory[13'h120]<=8'h6F;
      Memory[13'h121]<=8'h72;
      //xor
      Memory[13'h140]<=8'h78;
      Memory[13'h141]<=8'h6F;
      Memory[13'h142]<=8'h72;
      //not
      Memory[13'h160]<=8'h6E;
      Memory[13'h161]<=8'h6F;
      Memory[13'h162]<=8'h74;
      //shr
      Memory[13'h180]<=8'h73;
      Memory[13'h181]<=8'h68;
      Memory[13'h182]<=8'h72;
      //shl
      Memory[13'h1A0]<=8'h73;
      Memory[13'h1A1]<=8'h68;
      Memory[13'h1A2]<=8'h6C;
      //ror
      Memory[13'h1C0]<=8'h72;
      Memory[13'h1C1]<=8'h6F;
      Memory[13'h1C2]<=8'h72;
      //rol
      Memory[13'h1E0]<=8'h72;
      Memory[13'h1E1]<=8'h6F;
      Memory[13'h1E2]<=8'h6C;
      //seq
      Memory[13'h200]<=8'h73;
      Memory[13'h201]<=8'h65;
      Memory[13'h202]<=8'h71;
      //sne
      Memory[13'h220]<=8'h73;
      Memory[13'h221]<=8'h6E;
      Memory[13'h222]<=8'h65;
      //sgt
      Memory[13'h240]<=8'h73;
      Memory[13'h241]<=8'h67;
      Memory[13'h242]<=8'h74;
      //sge
      Memory[13'h260]<=8'h73;
      Memory[13'h261]<=8'h67;
      Memory[13'h262]<=8'h65;
      //slt
      Memory[13'h280]<=8'h73;
      Memory[13'h281]<=8'h6C;
      Memory[13'h282]<=8'h74;
      //sle
      Memory[13'h2A0]<=8'h73;
      Memory[13'h2A1]<=8'h6C;
      Memory[13'h2A2]<=8'h65;
      //neg
      Memory[13'h2C0]<=8'h6E;
      Memory[13'h2C1]<=8'h65;
      Memory[13'h2C2]<=8'h67;
      //assign
      Memory[13'h2E0]<=8'h61;
      Memory[13'h2E1]<=8'h73;
      Memory[13'h2E2]<=8'h73;
      Memory[13'h2E3]<=8'h69;
      Memory[13'h2E4]<=8'h67;
      Memory[13'h2E5]<=8'h6E;
      //la
      Memory[13'h300]<=8'h6C;
      Memory[13'h301]<=8'h61;
      //lt
      Memory[13'h320]<=8'h6C;
      Memory[13'h321]<=8'h74;
      //******************************************
      //bnz
      Memory[13'h800]<=8'h62;
      Memory[13'h801]<=8'h6E;
      Memory[13'h802]<=8'h7A;
      //beq
      Memory[13'h820]<=8'h62;
      Memory[13'h821]<=8'h65;
      Memory[13'h822]<=8'h71;
      //bne
      Memory[13'h840]<=8'h62;
      Memory[13'h841]<=8'h6E;
      Memory[13'h842]<=8'h65;
      //bgt
      Memory[13'h860]<=8'h62;
      Memory[13'h861]<=8'h67;
      Memory[13'h862]<=8'h74;
      //bge
      Memory[13'h880]<=8'h62;
      Memory[13'h881]<=8'h67;
      Memory[13'h882]<=8'h65;
      //blt
      Memory[13'h8A0]<=8'h62;
      Memory[13'h8A1]<=8'h6C;
      Memory[13'h8A2]<=8'h74;
      //ble
      Memory[13'h8C0]<=8'h62;
      Memory[13'h8C1]<=8'h6C;
      Memory[13'h8C2]<=8'h65;
      //jmp
      Memory[13'h8E0]<=8'h6A;
      Memory[13'h8E1]<=8'h6D;
      Memory[13'h8E2]<=8'h70;
      //???
      //Memory[13'h900]<=
      //Memory[13'h901]<=
      //jal
      Memory[13'h920]<=8'h6A;
      Memory[13'h921]<=8'h61;
      Memory[13'h922]<=8'h6C;
      //*****************************************
      //ret
      Memory[13'h1000]<=8'h72;
      Memory[13'h1001]<=8'h65;
      Memory[13'h1002]<=8'h74;
      //exit
      Memory[13'h1020]<=8'h65;
      Memory[13'h1021]<=8'h78;
      Memory[13'h1022]<=8'h69;
      Memory[13'h1023]<=8'h74;
      //num
      Memory[13'h1040]<=8'h6E;
      Memory[13'h1041]<=8'h75;
      Memory[13'h1042]<=8'h6D;
      //char
      Memory[13'h1060]<=8'h63;
      Memory[13'h1061]<=8'h68;
      Memory[13'h1062]<=8'h61;
      Memory[13'h1063]<=8'h72;
      //label
      Memory[13'h1080]<=8'h6C;
      Memory[13'h1081]<=8'h61;
      Memory[13'h1082]<=8'h62;
      Memory[13'h1083]<=8'h65;
      Memory[13'h1084]<=8'h6C;
    if (WOM) Memory[Addr]<=WriteData;
    if (ROM) ReadData<=Memory[Addr];
  end
endmodule






module OpcodeMemory_TB();
  wire [12:0]Addr;
  wire [7:0]Res;
  reg [7:0]WriteData;
  reg WOM,ROM,C,Init,Clk,Rst;
  wire [7:0]ReadData;
  wire Co;
  assign Addr={Res,5'h0};
  Counter_8b G1(C,Init,Clk,Rst,Res,Co);
  OpcodeMemory G2(WriteData,Addr,WOM,ROM,Clk,Rst,ReadData);
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
    Init=1;
    #100
    Init=0;
    C=1;
    ROM=1;
    #90000
    $stop;
  end
endmodule