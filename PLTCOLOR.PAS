uses crt,BmpFonts;
 const
 A4X=277;
 A4Y=190;
 FontOriginal=0.132*0.149;
 Path:string='';
 ColorTable:array[0..255] of record
                            B,G,R,Y:byte;
                            end=(
(B:0;G:0;R:0;Y:0),(B:64;G:0;R:0;Y:0),(B:128;G:0;R:0;Y:0),(B:255;G:0;R:0;Y:0),
(B:0;G:32;R:0;Y:0),(B:64;G:32;R:0;Y:0),(B:128;G:32;R:0;Y:0),(B:255;G:32;R:0;Y:0),
(B:0;G:64;R:0;Y:0),(B:64;G:64;R:0;Y:0),(B:128;G:64;R:0;Y:0),(B:255;G:64;R:0;Y:0),
(B:0;G:96;R:0;Y:0),(B:64;G:96;R:0;Y:0),(B:128;G:96;R:0;Y:0),(B:255;G:96;R:0;Y:0),
(B:0;G:128;R:0;Y:0),(B:64;G:128;R:0;Y:0),(B:128;G:128;R:0;Y:0),(B:255;G:128;R:0;Y:0),
(B:0;G:160;R:0;Y:0),(B:64;G:160;R:0;Y:0),(B:128;G:160;R:0;Y:0),(B:255;G:160;R:0;Y:0),
(B:0;G:192;R:0;Y:0),(B:64;G:192;R:0;Y:0),(B:128;G:192;R:0;Y:0),(B:255;G:192;R:0;Y:0),
(B:0;G:255;R:0;Y:0),(B:64;G:255;R:0;Y:0),(B:128;G:255;R:0;Y:0),(B:255;G:255;R:0;Y:0),
(B:0;G:0;R:32;Y:0),(B:64;G:0;R:32;Y:0),(B:128;G:0;R:32;Y:0),(B:255;G:0;R:32;Y:0),
(B:0;G:32;R:32;Y:0),(B:64;G:32;R:32;Y:0),(B:128;G:32;R:32;Y:0),(B:255;G:32;R:32;Y:0),
(B:0;G:64;R:32;Y:0),(B:64;G:64;R:32;Y:0),(B:128;G:64;R:32;Y:0),(B:255;G:64;R:32;Y:0),
(B:0;G:96;R:32;Y:0),(B:64;G:96;R:32;Y:0),(B:128;G:96;R:32;Y:0),(B:255;G:96;R:32;Y:0),
(B:0;G:128;R:32;Y:0),(B:64;G:128;R:32;Y:0),(B:128;G:128;R:32;Y:0),(B:255;G:128;R:32;Y:0),
(B:0;G:160;R:32;Y:0),(B:64;G:160;R:32;Y:0),(B:128;G:160;R:32;Y:0),(B:255;G:160;R:32;Y:0),
(B:0;G:192;R:32;Y:0),(B:64;G:192;R:32;Y:0),(B:128;G:192;R:32;Y:0),(B:255;G:192;R:32;Y:0),
(B:0;G:255;R:32;Y:0),(B:64;G:255;R:32;Y:0),(B:128;G:255;R:32;Y:0),(B:255;G:255;R:32;Y:0),
(B:0;G:0;R:64;Y:0),(B:64;G:0;R:64;Y:0),(B:128;G:0;R:64;Y:0),(B:255;G:0;R:64;Y:0),
(B:0;G:32;R:64;Y:0),(B:64;G:32;R:64;Y:0),(B:128;G:32;R:64;Y:0),(B:255;G:32;R:64;Y:0),
(B:0;G:64;R:64;Y:0),(B:64;G:64;R:64;Y:0),(B:128;G:64;R:64;Y:0),(B:255;G:64;R:64;Y:0),
(B:0;G:96;R:64;Y:0),(B:64;G:96;R:64;Y:0),(B:128;G:96;R:64;Y:0),(B:255;G:96;R:64;Y:0),
(B:0;G:128;R:64;Y:0),(B:64;G:128;R:64;Y:0),(B:128;G:128;R:64;Y:0),(B:255;G:128;R:64;Y:0),
(B:0;G:160;R:64;Y:0),(B:64;G:160;R:64;Y:0),(B:128;G:160;R:64;Y:0),(B:255;G:160;R:64;Y:0),
(B:0;G:192;R:64;Y:0),(B:64;G:192;R:64;Y:0),(B:128;G:192;R:64;Y:0),(B:255;G:192;R:64;Y:0),
(B:0;G:255;R:64;Y:0),(B:64;G:255;R:64;Y:0),(B:128;G:255;R:64;Y:0),(B:255;G:255;R:64;Y:0),
(B:0;G:0;R:96;Y:0),(B:64;G:0;R:96;Y:0),(B:128;G:0;R:96;Y:0),(B:255;G:0;R:96;Y:0),
(B:0;G:32;R:96;Y:0),(B:64;G:32;R:96;Y:0),(B:128;G:32;R:96;Y:0),(B:255;G:32;R:96;Y:0),
(B:0;G:64;R:96;Y:0),(B:64;G:64;R:96;Y:0),(B:128;G:64;R:96;Y:0),(B:255;G:64;R:96;Y:0),
(B:0;G:96;R:96;Y:0),(B:64;G:96;R:96;Y:0),(B:128;G:96;R:96;Y:0),(B:255;G:96;R:96;Y:0),
(B:0;G:128;R:96;Y:0),(B:64;G:128;R:96;Y:0),(B:128;G:128;R:96;Y:0),(B:255;G:128;R:96;Y:0),
(B:0;G:160;R:96;Y:0),(B:64;G:160;R:96;Y:0),(B:128;G:160;R:96;Y:0),(B:255;G:160;R:96;Y:0),
(B:0;G:192;R:96;Y:0),(B:64;G:192;R:96;Y:0),(B:128;G:192;R:96;Y:0),(B:255;G:192;R:96;Y:0),
(B:0;G:255;R:96;Y:0),(B:64;G:255;R:96;Y:0),(B:128;G:255;R:96;Y:0),(B:255;G:255;R:96;Y:0),
(B:0;G:0;R:128;Y:0),(B:64;G:0;R:128;Y:0),(B:128;G:0;R:128;Y:0),(B:255;G:0;R:128;Y:0),
(B:0;G:32;R:128;Y:0),(B:64;G:32;R:128;Y:0),(B:128;G:32;R:128;Y:0),(B:255;G:32;R:128;Y:0),
(B:0;G:64;R:128;Y:0),(B:64;G:64;R:128;Y:0),(B:128;G:64;R:128;Y:0),(B:255;G:64;R:128;Y:0),
(B:0;G:96;R:128;Y:0),(B:64;G:96;R:128;Y:0),(B:128;G:96;R:128;Y:0),(B:255;G:96;R:128;Y:0),
(B:0;G:128;R:128;Y:0),(B:64;G:128;R:128;Y:0),(B:128;G:128;R:128;Y:0),(B:255;G:128;R:128;Y:0),
(B:0;G:160;R:128;Y:0),(B:64;G:160;R:128;Y:0),(B:128;G:160;R:128;Y:0),(B:255;G:160;R:128;Y:0),
(B:0;G:192;R:128;Y:0),(B:64;G:192;R:128;Y:0),(B:128;G:192;R:128;Y:0),(B:255;G:192;R:128;Y:0),
(B:0;G:255;R:128;Y:0),(B:64;G:255;R:128;Y:0),(B:128;G:255;R:128;Y:0),(B:255;G:255;R:128;Y:0),
(B:0;G:0;R:160;Y:0),(B:64;G:0;R:160;Y:0),(B:128;G:0;R:160;Y:0),(B:255;G:0;R:160;Y:0),
(B:0;G:32;R:160;Y:0),(B:64;G:32;R:160;Y:0),(B:128;G:32;R:160;Y:0),(B:255;G:32;R:160;Y:0),
(B:0;G:64;R:160;Y:0),(B:64;G:64;R:160;Y:0),(B:128;G:64;R:160;Y:0),(B:255;G:64;R:160;Y:0),
(B:0;G:96;R:160;Y:0),(B:64;G:96;R:160;Y:0),(B:128;G:96;R:160;Y:0),(B:255;G:96;R:160;Y:0),
(B:0;G:128;R:160;Y:0),(B:64;G:128;R:160;Y:0),(B:128;G:128;R:160;Y:0),(B:255;G:128;R:160;Y:0),
(B:0;G:160;R:160;Y:0),(B:64;G:160;R:160;Y:0),(B:128;G:160;R:160;Y:0),(B:255;G:160;R:160;Y:0),
(B:0;G:192;R:160;Y:0),(B:64;G:192;R:160;Y:0),(B:128;G:192;R:160;Y:0),(B:255;G:192;R:160;Y:0),
(B:0;G:255;R:160;Y:0),(B:64;G:255;R:160;Y:0),(B:128;G:255;R:160;Y:0),(B:255;G:255;R:160;Y:0),
(B:0;G:0;R:192;Y:0),(B:64;G:0;R:192;Y:0),(B:128;G:0;R:192;Y:0),(B:255;G:0;R:192;Y:0),
(B:0;G:32;R:192;Y:0),(B:64;G:32;R:192;Y:0),(B:128;G:32;R:192;Y:0),(B:255;G:32;R:192;Y:0),
(B:0;G:64;R:192;Y:0),(B:64;G:64;R:192;Y:0),(B:128;G:64;R:192;Y:0),(B:255;G:64;R:192;Y:0),
(B:0;G:96;R:192;Y:0),(B:64;G:96;R:192;Y:0),(B:128;G:96;R:192;Y:0),(B:255;G:96;R:192;Y:0),
(B:0;G:128;R:192;Y:0),(B:64;G:128;R:192;Y:0),(B:128;G:128;R:192;Y:0),(B:255;G:128;R:192;Y:0),
(B:0;G:160;R:192;Y:0),(B:64;G:160;R:192;Y:0),(B:128;G:160;R:192;Y:0),(B:255;G:160;R:192;Y:0),
(B:0;G:192;R:192;Y:0),(B:64;G:192;R:192;Y:0),(B:128;G:192;R:192;Y:0),(B:255;G:192;R:192;Y:0),
(B:0;G:255;R:192;Y:0),(B:64;G:255;R:192;Y:0),(B:128;G:255;R:192;Y:0),(B:255;G:255;R:192;Y:0),
(B:0;G:0;R:255;Y:0),(B:64;G:0;R:255;Y:0),(B:128;G:0;R:255;Y:0),(B:255;G:0;R:255;Y:0),
(B:0;G:32;R:255;Y:0),(B:64;G:32;R:255;Y:0),(B:128;G:32;R:255;Y:0),(B:255;G:32;R:255;Y:0),
(B:0;G:64;R:255;Y:0),(B:64;G:64;R:255;Y:0),(B:128;G:64;R:255;Y:0),(B:255;G:64;R:255;Y:0),
(B:0;G:96;R:255;Y:0),(B:64;G:96;R:255;Y:0),(B:128;G:96;R:255;Y:0),(B:255;G:96;R:255;Y:0),
(B:0;G:128;R:255;Y:0),(B:64;G:128;R:255;Y:0),(B:128;G:128;R:255;Y:0),(B:255;G:128;R:255;Y:0),
(B:0;G:160;R:255;Y:0),(B:64;G:160;R:255;Y:0),(B:128;G:160;R:255;Y:0),(B:255;G:160;R:255;Y:0),
(B:0;G:192;R:255;Y:0),(B:64;G:192;R:255;Y:0),(B:128;G:192;R:255;Y:0),(B:255;G:192;R:255;Y:0),
(B:0;G:255;R:255;Y:0),(B:64;G:255;R:255;Y:0),(B:128;G:255;R:255;Y:0),(B:255;G:255;R:255;Y:0));
  type
      BmpHeader=record
                case boolean of
           true:(hdr:array [0..$35] of byte);
           false:(bfType:word;      { 0 ⨯ 䠩�� (��� ��⮢��� ��ࠧ� - BM)}
                  bfSize:longint;   { 2 ࠧ��� 䠩�� � dword}
                  bfReserved1:word; { 6 �� �ᯮ������}
                  bfReserved2:word; { 8 �� �ᯮ������}
                  bfOffbits:longint;{ A ᬥ饭�� ������ ��⮢��� ��ࠧ� ��
                                        ��������� � �����}

{    �����।�⢥��� �� ��� �ᯮ�������� ������� BITMAPINFO, �-
 ��ঠ�� ��� ���ଠ�� � ��⮢�� ��ࠧ�. ��� ������� �� ��� ��-
 �: �������� BITMAPINFOHEADER, ����뢠�饩  ࠧ����  �  梥⮢��
 �ଠ� ��⮢��� ��ࠧ�, � ���ᨢ �������  RGBQUAD,  ��।����饩
 梥⮢�� �������:}

    {typedef struct tagBITMAPINFO
      BITMAPINFOHEADER     bmiHeader
       RGBQUAD              bmiColors[1] }
        biSize:longint;         {E �᫮ ����, ���������� ������ன
                                   BITMAPINFOHEADER}
        biWidth:longint;        {12 �ਭ� ��⮢��� ��ࠧ� � ���ᥫ��}
        biHeight:longint;       {16 ���� ��⮢��� ��ࠧ� � ���ᥫ��}
        biPlanes:word;          {1A �᫮ ��⮢�� ���᪮�⥩ ���ன�⢠}
        biBitCount:word;        {1C �᫮ ��⮢ �� ���ᥫ�}
        biCompression:longint;  {1E ⨯ ᦠ��}
        biSizeImage:longint;    {22 ࠧ��� ���⨭�� � �����}
        biXPelsPerMeter:longint;{26 ��ਧ��⠫쭮� ࠧ�襭�� ���ன�⢠,
                                ���ᥫ/�}
        biYPelsPerMeter:longint;{2A ���⨪��쭮� ࠧ�襭�� ���ன�⢠,
                                ���ᥫ/�}
        biClrUsed:longint;      {2E �᫮ �ᯮ��㥬�� 梥⮢}
        biClrImportant:longint; {32 �᫮ "������" 梥⮢});
        end { of record };

      TPlotter=object
               pltf:text;
               CurStr:string;
               MinX,MinY,MaxX,MaxY:longint;
               StrCount:longint;
               PenUp:boolean;
               Constructor Create(fn:string;var Ok:boolean);
               destructor Done;
               procedure SplitCommand(CS:string;var Cm:string;var X,Y,A:longint;var ScX,scY:real;var np:boolean);
               function ReadStr:boolean;
               function GetScale(MaxMem:longint):double;
               end;

      TCanvas=object
              PenThick:integer;
              FontN:integer;
              Color:byte;
              MemSize:longint;
              MaxX,MaxY,MaxBlock:word;
              StringLength:word;
              CanvPnt:array[0..1023] of pointer;
              PixPm:longint;
              constructor Create(X,Y:word);
              destructor Done;
              procedure PutElemPoint(X,Y:longint);
              procedure PutPoint(X,Y:longint);
              procedure WriteToBmpFile(fn:string);
              procedure Line(X1,Y1,X2,Y2:longint);
              procedure Arc(Xc,Yc,X,Y:longint;Angle:integer;var xp,yp:longint);
              procedure PutChar(X,Y:longint;C:char;N:integer);
              procedure PutString(X,Y:longint;S:string;N:integer);
              procedure Circle(Xc,Yc,R:longint);
              end;

 function FileNameWithNewExt(Fn,Ext:string):string;
 var i,l:integer;
  begin
  i:=Length(Fn);
  l:=i;
  while (i>0) and (Fn[i]<>'\') and (Fn[i]<>'.')do dec(i);
  if Fn[i]='.' then Delete(Fn,i,l-i+1);
  FileNameWithNewExt:=Fn+Ext;
  end;

 function TPlotter.GetScale(MaxMem:longint):double;
  var Sl,MemSize:longint;
   begin
   Sl:=trunc((MaxX-MinX+3)/4)*4;
   MemSize:=Sl*(MaxY-MinY+1);
   GetScale:=Sqrt(MaxMem/MemSize);
   end;

 constructor TPlotter.Create(fn:string;var ok:boolean);
  var
      cm,S:string;
      x,y,a:longint;
      scx,scy:real;
      np:boolean;
  begin
  {$I-}
  PenUp:=true;
  StrCount:=0;
  assign(pltf,fn);
  reset(pltf);
  ok:=IOResult=0;
  MinX:=2147483647;
  MinY:=2147483647;
  MaxX:=-2147483647;
  MaxY:=-2147483647;
  if ok then
  begin
  while not eof(pltf) do
    begin
    ReadStr;
    inc(StrCount);
    S:=CurStr;
    if (S<>'') then
      begin
      SplitCommand(S,Cm,X,Y,A,scx,scy,np);
      if not np and((Cm='PD') or (Cm='PU') or (Cm='PA')) then
        begin
        if X>MaxX then MaxX:=X
           else if X<MinX then MinX:=X;
        if Y>MaxY then MaxY:=Y
           else if Y<MinY then MinY:=Y;
        end;
      end;
    end;
  reset(pltf);
  MaxX:=MaxX+10;
  MaxY:=MaxY+10;
  end;
  end;

 destructor TPlotter.Done;
   begin
   {$I-}
   close(pltf);
   Repeat Until IOResult=0;
   end;

 procedure SkipFSpace(var S:string);
  var i,l:integer;
   begin
   l:=Length(S);
   i:=1;
   while (i<=l) and (S[i] in [' ',#9,#13,#10]) do inc(i);
   S:=copy(S,i,l+1-i);
   end;

 function FormatString(S:string):string;
  var s1:string;
      i:integer;
   begin
   SkipFSpace(S);
   S1:=copy(S,1,2);
   if S1='LB' then s1:=S
              else begin
                   s1:='';
                   for i:=1 to Length(S) do begin
                                            S[i]:=UpCase(S[i]);
                                            if S[i] in ['0'..'9','A'..'Z',',',';',#3,'-','.']
                                               then S1:=S1+S[i];
                                            end;
                   end;
   FormatString:=S1;
   end;

 function TPlotter.ReadStr:boolean;
  var c:char;
      tx:boolean;
   begin
   CurStr:='';
   if eof(pltf) then ReadStr:=false
      else begin
           repeat
           Read(pltf,c);
           until not (c in [' ',';',#13,#10]);
           CurStr:=c;
           Read(pltf,c);
           CurStr:=CurStr+c;
           tx:=CurStr='LB';
           if tx then begin
                      repeat
                      Read(pltf,c);
                      if c<>#3 then CurStr:=CurStr+c;
                      until (c=#3) or eof(pltf);
                      SkipFSpace(CurStr);
                      end
                 else begin
                      repeat
                      Read(pltf,c);
                      if c<>';' then CurStr:=CurStr+c;
                      until (c in [';',#13]) or eof(pltf);
                      if c=#13 then Read(pltf,c);
                      CurStr:=FormatString(CurStr);
                      end;
           ReadStr:=IOResult=0;
           end;
   end;

 procedure TPlotter.SplitCommand(CS:string;var Cm:string;var X,Y,A:longint;var scx,scy:real;var np:boolean);
  var i,l,k:byte;
      s:string;
      cd:word;
      si:boolean;
   begin
   X:=0;
   Y:=0;
   A:=0;
   scx:=0;
   scy:=0;
   np:=true;
   i:=1;
   l:=Length(CS);
   while (i<=l) and (CS[i] in ['A'..'Z']) do inc(i);
   Cm:=copy(CS,1,2);
   si:=Cm='SI';
   k:=i;
   while (i<=l) and (CS[i] in ['0'..'9','.','-']) do inc(i);
   S:=copy(CS,k,i-k);
   if si then Val(S,scx,cd)
         else Val(S,X,cd);
   np:=cd<>0;
   inc(i);
   k:=i;
   while (i<=l) and (CS[i] in ['0'..'9','.','-']) do inc(i);
   S:=copy(CS,k,i-k);
   if si then Val(S,scy,cd)
         else Val(S,Y,cd);
   np:=np or (cd<>0);
   inc(i);
   k:=i;
   while (i<=l) and (CS[i] in ['0'..'9','.','-']) do inc(i);
   S:=copy(CS,k,i-k);
   Val(S,A,cd);
   end;

 constructor TCanvas.Create(X,Y:word);
  var BlockCnt,i,j:word;
      px,py,L1,L2:longint;
   begin
   PenThick:=0;
   Color:=0;
   MaxX:=X-1;
   MaxY:=Y-1;
   StringLength:=trunc((X+3)/4)*4;
   MemSize:=longint(StringLength)*Y;
   BlockCnt:=trunc((MemSize+32767)/32768);
   MaxBlock:=BlockCnt-1;
   for i:=0 to MaxBlock do begin
                           GetMem(CanvPnt[i],32768);
                           for j:=0 to 32767 do Mem[Seg(CanvPnt[i]^):Ofs(CanvPnt[i]^)+j]:=$FF;
                           end;
    if MaxX>MaxY then begin
                      L1:=A4X;
                      L2:=A4Y;
                      end
                 else begin
                      L1:=A4Y;
                      L2:=A4X;
                      end;
    px:=trunc(MaxX/L1*1000);
    py:=trunc(MaxY/L2*1000);
    if px>py then px:=py;
    PixPm:=px;
   end;

 destructor TCanvas.Done;
  var i:word;
   begin
   for i:=0 to MaxBlock do FreeMem(CanvPnt[i],32768);
   end;

 procedure TCanvas.PutString(X,Y:longint;S:string;N:integer);
  var i:byte;
   begin
   for i:=1 to length(S) do
     begin
     PutChar(X+(i-1)*8*N,Y,S[i],N);
     end;
   end;

 procedure TCanvas.PutChar(X,Y:longint;C:Char;N:integer);
  var Mask:byte;
      a,b:longint;
      k,m:integer;
   begin
   for b:=0 to 7 do
      begin
      Mask:=128;
      for a:=0 to 7 do begin
                       if boolean(Mask and Font8x8[C][7-b])
                          then for k:=0 to N-1 do
                                  for m:=0 to N-1 do
                                    PutElemPoint(X+a*N+k,Y+b*N+m);
                       {$R-}
                       Mask:=Mask shr 1;
                       {$R+}
                       end;
      end;
   end;

 procedure TCanvas.Circle(Xc,Yc,R:longint);
  const ed:extended=1;
  var x0,xk,xi:longint;
      y1,y2,xp,yp1,yp2:longint;
      rs:extended;
   begin
   x0:=Xc-R;
   xk:=Xc+R;
   rs:=sqr(ed*R);
   xp:=x0;
   yp1:=round(sqrt(rs-sqr(ed*(xp-xc))));
   yp2:=yp1+Yc;
   yp1:=Yc-yp1;
   for xi:=x0+1 to xk do begin
                       y1:=round(sqrt(rs-sqr(ed*(xi-xc))));
                       y2:=y1+Yc;
                       y1:=Yc-y1;
                       Line(xp,yp1,xi,y1);
                       Line(xp,yp2,xi,y2);
                       yp1:=y1;
                       yp2:=y2;
                       xp:=xi;
                       end;
   end;

 procedure TCanvas.Arc(Xc,Yc,X,Y:longint;Angle:integer;var xp,yp:longint);
  const tp:extended=pi/180;
        ed:extended=1;
  var ang:extended;
      i,k:integer;
      Xt,Yt:longint;
      r:extended;
   begin
   if X=Xc then begin
                if Y<Yc then ang:=3/2*pi
                        else ang:=pi/2;
                end
           else ang:=arctan((Y-Yc)/(X-Xc));
   if X<Xc then ang:=ang+pi;
   if Angle<0 then begin
                   k:=-1;
                   Angle:=-Angle;
                   end
              else k:=1;
   r:=sqrt(sqr(ed*(X-Xc))+sqr(ed*(Y-Yc)));
   xp:=X;
   yp:=y;
   for i:=1 to Angle do begin
                        Xt:=Xc+round(r*cos(ang+tp*i*k));
                        Yt:=Yc+round(r*sin(ang+tp*i*k));
                        Line(Xp,Yp,Xt,Yt);
                        Xp:=Xt;
                        Yp:=Yt;
                        end;
   end;

 procedure TCanvas.PutElemPoint(X,Y:longint);
  var Ad:longint;
      BlockNum,BlockAd:word;
   begin
   if (X>=0) and (X<=MaxX) and
      (Y>=0) and (Y<=MaxY) then
       begin
       Ad:=StringLength*Y+X;
       BlockNum:=trunc(Ad/32768);
       BlockAd:=Ad mod 32768;
       Mem[Seg(CanvPnt[BlockNum]^):Ofs(CanvPnt[BlockNum]^)+BlockAd]:=Color;
       end;
   end;

 procedure TCanvas.PutPoint(X,Y:longint);
  var i,j:longint;
      pt1,pt2:integer;
   begin
   pt1:=PenThick div 2;
   pt2:=PenThick-pt1-1;
   for i:=X-pt1 to X+Pt2 do
      for j:=Y-pt1 to Y+Pt2 do PutElemPoint(i,j);
   end;

 procedure TCanvas.Line(X1,Y1,X2,Y2:longint);
  var dx,dy,px,py,ny,nx:longint;
      k,b:double;
   begin
   dx:=longint(X2)-X1;
   dy:=longint(Y2)-Y1;
   if dx>0 then px:=1 else px:=-1;
   if dy>0 then py:=1 else py:=-1;
   if (dx=0) and (dy=0) then PutPoint(X1,Y1)
      else if abs(dx)<abs(dy) then begin
                                   ny:=Y1;
                                   k:=(X2-X1)/(Y2-Y1);
                                   b:=(Y2*X1-X2*Y1)/(Y2-Y1);
                                   repeat
                                   nx:=round(k*ny+b);
                                   PutPoint(nx,ny);
                                   ny:=ny+py;
                                   until ny=Y2;
                                   nx:=round(k*ny+b);
                                   PutPoint(nx,ny)
                                   end
                              else begin
                                   nx:=X1;
                                   k:=(Y2-Y1)/(X2-X1);
                                   b:=(X2*Y1-Y2*X1)/(X2-X1);
                                   repeat
                                   ny:=round(k*nx+b);
                                   PutPoint(nx,ny);
                                   nx:=nx+px;
                                   until nx=X2;
                                   ny:=round(k*nx+b);
                                   PutPoint(nx,ny)
                                   end;
   end;

 procedure TCanvas.WriteToBmpFile(fn:string);
  var fbmp:file;
      i,fsz:longint;
      header:BmpHeader;
   begin
   assign(fbmp,fn);
   rewrite(fbmp,1);
   fsz:=longint(StringLength)*(MaxY+1);
    for i:=2 to $35 do header.hdr[i]:=0;
    header.hdr[0]:=$42;
    header.hdr[1]:=$4D;
    fsz:=fsz+$436;
    header.bfSize:=fsz;
    Header.biWidth:=MaxX+1;
    Header.biHeight:=MaxY+1;
    Header.bfOffbits:=$436;
    header.hdr[$0E]:=$28;
    header.hdr[$1C]:=$1;
    header.biPlanes:=1;          {1A �᫮ ��⮢�� ���᪮�⥩ ���ன�⢠}
    header.biBitCount:=8;        {1C �᫮ ��⮢ �� ���ᥫ�}
    header.biXPelsPerMeter:=PixPm{2E20};
    header.biYPelsPerMeter:=PixPm;
    blockwrite(fbmp,header.hdr,$36);
    blockwrite(fbmp,ColorTable,$400);
    for i:=0 to longint(MaxBlock)-1 do blockwrite(fbmp,CanvPnt[i]^,32768);
    blockwrite(fbmp,CanvPnt[MaxBlock]^,MemSize-longint(32768)*MaxBlock);
    close(fbmp);
   end;

 const Pens:array[0..15] of record
                            Th,Col:byte;
                            end=((Th:1;Col:0),
                                 (Th:2;Col:1),
                                 (Th:5;Col:2),
                                 (Th:2;Col:3),
                                 (Th:2;Col:4),
                                 (Th:2;Col:5),
                                 (Th:2;Col:6),
                                 (Th:2;Col:7),
                                 (Th:2;Col:8),
                                 (Th:2;Col:9),
                                 (Th:2;Col:10),
                                 (Th:2;Col:11),
                                 (Th:2;Col:12),
                                 (Th:2;Col:13),
                                 (Th:2;Col:14),
                                 (Th:2;Col:15));

procedure GetPath;
 var i:integer;
  begin
  Path:=Paramstr(0);
  i:=Length(Path);
  while (i>0) and (Path[i]<>'\') do dec(i);
  Path:=copy(Path,1,i);
  end;

 procedure ReadIniFile;
  var f:text;
      p,r,g,b,y,w:byte;
      s:string;
  begin
  s:=Path+'pltcolor.ini';
  assign(f,s);
  reset(f);
  if IOResult=0 then
  while not eof(f) do
   begin
   if not eoln(f) then read(f,p);
   if IOResult=0 then
    begin
    if not eoln(f) then read(f,w);
    if not eoln(f) then read(f,r);
    if not eoln(f) then read(f,g);
    if not eoln(f) then read(f,b);
    if not eoln(f) then begin
                        read(f,y);
                        Pens[p].Th:=w;
                        ColorTable[p].R:=r;
                        ColorTable[p].G:=g;
                        ColorTable[p].B:=b;
                        ColorTable[p].Y:=y;
                        end;
    end;
   readln(f);
   end;
  close(f);
  repeat until IOResult=0;
  end;

 var Canvas:TCanvas;
     Plotter:TPlotter;
     BmpName,PlotName:string;
     ok:boolean;
     Scl:double;
     SzX,SzY:longint;
     dpi,i,n:integer;
     Cm,S:string;
     CurX,CurY,X,Y:longint;
     TX,TY:longint;
     CurNum:longint;
     Oldp,CurP:integer;
     cd:integer;
     MemSz,An:longint;
     scx,scy:real;
     np:boolean;

 begin
 GetPath;
 ReadIniFile;
 MemSz:=0;
 dpi:=0;
 writeln;
 writeln(' *****************************************************************************');
 writeln('  �ணࠬ�� �८�ࠧ������ 䠩��� ��� ������ � 䠩� �ଠ� BitMap');
 writeln('                 ����ய�� �. �.���, ��५� 1998 �.');
 writeln(' *****************************************************************************');
 Oldp:=0;
 CurNum:=0;
 CurX:=0;
 CurY:=0;
 PlotName:=ParamStr(1);
 if PlotName='' then begin
                     writeln(' �����: plt2bmp.exe <��� plt 䠩��> [��� bmp 䠩��]');
                     writeln;
                     halt(1);
                     end;
 if pos('/',paramstr(2))=0 then BmpName:=paramstr(2)
                           else BmpName:='';
 if BmpName='' then BmpName:=FileNameWithNewExt(PlotName,'.bmp');
 i:=2;
 while (Paramstr(i)<>'') do
   begin
   S:=Paramstr(i);
   for n:=1 to length(S) do S[n]:=UpCase(S[n]);
   if (pos('/M',S)=1) then
     begin
     S:=Paramstr(i+1);
     Val(S,MemSz,cd);
     inc(i);
     end else
   if (pos('/D',S)=1) then
     begin
     Val(S[3],n,cd);
     S:=Paramstr(i+1);
     Val(S,dpi,cd);
     inc(i);
     end;
   inc(i);
   end;
 writeln;
 writeln(' ��室�� 䠩� ',PlotName);
 write(' ���� �業�� ࠧ��� 䠩��...');
 GotoXY(1,WhereY);
 Plotter.Create(PlotName,ok);
 if ok then
   begin
   with Plotter do
     if (MaxX<MinX) or (MaxY<MinY) then
        begin
        writeln(' ���� ',PlotName,' �� ���� 䠩��� ������ !');
        halt(1);
        end;
   if MemSz<=0 then MemSz:=MaxAvail;
   Scl:=Plotter.GetScale(MemSz)*0.9;
   if Scl>1 then Scl:=1;
   if MemSz>MaxAvail then
        begin
        writeln(' ������ ᫨誮� ����让 ࠧ��� �����: ',MemSz);
        halt(1);
        end;
   SzX:=trunc((Plotter.MaxX-Plotter.MinX+1)*Scl);
   SzY:=trunc((Plotter.MaxY-Plotter.MinY+1)*Scl);
   Canvas.Create(SzX,SzY);
   if dpi<>0 then Canvas.PixPm:=trunc(dpi/25.405*1000);
   writeln(' �ᯮ��㥬�� ������: ',longint(32768)*(Canvas.MaxBlock+1),' ����');
   writeln(' ����⠡�� �����樥��: ',Scl:5:2);
   writeln(' ��室��� 䠩� ',BmpName);
   while not eof(Plotter.pltf) do
    begin
    Plotter.ReadStr;
    inc(CurNum);
    CurP:=round(CurNum/Plotter.StrCount*100);
    S:=Plotter.CurStr;
    if (S<>'') then
      begin
      Plotter.SplitCommand(S,Cm,X,Y,An,scx,scy,np);
      if Cm='PU' then begin
                      Plotter.PenUp:=true;
                      if not np then begin
                                     CurX:=round(Scl*(X-Plotter.MinX));
                                     CurY:=round(Scl*(Y-Plotter.MinY));
                                     end
                      end
         else if Cm='PD' then begin
                              Plotter.PenUp:=false;
                              if not np then begin
                                             TX:=round(Scl*(X-Plotter.MinX));
                                             TY:=round(Scl*(Y-Plotter.MinY));
                                             Canvas.Line(CurX,CurY,Tx,Ty);
                                             CurX:=TX;
                                             CurY:=TY;
                                             end
                              end
         else if Cm='PA' then begin
                              if not np then
                              if Plotter.PenUp
                                       then begin
                                            CurX:=round(Scl*(X-Plotter.MinX));
                                            CurY:=round(Scl*(Y-Plotter.MinY));
                                            end
                                       else begin
                                            TX:=round(Scl*(X-Plotter.MinX));
                                            TY:=round(Scl*(Y-Plotter.MinY));
                                            Canvas.Line(CurX,CurY,Tx,Ty);
                                            CurX:=TX;
                                            CurY:=TY;
                                            end
                              end
                    else if Cm='CI' then begin
                                         X:=round(X*Scl);
                                         Canvas.Circle(CurX,CurY,X);
                                         end
                    else if Cm='AA' then begin
                                         X:=round((X-Plotter.MinX)*Scl);
                                         Y:=round((Y-Plotter.MinY)*Scl);
                                         Canvas.Arc(X,Y,CurX,CurY,An,CurX,CurY);
                                         end
                    else if Cm='SP' then begin
                                         Canvas.PenThick:=round(Pens[X].Th/10000*Canvas.PixPm);
                                         Canvas.Color:=Pens[X].Col;
                                         end
                    else if Cm='LB' then begin
                                         S:=copy(S,3,Length(S)-2);
                                         Canvas.PutString(CurX,CurY-Canvas.FontN,S,Canvas.FontN);
                                         end
                    else if Cm='SI' then begin
                                         Canvas.FontN:=trunc(sqrt(scx*scy/FontOriginal*82.76)*scl);
                                         if Canvas.FontN=0 then Canvas.FontN:=1;
                                         end;
      end;
    if CurP>OldP then
       begin
       GotoXY(1,WhereY);
       write(' �८�ࠧ����� ',CurP,'%');
       OldP:=CurP;
       end;
    end;
   GotoXY(1,WhereY);
   write(' �����뢠� 䠩� ',BmpName);
   GotoXY(1,WhereY);
   writeln(' ��⮢�.                               ');
   Canvas.WriteToBmpFile(BmpName);
   Canvas.Done;
   end
   else writeln(' ���� ',PlotName,' �� ������ !                 ');
  Plotter.Done;
  writeln;
  end.
