Unit ProceduresVarios;

interface

Procedure EscrDelay(tiempo:integer;cadena:string); {Pone un delay entre caracter y caracter al escribir una cadena por pantalla}

Procedure LeerINT (var Variable : integer);

implementation
  Uses

	crt;

Procedure EscrDelay(tiempo:integer;cadena:string);
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
		
		writeln;

end;


Procedure LeerINT (var Variable : integer);
	begin
						{$I-} 
						readln(Variable);
						{$I+}
				
						if IOResult<>0 then  
							begin  
								writeln;  
							end; 
	end;

end.
