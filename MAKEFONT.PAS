  uses hexunit;

  var f:text;
      fnt:file of byte;

  procedure WriteFont(fn,an:string;N:byte);
   var i,j,k:byte;
   begin
   assign(fnt,fn);
   reset(fnt);
   writeln(f,'      '+an+':array[#0..#255] of array [0..',N,'] of byte=(');
   for i:=0 to 255 do
     begin
     write(f,'              (');
     for j:=0 to N do
       begin
       read(fnt,k);
       write(f,'$'+ByteToHex(k));
       if j<>N then write(f,',');
       end;
     write(f,')');
     if i<>255 then writeln(f,',')
               else writeln(f,');'#13#10);
     end;
   close(fnt);
   end;

   begin
   assign(f,'BmpFonts.pas');
   rewrite(f);
   writeln(f,'  unit BmpFonts;');
   writeln(f,'    interface');
   writeln(f,'      const');
   WriteFont('_08x08.fnt','Font8x8',7);
   WriteFont('_08x14.fnt','Font8x14',13);
   WriteFont('_08x16.fnt','Font8x16',15);
   writeln(f,'implementation');
   writeln(f,'end.');
   close(f);
   end.