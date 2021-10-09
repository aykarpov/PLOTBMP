 type
      BmpHeader=record
                case boolean of
           true:(hdr:array [0..$35] of byte);
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
        biYPelPerMeter:longint; {2A вертикальное разрешение устройства,
                                пиксел/м}
        biClrUsed:longint;      {2E число используемых цветов}
        biClrImportant:longint; {32 число "важных" цветов});
        end { of record };
 var f:file;
     f2:text;
     i,j,sa,sz:longint;
     bh:BmpHeader;
     n:byte;
     colstab:array[0..255] of record
                              B,G,R,Y:byte;
                              end;
 begin
 assign(f,'hrap2.bmp');
 reset(f,1);
 blockread(f,bh,$36);
 sa:=bh.biSize+$0E;
 sz:=bh.bfOffbits-sa;
 assign(f2,'f.pas');
 rewrite(f2);
 for i:=$37 to sa do blockread(f,n,1);
 blockread(f,colstab,sz);
 j:=0;
 for i:=0 to 255 do with colstab[i] do begin
                                       write(f2,'(B:',B,';G:',G,';R:',R,';Y:',Y,'),');
                                       inc(j);
                                       if j=4 then begin
                                                    j:=0;
                                                    writeln(f2);
                                                    end;
                                       end;
 close(f);
 close(f2);
 end.
