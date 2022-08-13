module Keyboard(input [127:0]other,input del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null,output [7:0]char,output PAK);
  Encoder G1({other,del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null},char);
  assign PAK=|{other,del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null};
endmodule


module Keyboard_TB();
  reg [127:0]other;
  reg del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null;
  wire [7:0]char;
  wire PAK;
  Keyboard G1(other,del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null,char,PAK);
  initial begin
    {other,del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null}=256'h0;
    a=1;
    #1000
    a=0;
    b=1;
    #1000
    b=0;
    #1000
    s=1;
    #1000
    s=0;
    op=1;
    #1000
    op=0;
    x=1;
    #1000
    x=0;
    cp=1;
    #1000
    cp=0;
    lf=1;
    #1000
    lf=0;
    null=1;
    #1000
    null=0;
    #1000
    $stop;
  end
endmodule
//null,soh,stx,etx,eot,enq,ack,bel,bs,ht,lf,vt,ff,cr,so,si,dle,dc1,dc2,dc3,dc4,nak,syn,etb,can,em,sub,esc,fs,gs,rs,us,space,exclamation,doublequote,sharp,dollar,percent,ampersand,singlequote,op,cp,asterisk,plus,comma,minus,dot,slash,n0,n1,n2,n3,n4,n5,n6,n7,n8,n9,colon,semicolon,lt,equal,gt,question,atsign,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,osb,backslash,csb,hat,underline,backtick,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,ocb,pipe,ccb,tilde,del
//del,tilde,ccb,pipe,ocb,z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,backtick,undelrine,hat,csb,backslash,osb,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,atsign,question,gt,equal,lt,semicolon,colon,n9,n8,n7,n6,n5,n4,n3,n2,n1,n0,slash,dot,minus,comma,plus,asterisk,cp,op,singlequote,ampersand,percent,dollar,sharp,doublequote,exclamation,space,us,rs,gs,fs,esc,sub,em,can,etb,syn,nak,dc4,dc3,dc2,dc1,dle,si,so,cr,ff,vt,lf,ht,bs,bel,ack,enq,eot,etx,stx,soh,null