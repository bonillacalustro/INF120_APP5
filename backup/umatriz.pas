unit umatriz;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;
const
  MAX_FILS=5000;
  MAX_COLS=5000;
type

  { TMatriz }

  TMatriz = Class
    private
      elem:array[1..MAX_FILS,1..MAX_COLS]of integer;
      fils,cols:integer;
    public
      constructor crear();
      procedure setFils(fil:integer);
      function getFils():integer;
      procedure setCols(col:integer);
      function getCols():integer;
      procedure setElem(fil,col,ele:integer);
      function getElem(fil,col:integer):integer;
      procedure cargar();
      procedure mostrar();                         //CTRL+SHIFT+C
      procedure busqSec(ele:integer;var fil,col:integer);
      procedure ord_Inter();
      function sumDP():integer;
      function sumTSD():integer;
      function sumTII():integer;
      function sumTSI():integer;
      function sumTID():integer;
      function sumDS():integer;
      procedure sumar(m2:TMatriz);
      procedure restar(m2:TMatriz);
      procedure multiplicar(m2:TMatriz);
      procedure invertir();
      function determinante():real;
      procedure transpuesta();
      procedure inversa();
      //EXAMEN
      procedure transponerTriangulares();
  end;

implementation

{ TMatriz }

constructor TMatriz.crear();
var
  f,c:integer;
begin
   fils := 0;
   cols := 0;
   for f:=1 to MAX_FILS do
      for c:=1 to MAX_COLS do
         elem[f,c]:=0;
end;

procedure TMatriz.setFils(fil: integer);
begin
   if(fil>=0)AND(fil<=MAX_FILS)then
   	fils :=fil
   else
   	showMessage('Fila Fuera de Rango...');
end;

function TMatriz.getFils(): integer;
begin
   result := fils;
end;

procedure TMatriz.setCols(col: integer);
begin
   if(col>=0)AND(col<=MAX_COLS)then
   	cols :=col
   else
   	showMessage('Columna Fuera de Rango...');
end;

function TMatriz.getCols(): integer;
begin
  result := cols;
end;

procedure TMatriz.setElem(fil, col, ele: integer);
begin
  if(fil>=1)AND(fil<=fils)then
  begin
  	if(col>=1)AND(col<=cols)then
  		elem[ fil , col ]:= ele
  	else
  		showMessage('Columna Fuera de Rango...');
  end
  else
  	showMessage('Fila Fuera de Rango...');
end;

function TMatriz.getElem(fil, col: integer): integer;
begin
  if(fil>=1)AND(fil<=fils)then
  begin
  	if(col>=1)AND(col<=cols)then
  		result := elem[ fil , col ]
  	else
  		result := -999;
  end
  else
  	result := -999;
end;

procedure TMatriz.cargar();
var
  f,c:integer;
begin
  fils := StrToInt(inputBox('Matriz','Cantidad de Filas : ','0'));
  cols := StrToInt(inputBox('Matriz','Cantidad de Columnas : ','0'));
  for f:=1 to fils do
     for c:=1 to cols do
        elem[ f , c ] := StrToInt(inputBox('Matriz','M[ '+IntToStr(f)+','+IntToStr(c)+' ]= ','0'));
end;

procedure TMatriz.mostrar();
var
  f,c:integer;
  cad:string;
begin
  cad := '';
  for f:=1 to fils do
  begin
     cad := cad + '[ ';
     for c:=1 to cols-1 do
  	   cad := cad +IntToStr(elem[ f , c ])+#09;
     cad := cad +IntToStr(elem[ f , cols ]);
     cad := cad +' ]'+#10#13;
  end;
  showMessage(cad);
end;

procedure TMatriz.busqSec(ele: integer; var fil, col: integer);
var
  i,dim:integer;
  sw:boolean;
begin
  i   := 1;
  sw  := false;
  dim := fils*cols;
  while(i<=dim)AND(NOT sw)do
  begin
      fil := ((i-1) DIV cols)+1;
      col := ((i-1) MOD cols)+1;
      if(ele=elem[ fil , col ])then
          sw := true
      else
          i := i + 1;
  end;
  if(sw=false)then
  begin
    fil := -1;
    col := -1;
  end;
end;

