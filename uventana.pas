unit uventana;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, umatriz;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    SALIR: TButton;
    FIL: TEdit;
    COL: TEdit;
    ELE: TEdit;
    Label1: TLabel;
    SG: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure SALIRClick(Sender: TObject);
  private
    M:TMatriz;
    procedure updateSG();  //CTRL+SHIFT+C

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin                                     //BOTON CREAR
  M:=TMatriz.Crear();
  updateSG();
  showMessage('Matriz Creada...');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin                                      //BOTON SETFILS
  M.setFils(StrToInt(FIL.Text));
  updateSG();
  FIL.Text:='';
end;

procedure TForm1.SALIRClick(Sender: TObject);
begin
  close();
end;

procedure TForm1.Button3Click(Sender: TObject);
begin                                      //BOTON GETFILS
  FIL.Text:= IntToStr(M.getFils());
end;

procedure TForm1.Button4Click(Sender: TObject);
begin                                      //BOTON SETCOLS
   M.setcols(StrToInt(COL.Text));
   updateSG();
   COL.Text:='';
end;

procedure TForm1.Button5Click(Sender: TObject);
begin                                       //BOTON GET COLS
  COL.Text:= IntToStr(M.getCols());
end;

procedure TForm1.Button6Click(Sender: TObject);
begin                                      //BOTON SETELEM
  M.setElem(StrToInt(FIL.Text),StrToInt(COL.Text),StrToInt(ELE.Text));
  updateSG();
  FIL.Text:='';
  COL.Text:='';
  ELE.Text:='';
end;


procedure TForm1.Button7Click(Sender: TObject);
begin                                       //BOTON GETELEM
   ELE.Text:=IntToStr(M.getElem(StrToInt(FIL.Text),StrToInt(COL.Text)));
   FIL.Text:='';
   COL.Text:='';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin                                     //BOTON CARGAR
  M.cargar();
  updateSG();
end;

procedure TForm1.Button9Click(Sender: TObject);
begin                                      //BOTON MOSTRAR
  M.mostrar();
end;

procedure TForm1.Button10Click(Sender: TObject);
var                                         //BOTON BUSQSEC
  pfil,pcol:integer;
begin
  M.busqSec(StrToInt(ELE.Text),pfil,pcol);
  ELE.Text:='';
  FIL.Text:=IntToStr(pfil);
  COL.Text:=IntToStr(pcol);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin                                       //BOTON ORD-INTER
   M.ord_Inter();
   updateSG();
end;

procedure TForm1.Button12Click(Sender: TObject);
begin                                       //BOTON SUMDP
   ELE.Text := IntToStr(M.sumDP());
end;

procedure TForm1.Button13Click(Sender: TObject);
begin                                       //BOTON SUMTSD
   ELE.Text := IntToStr(M.sumTSD());
end;

procedure TForm1.Button14Click(Sender: TObject);
begin                                       //BOTON SUMTII
   ELE.Text := IntToStr(M.sumTII());
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  ELE.Text := IntToStr(M.sumTSI());
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  ELE.Text := IntToStr(M.sumTID());
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  ELE.Text := IntToStr(M.sumDS());
end;

procedure TForm1.Button18Click(Sender: TObject);
var
  m2:TMatriz;
begin
  m2 := TMatriz.crear();
  try
  m2.cargar();
  M.sumar(m2);
  updateSG();
  finally
  m2.Free;
  end;
end;

procedure TForm1.Button19Click(Sender: TObject);
var
  m2:TMatriz;
begin
  m2 := TMatriz.crear();
  try
  m2.cargar();
  M.restar(m2);
  updateSG();
  finally
  m2.Free;
  end;
end;

procedure TForm1.Button20Click(Sender: TObject);
var
  m2: TMatriz;
begin
  m2 := TMatriz.crear();
  m2.cargar();
  M.multiplicar(m2);
  updateSG();
  m2.Free;
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  M.invertir();
  updateSG();
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  ELE.Text := FloatToStr(Round(M.determinante()));
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
  M.transpuesta();
  updateSG();
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
  M.inversa();
end;

procedure TForm1.updateSG();
var
  f,c:integer;
begin
   SG.RowCount:=M.getFils();
   SG.ColCount:=M.getCols();
   for f:=1 to M.getFils() do
      for c:=1 to M.getCols do
         SG.Cells[c-1,f-1]:=IntToStr(M.getElem(f,c));
end;

end.

