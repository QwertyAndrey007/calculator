unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Stroka, number:string;
  ravno, comma: boolean;
  numbers, stepByStep: array of real;
  symbols: array of char;





implementation
 uses Unit2, Unit3, Unit4, Unit5;
{$R *.lfm}

{ TForm1 }


procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
   Form4.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Stroka := '2+2*2=6';
  Edit1.Text := Stroka;
  ravno := false;
  comma := false;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  Edit1.Clear();
  Stroka:='';
  comma := false;
  ravno := true;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  Stroka += '0';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  Stroka += '+';
   Edit1.Text := Stroka;
   comma := false;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  Stroka += '-';
   Edit1.Text := Stroka;
   comma := false;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  Stroka += '*';
   Edit1.Text := Stroka;
   comma := false;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  Stroka += '/';
   Edit1.Text := Stroka;
   comma := false;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  Stroka += '.';
   Edit1.Text := Stroka;
   comma := true;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
   Stroka := Edit1.Text;
   if Length(Stroka) <>0 then
   if (Ord(Stroka[Length(Stroka)]) = 44) or  (Ord(Stroka[Length(Stroka)]) = 46)then
    comma := false;
  Delete (Stroka, Length(Stroka), 1);
  Edit1.Text := Stroka;
end;

procedure TForm1.Button18Click(Sender: TObject);
var i, steps, specstep, nn:integer;
  answer:real;
  minus:boolean;

begin
  number := ''; steps := 0; specstep := 0; nn:=0; minus:=false; ravno := false;

    for i:=1 to Length(Stroka) do
    begin
    if (Stroka[i] = '+') or (Stroka[i] = '-') or (Stroka[i] = '*') or (Stroka[i] = '/')then
      steps +=1;
    if (Stroka[i] = '*') or (Stroka[i] = '/')then
       specstep +=1;
    end;

     SetLength(numbers, steps + 1);
     SetLength(symbols, steps);
     SetLength(stepByStep, specstep);

    for i:=1 to Length(Stroka) do
      begin
       if (Ord(Stroka[i]) >= 48) and (Ord(Stroka[i]) <= 57) then
        begin
         number += Stroka[i];
        end;
       if (Stroka[i] = '.') or (Stroka[i] = ',') then
       begin
         number += ',';
       end;
        if (Stroka[i] = '+') or (Stroka[i] = '-') or (Stroka[i] = '*') or (Stroka[i] = '/')then
        begin
          numbers[nn]:= StrToFloat(number);
          symbols[nn] := Stroka[i];
          number:='';
          nn +=1 ;
        end;
        if i = Length(Stroka) then
        begin
            numbers[nn] := StrToFloat(number);
          end;

      end;
      nn:=0;
    for i:=0 to  steps - 1 do
      begin
         if symbols[i] = '*' then
         begin
           if (symbols[i-1] = '+') or (symbols[i-1] = '-') or (i = 0)then
           begin
              stepByStep[nn] := numbers[i+1] * numbers[i]
           end
           else
              stepByStep[nn] := stepByStep[nn-1] * numbers[i+1];
          nn+=1;
         end;
         if symbols[i] = '/' then
         begin
           if numbers[i + 1] = 0.0 then
             begin
               Stroka := '';
               Edit1.Text:='';
               ravno := false;
               comma := false;
               ShowMessage('Деление на 0 недопустимо!');
               Form1.FormCreate(Form1);
               break;
             end
           else
           begin
             if (symbols[i-1] = '+') or (symbols[i-1] = '-') or (i = 0)then
              stepByStep[nn] := numbers[i] / numbers[i+1]
             else
              stepByStep[nn] := stepByStep[nn-1] / numbers[i+1];
           end;
           nn+=1;
         end;

      end;
      nn :=0;
      answer := 0.0;
      for i := 0 to steps - 1 do
        begin
          if i=0 then
            begin
              if symbols[0] = '+'then
                 begin
                    answer := numbers[0];
                    if i = steps - 1 then
                     answer += numbers[i+1]
                    else if (symbols[1] = '-') or (symbols[1] = '+') then
                     answer += numbers[i+1];
                   end;
              if symbols[0] = '-' then
                begin
                 answer := numbers[0];
                 if i = steps - 1 then
                 answer -= numbers[i+1]
                else if (symbols[1] = '-') or (symbols[1] = '+')   then
                  answer -= numbers[i+1]
                  else
                    minus := true;
                end;
              if (symbols[0] = '*') or (symbols[0] = '/') then
                begin
                  if i = steps - 1 then
                   answer := stepByStep[nn]
                else if (symbols[1] = '-') or (symbols[1] = '+')   then
                  answer := stepByStep[nn]
                else
                  nn +=1;
                end;
            end
          else
             begin
              if symbols[i] = '+' then
                begin
                    if i = steps - 1 then
                     answer += numbers[i+1]
                    else if (symbols[i+1] = '-') or (symbols[i+1] = '+') then
                     answer += numbers[i+1];
                   end;
               if symbols[i] = '-' then
                begin
                 if i = steps - 1 then
                 answer -= numbers[i+1]
                else if (symbols[i+1] = '-') or (symbols[i+1] = '+')   then
                  answer -= numbers[i+1]
                  else
                    minus := true;
                end;
               if (symbols[i] = '*') or (symbols[i] = '/') then
                begin
                  if i = steps - 1 then
                   begin
                   if minus then
                    begin
                      answer -=stepByStep[nn];
                      minus := false;
                      nn:=0;
                     end
                  else
                      begin answer +=stepByStep[nn]; nn:=0; end;
                      end
                  else if (symbols[i+1] = '-') or (symbols[i+1] = '+') then
                   begin
                       if minus then
                    begin
                      answer -=stepByStep[nn];
                      minus := false;
                      nn += 1;
                     end
                      else
                       begin answer +=stepByStep[nn]; nn +=1; end
                       end
                  else
                  begin
                    nn +=1;
                    end;
                   end;
                end;
            end;
      if (steps = 0) then answer := numbers[0];
      Edit1.Text := Stroka + '=' + FloatToStr(answer);
      Form2.Memo1.Lines.Add(Stroka);
      ravno := false;
      Stroka :='';
      comma := false;
      SetLength(numbers, 0);
      SetLength(symbols, 0);
      SetLength(stepByStep, 0);


