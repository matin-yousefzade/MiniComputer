module MC_TB_Factorial();
  reg [31:0]ClientMemWrite,ClientMemAddr,ClientInsAddr;
  reg [4:0]ClientRegAddr;
  reg [1:0]CWDM,CRDM,CRIM;
  reg Start,InitPC,InitLNO,Clk,Rst;
  reg del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null;
  wire [31:0]ClientMemRead,ClientInsRead,ClientRegRead,WID;
  wire [7:0]CIMRD,AIMRD,Opcode;
  wire [5:0]ps;
  wire [4:0]CPUps;
  wire [3:0]Cps;
  wire Ready,CReady,CPUReady;
  MiniComputer G1(ClientMemWrite,ClientMemAddr,ClientInsAddr,ClientRegAddr,CWDM,CRDM,CRIM,Start,InitPC,InitLNO,Clk,Rst,del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null,ClientMemRead,ClientInsRead,ClientRegRead,WID,CIMRD,AIMRD,Opcode,ps,CPUps,Cps,Ready,CReady,CPUReady);
  initial begin
    Clk=0;
    forever begin
      #50 Clk=!Clk;
    end
  end
  initial begin
    {del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null}=128'h0;
    Start=0;
    Rst=1;
    #100
    Rst=0;
    InitPC=1;
    InitLNO=1;
    #100
    InitPC=0;
    InitLNO=0;
    Start=1;
    #100
    Start=0;
    #100
    //**********************************
    //**********************************
    //**********************************
    //label Loop
    //num x 1
    //num y 2
    //Loop:mlt Vx Vx Vy
    //add Vy Vy I1
    //ble Vy I6 LLoop
    //exit
    //**********************************
    //**********************************
    //**********************************
    //label Loop
    l=1;
    #100
    l=0;
    a=1;
    #100
    a=0;
    b=1;
    #100
    b=0;
    e=1;
    #100
    e=0;
    l=1;
    #100
    l=0;
    space=1;
    #100
    space=0;
    L=1;
    #100
    L=0;
    o=1;
    #100
    #100
    o=0;
    p=1;
    #100
    p=0;
    lf=1;
    #100
    lf=0;
    //num x 1
    n=1;
    #100
    n=0;
    u=1;
    #100
    u=0;
    m=1;
    #100
    m=0;
    space=1;
    #100
    space=0;
    x=1;
    #100
    x=0;
    space=1;
    #100
    space=0;
    n1=1;
    #100
    n1=0;
    lf=1;
    #100
    lf=0;
    //num y 2
    n=1;
    #100
    n=0;
    u=1;
    #100
    u=0;
    m=1;
    #100
    m=0;
    space=1;
    #100
    space=0;
    y=1;
    #100
    y=0;
    space=1;
    #100
    space=0;
    n2=1;
    #100
    n2=0;
    lf=1;
    #100
    lf=0;
    //Loop:mlt Vx Vx Vy
    L=1;
    #100
    L=0;
    o=1;
    #100
    #100
    o=0;
    p=1;
    #100
    p=0;
    colon=1;
    #100
    colon=0;
    m=1;
    #100
    m=0;
    l=1;
    #100
    l=0;
    t=1;
    #100
    t=0;
    space=1;
    #100
    space=0;
    V=1;
    #100
    V=0;
    x=1;
    #100
    x=0;
    space=1;
    #100
    space=0;
    V=1;
    #100
    V=0;
    x=1;
    #100
    x=0;
    space=1;
    #100
    space=0;
    V=1;
    #100
    V=0;
    y=1;
    #100
    y=0;
    lf=1;
    #100
    lf=0;
    //add Vy Vy I1
    a=1;
    #100
    a=0;
    d=1;
    #100
    #100
    d=0;
    space=1;
    #100
    space=0;
    V=1;
    #100
    V=0;
    y=1;
    #100
    y=0;
    space=1;
    #100
    space=0;
    V=1;
    #100
    V=0;
    y=1;
    #100
    y=0;
    space=1;
    #100
    space=0;
    I=1;
    #100
    I=0;
    n1=1;
    #100
    n1=0;
    lf=1;
    #100
    lf=0;
    //ble Vy I6 LLoop
    b=1;
    #100
    b=0;
    l=1;
    #100
    l=0;
    e=1;
    #100
    e=0;
    space=1;
    #100
    space=0;
    V=1;
    #100
    V=0;
    y=1;
    #100
    y=0;
    space=1;
    #100
    space=0;
    I=1;
    #100
    I=0;
    n6=1;
    #100
    n6=0;
    space=1;
    #100
    space=0;
    L=1;
    #100
    #100
    L=0;
    o=1;
    #100
    #100
    o=0;
    p=1;
    #100
    p=0;
    lf=1;
    #100
    lf=0;
    //exit
    e=1;
    #100
    e=0;
    x=1;
    #100
    x=0;
    i=1;
    #100
    i=0;
    t=1;
    #100
    t=0;
    etx=1;
    #1000000
    ClientInsAddr=32'h0;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h4;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h8;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'hC;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h10;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h14;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h18;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h1C;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h20;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h24;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h28;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h2C;
    CRIM=2'h3;
    #100  
    ClientInsAddr=32'h30;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h34;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h38;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h3C;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h40;
    CRIM=2'h3;
    #100  
    ClientInsAddr=32'h44;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h48;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h4C;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h50;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h54;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h58;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h5C;
    CRIM=2'h3;
    #100
    ClientInsAddr=32'h60;
    CRIM=2'h3;
    #100
    CRIM=2'h0;
    //************************************
    //************************************
    //************************************
    ClientMemAddr=32'h8000;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8001;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8002;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8003;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8004;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8005;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8006;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8007;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8008;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8009;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800A;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800B;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800C;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800D;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800E;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h800F;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8010;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8011;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8012;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8013;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8014;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8015;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8016;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8017;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8018;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h8019;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h801A;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h801B;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h801C;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h801D;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h801E;
    CRDM=2'h1;
    #100
    ClientMemAddr=32'h801F;
    CRDM=2'h1;
    #100
    $stop;
  end
endmodule