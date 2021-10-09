 uses crt,BmpFonts;
 const FontOriginal=0.132*0.149;
       A4X=277;
       A4Y=190;

 type TCanvas=object
              PenThick:integer;
              FontN:integer;
              MemSize:longint;
              MaxX,MaxY,MaxBlock:word;
              StringLength:word;
              CanvPnt:array [0..1023] of pointer;
              PixPm:longint;
              constructor Create(X,Y:word);
              destructor Done;
              procedure PutElemPoint(X,Y:longint;Black:boolean);
              procedure PutPoint(X,Y:longint;Black:boolean);
              procedure WriteToBmpFile(fn:string);
              procedure Line(X1,Y1,X2,Y2:longint;Black:boolean);
              procedure Arc(Xc,Yc,X,Y:longint;Angle:integer;var xp,yp:longint);
              procedure PutChar(X,Y:longint;C:char;N:integer);
              procedure PutString(X,Y:longint;S:string;N:integer);
              procedure Circle(Xc,Yc,R:longint);
              end;

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

      BmpHeader=record
                case boolean of
           true:(hdr:array [0..$3D] of byte);
           false:(bfType:word;      { 0 тип файла (для битового образа - BM)}
                  bfSize:longint;   { 2 размер файла в dword}
                  bfReserved1:word; { 6 не используется}
                  bfReserved2:word; { 8 не используется}
                  bfOffbits:longint;{ A смещение данных битового образа от
                                        заголовка в байтах}

{    Непосредственно за ней располагается структура BITMAPINFO, со-
 держащая всю информацию о битовом образе. Она делится на две час-
 ти: структуру BITMAPINFOHEADER, описывающей  размеры  и  цветовой
 формат битового образа, и массив структур  RGBQUAD,  определяющей
 цветовую палитру:}

    {typedef struct tagBITMAPINFO
      BITMAPINFOHEADER     bmiHeader
       RGBQUAD              bmiColors[1] }
        biSize:longint;         {E число байт, занимаемых структурой
                                   BITMAPINFOHEADER}
        biWidth:longint;        {12 ширина битового образа в пикселах}
        biHeight:longint;       {16 высота битового образа в пикселах}
        biPlanes:word;          {1A число битовых плоскостей устройства}
        biBitCount:word;        {1C число битов на пиксель}
        biCompression:longint;  {1E тип сжатия}
        biSizeImage:longint;    {22 размер картинки в байтах}
        biXPelsPerMeter:longint;{26 горизонтальное разрешение устройства,
                                пиксел/м}
        biYPelsPerMeter:longint;{2A вертикальное разрешение устройства,
                                пиксел/м}
        biClrUsed:longint;      {2E число используемых цветов}
        biClrImportant:longint; {32 число "важных" цветов});
        end { of record };


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
   Sl:=trunc((trunc((MaxX-MinX+8)/8)+3)/4)*4;
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
   FontN:=1;
   PenThick:=2;
   MaxX:=X-1;
   MaxY:=Y-1;
   StringLength:=trunc((trunc((X+7)/8)+3)/4)*4;
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
                                    PutElemPoint(X+a*N+k,Y+b*N+m,true);
                       {$R-}
                       Mask:=Mask shr 1;
                       {$R+}
                       end;
      end;
   end;

 procedure TCanvas.PutElemPoint(X,Y:longint;Black:boolean);
   begin
   if (X>=0) and (X<=MaxX) and
      (Y>=0) and (Y<=MaxY) then
   begin
     asm
     mov ax,[bp+10h]
     mov bx,[bp+12h]
     mov cx,ax
     not cx
     and cx,111b
     mov dx,1
     shl dx,cl
     push dx
     rcr bx,1
     rcr ax,1
     rcr bx,1
     rcr ax,1
     rcr bx,1
     rcr ax,1
     and bx,0001111111111111b
     push bx
     push ax
     les di,[bp+06]
     mov ax,es:[di+StringLength]
     mov si,ax
     mov cx,[bp+0Ch]
     mov bx,[bp+0Eh]
     mul cx
     push dx
     push ax
     mov ax,si
     mul bx
     pop bx
     pop cx
     add ax,bx
     adc dx,cx
     pop bx
     pop cx
     add ax,bx
     adc dx,cx { Ad=StringLength*Y+X shr 3 }
     mov bx,ax
     and bx,0111111111111111b {BlockAd:=Ad mod 32768;}
     shl ax,1
     rcl dx,1 {BlockNum:=trunc(Ad/32768);}
     mov ax,dx
     shl ax,1
     shl ax,1
     les di,[bp+06h]
     add di,ax
     les di,es:[di+10h]
     add bx,di
     mov al,es:[bx]
     pop dx
     mov ah,dl
     cmp byte ptr [bp+0Ah],00
     je  @Black
     not ah
     and al,ah
     jmp @exit