end;





procedure TForm1.Button1Click(Sender: TObject);
begin
   Stroka += '1';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Stroka += '2';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   Stroka += '3';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Stroka += '4';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Stroka += '5';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Stroka += '6';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Stroka += '7';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Stroka += '8';
   Edit1.Text := Stroka;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Stroka += '9';
   Edit1.Text := Stroka;
end;

procedure TForm1.Edit1Change(Sender: TObject);
var i:integer;
begin
   comma := false;
  Stroka := Edit1.Text;
  if ((Length(Edit1.Text) > 0) and (ravno))then
  for i:=1 to Length(Edit1.Text) do
     begin
     If ((Ord(Edit1.Text[i]) < 42) or (Ord(Edit1.Text[i]) > 57)) then
      begin
        Delete (Stroka, i, 1);
        ShowMessage('Можно вводить только цифры и знаки действия (+, -, /, *)');
      end;
     if (Edit1.Text[i] = ',') or (Edit1.Text[i] = '.') then
      begin
       Stroka[i]:= ',';
        if comma then
         begin
        Delete (Stroka, i, 1);
        ShowMessage('Не может быть две и более запятых в одном числе'); comma := false;
         end;

     comma := true;
      end;

     if (Edit1.Text[i] = '+') or (Edit1.Text[i] = '*') or (Edit1.Text[i] = '-') or (Edit1.Text[i] = '/')then
     begin
      if (Edit1.Text[i - 1] = '+') or (Edit1.Text[i - 1] = '*') or (Edit1.Text[i - 1] = '-') or (Edit1.Text[i - 1] = '/')then
      begin
        ShowMessage('Не может быть два знака подряд');
        Delete (Stroka, i, 1);
      end;
       if (i=1)then
      begin
        ShowMessage('Перед знаком должно быть число');
        Delete (Stroka, i, 1);
      end;
      comma := false;
     end;

      end;
     Edit1.Text := Stroka;
     comma := false;
     ravno := true;
end;

end.