procedure TMatriz.ord_Inter();
var
  dim,p,d,fp,cp,fd,cd,aux:integer;
begin
  dim := fils *cols ;
  for p:=1 to dim-1 do
      for d:=p+1 to dim do
      begin
          fp := ((p-1) DIV cols)+1;
          cp := ((p-1) MOD cols)+1;
          fd := ((d-1) DIV cols)+1;
          cd := ((d-1) MOD cols)+1;
          if(elem[ fd , cd ]<elem[ fp , cp ])then
          begin
              aux := elem[fd , cd];
              elem[fd , cd]:= elem[fp , cp];
              elem[fp , cp] := aux;
          end;
      end;
end;

function TMatriz.sumDP(): integer;
var
  sum,f:integer;
begin
  sum := 0;
  for f:=1 to fils do
         sum := sum + elem[ f , f ];
  result:= sum;
end;

function TMatriz.sumTSD(): integer;
var
  sum,f,c:integer;
begin
  sum := 0;
  for f:=1 to fils-1 do
  	for c:=f+1 to cols do
  		sum := sum+elem[ f , c ];
  result:= sum;
end;

function TMatriz.sumTII(): integer;
var
  sum,f,c:integer;
begin
  sum := 0;
  for f:=2 to fils do
  	for c:=1 to f-1 do
  		sum := sum+elem[ f , c ];
  result:= sum;
end;

function TMatriz.sumTSI(): integer;
var
  sum, f, c: integer;
begin
  sum := 0;
  for f := 1 to fils - 1 do
    for c := 1 to fils - f do
    begin
      sum := sum + elem[f, c];
    end;
  result:=sum
end;

function TMatriz.sumTID(): integer;
var
  sum, f, c: integer;
begin
  sum := 0;
  for f := 2 to fils do
    for c := (fils - f + 2) to cols do
    begin
      sum := sum + elem[f, c];
    end;
 result:=sum;
end;

function TMatriz.sumDS(): integer;
var
  sum,c,f:integer;
begin
  f:=1;
  sum:=0;
  for c:=fils downto 1 do
    begin
      sum:=sum+elem[f,c];
      f:=f+1
    end;
  result:=sum;
end;

procedure TMatriz.sumar(m2: TMatriz);
var
  f, c: integer;
begin
  if (fils = m2.getFils()) and (cols = m2.getCols()) then
  begin
    for f := 1 to fils do
      for c := 1 to cols do
        elem[f, c] := elem[f, c] + m2.getElem(f, c);
  end
  else
    showMessage('Las matrices deben tener las mismas dimensiones...');
end;

procedure TMatriz.restar(m2: TMatriz);
var
  f, c: integer;
begin
  if (fils = m2.getFils()) and (cols = m2.getCols()) then
  begin
    for f := 1 to fils do
      for c := 1 to cols do
        elem[f, c] := elem[f, c] - m2.getElem(f, c);
  end
  else
    showMessage('Las matrices deben tener las mismas dimensiones...');
end;

procedure TMatriz.multiplicar(m2: TMatriz);
var
  f, c, k, suma: integer;
  aux: array[1..100, 1..100] of integer;
begin
  if cols = m2.getFils() then
  begin
    // 1. Calcular el producto en la matriz temporal
    for f := 1 to fils do
      for c := 1 to m2.getCols() do
      begin
        suma := 0;
        for k := 1 to cols do
          suma := suma + (elem[f, k] * m2.getElem(k, c));
        aux[f, c] := suma;
      end;

    // 2. Actualizar dimensiones y volcar a la matriz original
    cols := m2.getCols();
    for f := 1 to fils do
      for c := 1 to cols do
        elem[f, c] := aux[f, c];
  end
  else
    showMessage('Las columnas de la matriz 1 deben ser iguales a las filas de la matriz 2...');
end;

procedure TMatriz.invertir();
var
  i, dim, f1, c1, f2, c2, aux: integer;
begin
  dim := fils * cols;
  for i := 1 to (dim DIV 2) do
  begin
    f1 := ((i - 1) DIV cols) + 1;
    c1 := ((i - 1) MOD cols) + 1;

    f2 := ((dim - i) DIV cols) + 1;
    c2 := ((dim - i) MOD cols) + 1;

    aux := elem[f1, c1];
    elem[f1, c1] := elem[f2, c2];
    elem[f2, c2] := aux;
  end;
