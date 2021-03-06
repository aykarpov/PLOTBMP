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
        biYPelPerMeter:longint; {2A ���⨪��쭮� ࠧ�襭�� ���ன�⢠,
                                ���ᥫ/�}
        biClrUsed:longint;      {2E �᫮ �ᯮ��㥬�� 梥⮢}
        biClrImportant:longint; {32 �᫮ "������" 梥⮢});
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
