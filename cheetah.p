//
// Cheetah, manually ported from Lazarus GUI to Modern Pascal CLI
//     www.ModernPascal.com
//

Uses
   Display;

Const
   CRLF=#13#10;
   Round1=" ,--."+CRLF+"/   |"+CRLF+"`|  |"+CRLF+" |  |"+CRLF+" `--'"+CRLF;
   Round2=" ,---."+CRLF+"'.-.  \"+CRLF+" .-' .'"+CRLF+"/   '-."+CRLF+"'-----'"+CRLF;
   Round3=",----."+CRLF+"  '.-.  |"+CRLF+"  .' <"+CRLF+"/'-'  |"+CRLF+"`----'"+CRLF;
   Spinner=['-','\','|','/'];

Procedure Introduction(No:Byte);
Begin
   CursorOff;
   ClrScr;
   TextColor(14);
   Write('Cheetah ');
   TextColor(12);
   Write('- ');
   TextColor(11);
   Write('Command line ');
   TextColor(14);
   Write('CLICKER ');
   TextColor(11);
   Writeln('application');
   Writeln();
   TextColor(7);
   Write('This clicker starts off with the');
   Case no of
      1:Writeln('two least used letters: Z and J');
      2:Writeln('three least used letters: X, V and Q');
      3:Writeln('four least used letters: Q, Z, J and V');
   End;
   Writeln('You must tap each, one after the other to earn "a click".');
   Writeln('Here we go...');
   GotoXy(1,24);
   TextBackground(4);
   TextColor(15);
   ClrEol;
   Write(' Press [ESCAPE] to give up!');
   TextBackground(0);
End;

function ismod(c:int64;w:byte):byte;
begin
   if c mod w=0 then begin
      result:=c div w;
   end
   else result:=0;
end;

Procedure StartRound(No:Byte);
var
   Ch,LastCh:Char;
   Spin:Longint;
   Click:Int64;

Begin
   Introduction(No);
   GotoXy(1,7);
   TextColor(14);
   Writeln('Round');
   TextColor(10);
   Case no of
      1:Begin
         Writeln(Round1);
         LastCh:='J';
         Click:=0;
      End;
      2:Begin
         Writeln(Round2);
         LastCh:='Q';
         Click:=101;
      End;
      3:Begin
         Writeln(Round3);
         LastCh:='V';
      End;
   End;
   TextColor(8);
   Spin:=0;
   While Ch<>#27 do begin
      GotoXy(1,15);
      Inc(Spin);
      Case Spin of
         100:Write(Spinner[0]);
         200:Write(Spinner[1]);
         300:Write(Spinner[2]);
         400:Begin
            Write(Spinner[3]);
            Spin:=0;
         End;
      End;
      If Keypressed then begin
         Ch:=Upcase(ReadKey);
         Case No of
            1:If (LastCh='J') and (Ch='Z') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End
              Else If (LastCh='Z') and (Ch='J') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End;
            2:If (LastCh='Q') and (Ch='X') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End
              Else If (LastCh='X') and (Ch='V') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End
              Else If (LastCh='V') and (Ch='Q') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End;
            3:If (LastCh='V') and (Ch='Q') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End
              Else If (LastCh='Q') and (Ch='Z') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End
              Else If (LastCh='Z') and (Ch='J') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End
              Else If (LastCh='J') and (Ch='V') then Begin
                 Inc(Click);
                 LastCh:=Ch;
              End;
         End;
         GotoXy(41,15);
         TextColor(9);
         Write('Clicks ');
         TextColor(12);
         Write(Click);
         Case no of
            1:Begin
              GotoXy(40+ismod(click,5),17);
              Case Click of
                 5,10,15,20,25:Begin
                    TextColor(12);
                    Write('#');
                 End;
                 30,35,40,45,50,55,60,65:Begin
                    TextColor(14);
                    Write('#');
                 End;
                 70,75,80,85,90,95,100:Begin
                    TextColor(10);
                    Write('#');
                 End;
              End;
            End;
            2:Begin
              GotoXy(40+ismod(click,100),17);
              Case Click of
                 102,200,300:Begin
                    TextColor(12);
                    Write('#');
                 End;
                 400,500,600,700:Begin
                    TextColor(14);
                    Write('#');
                 End;
                 800,900,1000:Begin
                    TextColor(10);
                    Write('#');
                 End;
              End;
            End;
         End;
         if click=100 then Begin
            StartRound(2);
            Exit;
         end
         else if click=1000 then Begin
            StartRound(3);
            Exit;
         End;
         TextColor(8);
      End
      Else Begin
         Yield(1);
      End;
   End;
End;

Begin
   StartRound(1);
   TextColor(7);
   CursorOn;
End.
