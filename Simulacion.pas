unit Simulacion;

interface

	Procedure MostrarMapa(var SalidaMapa:integer; var ruta:string);

	Procedure ImprLineasMapa(var lineatexto:string);

        Procedure ModifSimulacion(var SalidaMod:integer; var dias:integer);

        Procedure Pausa(var caracter:char);





implementation

	Uses

		crt,ProceduresVarios,MenuPcpal;

        Procedure Pausa(var caracter:char);

        begin
                repeat
                   //     delay(100);
                        until readkey='p';
                        end;

        Procedure ModifSimulacion(var SalidaMod:integer; var dias:integer);

        var I:integer;
                clchar:char;
                Salida:integer;
                begin

                clrscr;
                Salida:=1;
                writeln('Esto simboliza las cosas que ocurren dia a dia');
                writeln('Es el dia :');
                writeln;
                writeln;
                writeln('Presionar P para pausar');
                writeln('Presionar S para salir al menu');
                for I:=1 to dias do
                begin
                        gotoxy(12,2);
                        write(I);
                        delay(2000);
                        if keypressed then
                        begin
                                clchar:=readkey;
                                        if clchar='p' then
                                        Pausa(clchar);
                                        if clchar='s' then
                                        Menu(Salida);
                                        end;
                                        end;
                                        Menu(Salida);
                                        end;




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
			'0' : begin textbackground(brown);textcolor(7); write(lineatexto[I]); end;
			'1' : begin textbackground(green);textcolor(7); write(lineatexto[I]); end;
			'2' : begin textbackground(lightgreen);textcolor(7); write(lineatexto[I]); end;
			'3' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'4' : begin textbackground(lightgray);textcolor(7); write(lineatexto[I]); end;
			'5' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'6' : begin textbackground(brown);textcolor(7); write(lineatexto[I]); end;
			'7' : begin textbackground(lightgray);textcolor(7); write(lineatexto[I]); end;
			'8' : begin textbackground(magenta);textcolor(7); write(lineatexto[I]); end;
			'9' : begin textbackground(red);textcolor(7); write(lineatexto[I]); end;
		end;

		textbackground(black);


	end;
	end;



	Procedure MostrarMapa(var SalidaMapa:integer; var ruta:string);

	var

		texto:string;
		mundi:text;

	begin


		ClrScr;
		Assign(mundi, ruta);
		Reset(mundi);
		while not eof(mundi) do
		begin
			readln(mundi, texto);
			ImprLineasMapa(texto);
			writeln;
		end;



     //repeat
       //	LeerINT(SalidaMapa);
   //until ((SalidaMapa > 0) and (SalidaMapa < 3));
 //             case SalidaMapa of
 //        1 : Menu(SalidaMapa);   {guardar y volver al menu}
              //  end;

	end;

end.

