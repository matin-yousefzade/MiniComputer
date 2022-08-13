module bufif1_32b(input [31:0]A,input cs,output [31:0]W);
  assign W=cs?A:32'hz;
endmodule



//*********************************************************************************************************



module bufif1_8b(input [7:0]A,input cs,output [7:0]W);
  assign W=cs?A:8'hz;
endmodule



//*********************************************************************************************************



module bufif1_2b(input [1:0]A,input cs,output [1:0]W);
  assign W=cs?A:2'hz;
endmodule



//*********************************************************************************************************



module bufif1_1b(input A,input cs,output W);
  assign W=cs?A:1'hz;
endmodule