end;

function TMatriz.determinante():real;
var
  f, c, k, n, intercambios: integer;
  factor, det, aux: real;
  mTemp: array[1..100, 1..100] of real;
begin
  if fils <> cols then
  begin
    showMessage('La Matriz debe ser cuadrada...');
    result := 0;
    exit;
  end;
  n := fils;
  intercambios := 0;

  for f := 1 to n do
    for c := 1 to n do
      mTemp[f, c] := elem[f, c];

  for k := 1 to n - 1 do
  begin
    if mTemp[k, k] = 0 then
    begin
      f := k + 1;
      while (f <= n) and (mTemp[f, k] = 0) do
        f := f + 1;

      if f > n then
      begin
        result := 0;
        exit;
      end;

      for c := 1 to n do
      begin
        aux := mTemp[k, c];
        mTemp[k, c] := mTemp[f, c];
        mTemp[f, c] := aux;
      end;
      intercambios := intercambios + 1;
    end;

    for f := k + 1 to n do
    begin
      factor := mTemp[f, k] / mTemp[k, k];
      for c := k to n do
        mTemp[f, c] := mTemp[f, c] - (factor * mTemp[k, c]);
    end;
  end;

  det := 1;
  for f := 1 to n do
    det := det * mTemp[f, f];

  if (intercambios MOD 2) <> 0 then
    det := -det;

  result := det;
end;

procedure TMatriz.transpuesta();
var
  f,c,aux:integer;
begin
  if(fils=cols)then
  begin
      for f:=1 to fils-1 do
      for c:=f+1 to cols do
      begin
        aux:=elem[f,c];
        elem[f,c]:=elem[c,f];
        elem[c,f]:=aux;
      end;
  end
  else
      showMessage('La Matriz debe ser cuadrada...');
end;

procedure TMatriz.inversa();
var
  f, c, k, n: integer;
  pivote, factor, aux: real;
  aug: array[1..100, 1..200] of real;
  cad: string;
begin
  if fils <> cols then
  begin
    showMessage('La Matriz debe ser cuadrada...');
    exit;
  end;

  if Round(determinante()) = 0 then
  begin
    showMessage('La matriz no tiene inversa (Determinante = 0)...');
    exit;
  end;

  n := fils;

  for f := 1 to n do
    for c := 1 to n do
    begin
      aug[f, c] := elem[f, c];
      if f = c then
        aug[f, c + n] := 1
      else
        aug[f, c + n] := 0;
    end;

  for k := 1 to n do
  begin
    if aug[k, k] = 0 then
    begin
      f := k + 1;
      while (f <= n) and (aug[f, k] = 0) do
        f := f + 1;

      for c := 1 to 2 * n do
      begin
        aux := aug[k, c];
        aug[k, c] := aug[f, c];
        aug[f, c] := aux;
      end;
    end;

    pivote := aug[k, k];
    for c := 1 to 2 * n do
      aug[k, c] := aug[k, c] / pivote;

    for f := 1 to n do
    begin
      if f <> k then
      begin
        factor := aug[f, k];
        for c := 1 to 2 * n do
          aug[f, c] := aug[f, c] - (factor * aug[k, c]);
      end;
    end;
  end;

  cad := 'Matriz Inversa:' + #13#10;
  for f := 1 to n do
  begin
    cad := cad + '[ ';
    for c := n + 1 to (2 * n) - 1 do
      cad := cad + FormatFloat('0.00', aug[f, c]) + '   ';
    cad := cad + FormatFloat('0.00', aug[f, 2 * n]) + ' ]' + #13#10;
  end;
  showMessage(cad);
end;

procedure TMatriz.transponerTriangulares();
var
  f,c,aux:integer;
begin
  if(fils=cols)then
  begin
    for f:=1 to fils-1 do
      for c:=1 to cols-f do
        if(f<>c)then
        begin
          aux:=elem[f,c];
          elem[f,c]:=elem[fils-c+1,cols-f+1];
          elem[fils-c+1,cols-f+1]:=aux;
        end;
  end
  else
    showMessage('La Matriz debe ser cuadrada...');
end;

end.

