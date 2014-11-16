unit Simulacion;

interface

	Procedure MostrarMapa(var SalidaMapa:integer);

	Procedure ImprLineasMapa(var lineatexto:string);





implementation

	Uses

		crt,ProceduresVarios,MenuPcpal;

	Procedure ImprLineasMapa(var lineatexto:string);

	var
		I:integer;
		longitud:integer;
	begin
		longitud:=length(lineatexto);
		For I:=1 to longitud do
		begin

			case lineatexto[I] of
			' ' : begin textbackground(9); write(lineatexto[I]); end;
			'0' : begin textbackground(black); textcolor(7); write(lineatexto[I]); end;
			'1' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'2' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'3' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'4' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'5' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'6' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'7' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'8' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'9' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
		end;
                textbackground(black);


	end;
        end;



	Procedure MostrarMapa(var SalidaMapa:integer);

	var texto:string;
                mundi:text;
	begin


		ClrScr;
		Assign(mundi, 'c:\users\__\desktop\mapamundi.txt'); {placeholder}
		Reset(mundi);
		while not eof(mundi) do
		begin
			readln(mundi, texto);
			ImprLineasMapa(texto);
                        writeln;
		end;



		repeat
			LeerINT(SalidaMapa);
		until ((SalidaMapa > 0) and (SalidaMapa < 2));

		case SalidaMapa of
		1 : Menu(SalidaMapa);
		end;
			
	end;

end.
