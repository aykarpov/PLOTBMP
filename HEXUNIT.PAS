  unit HexUnit;

  interface

  type  SByte=String[2];
        PData=array[0..1] of pointer;

  function HexToByte(Simb:SByte):byte;
  function ByteToHex(X:byte):SByte;

  implementation

   Procedure PutByte(X:PData;Ind:word;bt:byte);
     begin
     if Ind>32767 then begin
                       dec(Ind,32768);
                       Mem[Seg(X[1]^):Ofs(X[1]^)+Ind]:=bt;
                       end
                  else Mem[Seg(X[0]^):Ofs(X[0]^)+Ind]:=bt;
     end;

   Function  GetByte(X:PData;Ind:word):Byte;
     begin
     if Ind>32767 then begin
                       dec(Ind,32768);
                       GetByte:=Mem[Seg(X[1]^):Ofs(X[1]^)+Ind];
                       end
                  else GetByte:=Mem[Seg(X[0]^):Ofs(X[0]^)+Ind];
     end;

   function ByteToHex(X:byte):SByte;
    var Hn,Ln:byte;
    function GetHex(A:byte):Char;
     begin
     if A in [0..9] then GetHex:=chr(48+A)
                    else GetHex:=chr(55+A);
     end;
    begin
    Hn:=X shr 4;
    Ln:=X and $0F;
    ByteToHex:=GetHex(Hn)+GetHex(Ln);
    end;

   function ChrNum(X:char):byte;
       var num:byte;
          begin
          num:=ord(X)-48;
          if num>9 then num:=num-7;
          ChrNum:=num;
          end;

   function HexToByte(Simb:Sbyte):byte;
          begin
          if Length(Simb)=1 then Simb:='0'+Simb;
          HexToByte:=ChrNum(Simb[1])*$10+ChrNum(Simb[2]);
          end;

   function HexNum(Simb1,Simb0:char):byte;
          begin
          HexNum:=ChrNum(Simb1)*$10+ChrNum(Simb0);
          end;

 procedure ReadHexFile(HexFileName:string; var X:PData;
                         var FirstAddr,LastAddr:word;var Err,NoFile,Can:boolean);
        var
             numbyte,amount,chksum:byte;
             StartAddr,checksum:word;
             HexFile:text;
             CurStr:string;
             EndAddr:longint;
        procedure internal;
         var index:word;
             i:longint;
             temp:byte;
         begin
         FirstAddr:=$FFFF;
         LastAddr:=$0000;
         NoFile:=true;
         Err:=true;
         assign(HexFile,HexFileName);
         repeat until IOResult=0;
         {$I-}
         reset(HexFile);
         if IOResult=0 then  NoFile:=false
                       else  begin
                             repeat until IOResult=0;
                             Exit;
                             end;
{         Can:=not TestOnChangeAndGo;}
         if  Can then exit;
         for i:=0 to $FFFF do PutByte(X,i,$FF);
          while not eof(HexFile) do
                begin
                readln(HexFile,CurStr);
                if Curstr=':00000001FF'
                   then begin
                        if LastAddr>=FirstAddr then Err:=false;
                        Exit;
                        end;
                if (CurStr[1]<>':')or(Curstr[8]<>'0')or(CurStr[9]<>'0')
                   then  Exit;
                amount:=HexNum(CurStr[2],CurStr[3]);
                StartAddr:=$100*HexNum(Curstr[4],CurStr[5])+
                                  HexNum(CurStr[6],CurStr[7]);
                EndAddr:=longInt(StartAddr)+amount-1;
                checksum:=0;
                for i:=0 to 3 do
                  checksum:=checksum+HexNum(CurStr[2*i+2],CurStr[2*i+3]);
                numbyte:=10;
                for i:=StartAddr to EndAddr do
                     begin
                     index:=word(i);
                     if index<FirstAddr then FirstAddr:=index;
                     if index>LastAddr then LastAddr:=index;
                     temp:=HexNum(CurStr[numbyte],CurStr[numbyte+1]);
                     numbyte:=numbyte+2;
                     checksum:=checksum+temp;
                     PutByte(X,index,temp);
                     end;
                checksum:=(((not checksum) and $FF)+1) and $FF;
                chksum:=HexNum(CurStr[numbyte],CurStr[numbyte+1]);
                if checksum<>chksum then Exit;
                end;
         end;
      begin
      internal;
      if not NoFile then close(HexFile);
      end;

end.