@Black:or al,ah
@Exit: mov es:[bx],al
     end;
   end;
{  var Ad:longint;
      bt,k:byte;
      BlockNum,BlockAd:word;
   begin
   if (X>=0) and (X<=MaxX) and
      (Y>=0) and (Y<=MaxY) then
   begin
   bt:=7-X mod 8;
   Ad:=StringLength*Y+X shr 3;
   BlockNum:=trunc(Ad/32768);
   BlockAd:=Ad mod 32768;
   k:=Mem[Seg(CanvPnt[BlockNum]^):Ofs(CanvPnt[BlockNum]^)+BlockAd];
   bt:=1 shl bt;
   if Black then k:=k and not bt
            else k:=k or bt;
   Mem[Seg(CanvPnt[BlockNum]^):Ofs(CanvPnt[BlockNum]^)+BlockAd]:=k;
   end;
   end;}
   end;

 procedure TCanvas.PutPoint(X,Y:longint;Black:boolean);
  var i,j:longint;
      pt1,pt2:integer;
   begin
   pt1:=PenThick div 2;
   pt2:=PenThick-pt1-1;
   for i:=X-pt1 to X+Pt2 do
      for j:=Y-pt1 to Y+Pt2 do PutElemPoint(i,j,Black);
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
                       Line(xp,yp1,xi,y1,true);
                       Line(xp,yp2,xi,y2,true);
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
                        Line(Xp,Yp,Xt,Yt,true);
                        Xp:=Xt;
                        Yp:=Yt;
                        end;
   end;

 procedure TCanvas.Line(X1,Y1,X2,Y2:longint;Black:boolean);
  var dx,dy,px,py,ny,nx:longint;
      k,b:double;
   begin
   dx:=longint(X2)-X1;
   dy:=longint(Y2)-Y1;
   if dx>0 then px:=1 else px:=-1;
   if dy>0 then py:=1 else py:=-1;
   if (dx=0) and (dy=0) then PutPoint(X1,Y1,Black)
      else if abs(dx)<abs(dy) then begin
                                   ny:=Y1;
                                   k:=(X2-X1)/(Y2-Y1);
                                   b:=(Y2*X1-X2*Y1)/(Y2-Y1);
                                   repeat
                                   nx:=round(k*ny+b);
                                   PutPoint(nx,ny,Black);
                                   ny:=ny+py;
                                   until ny=Y2;
                                   nx:=round(k*ny+b);
                                   PutPoint(nx,ny,Black)
                                   end
                              else begin
                                   nx:=X1;
                                   k:=(Y2-Y1)/(X2-X1);
                                   b:=(X2*Y1-Y2*X1)/(X2-X1);
                                   repeat
                                   ny:=round(k*nx+b);
                                   PutPoint(nx,ny,Black);
                                   nx:=nx+px;
                                   until nx=X2;
                                   ny:=round(k*nx+b);
                                   PutPoint(nx,ny,Black)
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
    for i:=2 to $3D do header.hdr[i]:=0;
    header.hdr[0]:=$42;
    header.hdr[1]:=$4D;
    fsz:=fsz+62;
    header.bfSize:=fsz;
    Header.biWidth:=MaxX+1;
    Header.biHeight:=MaxY+1;
    header.hdr[$0A]:=$3E;
    header.hdr[$0E]:=$28;
    header.hdr[$1A]:=$1;
    header.hdr[$1C]:=$1;
    header.hdr[$3A]:=$FF;
    header.hdr[$3B]:=$FF;
    header.hdr[$3C]:=$FF;
    header.biXPelsPerMeter:=PixPm{ 5C41};{26 горизонтальное разрешение устройства}
    header.biYPelsPerMeter:=PixPm; {2A вертикальное разрешение устройства}
    blockwrite(fbmp,header.hdr,62);
    for i:=0 to longint(MaxBlock)-1 do blockwrite(fbmp,CanvPnt[i]^,32768);
    blockwrite(fbmp,CanvPnt[MaxBlock]^,MemSize-longint(32768)*MaxBlock);
    close(fbmp);
   end;

 const Pens:array[0..10] of byte=(1,2,5,2,2,2,2,2,2,2,2);
 var Canvas:TCanvas;
     Plotter:TPlotter;
     BmpName,PlotName:string;
     ok:boolean;
     Scl:double;
     SzX,SzY:longint;
     dpi,i:integer;
     Cm,S:string;
     CurX,CurY,X,Y,An:longint;
     TX,TY:longint;
     CurNum,MemSz:longint;
     Oldp,CurP:integer;
     n,t,cd:integer;
     scx,scy:real;
     np:boolean;
 begin
 MemSz:=0;
 dpi:=0;
 writeln;
 writeln(' *****************************************************************************');
 writeln('  Программа преобразования файлов для плоттера HP7475 в файл формата BitMap');
 writeln('                 Евстропов А. г.Орск, июнь 1998 г.');
 writeln(' *****************************************************************************');
 Oldp:=0;
 CurNum:=0;
 CurX:=0;
 CurY:=0;
 PlotName:=ParamStr(1);
 if PlotName='' then begin
                     writeln(' Запуск: plt2bmp.exe <имя plt файла> [имя bmp файла]');
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
   if (pos('/P',S)=1) then
     begin
     Val(S[3],n,cd);
     S:=Paramstr(i+1);
     Val(S,t,cd);
     Pens[n]:=t;
     inc(i);
     end else
   if (pos('/M',S)=1) then
     begin
     Val(S[3],n,cd);
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
 if MemSz<=0 then MemSz:=MaxAvail;
 writeln;
 writeln(' Исходный файл ',PlotName);
 write(' Идет оценка размера файла...');
 GotoXY(1,WhereY);
 Plotter.Create(PlotName,ok);
 if ok then
   begin
   with Plotter do
     if (MaxX<MinX) or (MaxY<MinY) then
        begin
        writeln(' Файл ',PlotName,' не является файлом плоттера !');
        halt(1);
        end;
   Scl:=Plotter.GetScale(MemSz)*0.9;
   if Scl>1 then Scl:=1;
   if MemSz>MaxAvail then
        begin
        writeln(' Указан слишком большой размер памяти: ',MemSz);
        halt(1);
        end;
   SzX:=trunc((Plotter.MaxX-Plotter.MinX+1)*Scl);
   SzY:=trunc((Plotter.MaxY-Plotter.MinY+1)*Scl);
   Canvas.Create(SzX,SzY);
   if dpi<>0 then Canvas.PixPm:=trunc(dpi/25.405*1000);
   writeln(' Используемая память: ',longint(32768)*(Canvas.MaxBlock+1),' байт');
   writeln(' Масштабный коэффициент: ',Scl:5:2);
   writeln(' Выходной файл ',BmpName);
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
                                             Canvas.Line(CurX,CurY,Tx,Ty,true);
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
                                            Canvas.Line(CurX,CurY,Tx,Ty,true);
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
                    else if Cm='SP' then
                                    begin
                                    Canvas.PenThick:=round(Pens[X]/10000*Canvas.PixPm);
                                    end
                    else if Cm='LB' then begin
                                         S:=copy(S,3,Length(S)-2);
                                         Canvas.PutString(CurX,CurY-Canvas.FontN,S,Canvas.FontN);
                                         end
                    else if Cm='SI' then begin
                                         Canvas.FontN:=round(sqrt(scx*scy/FontOriginal*82.76)*scl);
                                         end;
      end;
    if CurP>OldP then
       begin
       GotoXY(1,WhereY);
       write(' Преобразовано ',CurP,'%');
       OldP:=CurP;
       end;
    end;
   GotoXY(1,WhereY);
   write(' Записываю файл ',BmpName);
   GotoXY(1,WhereY);
   writeln(' Готово.                               ');
   Canvas.WriteToBmpFile(BmpName);
   Canvas.Done;
   end
   else writeln(' Файл ',PlotName,' не найден !                 ');
 Plotter.Done;
 writeln;
 end.