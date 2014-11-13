Unit ProcVarios;

interface

Procedure EscrDelay(cadena:string; tiempo:integer); {Pone un delay entre caracter y caracter al escribir una cadena por pantalla}

implementation
  Uses

	crt;

Procedure EscrDelay(cadena:string; tiempo:integer);
var
        longitud:integer;
        I:integer;
begin
        longitud:=length(cadena);
        for I:=1 to longitud do
        begin
                write(cadena[I]);
                delay(tiempo);
                end;
                end;
                begin
                end.
