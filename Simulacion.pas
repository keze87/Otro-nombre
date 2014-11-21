unit Simulacion;

interface

	Procedure MostrarMapa(var SalidaMapa:integer; var ruta:string);

	Procedure ImprLineasMapa(var lineatexto:string);

	Procedure ModifSimulacion;

	//Procedure Pausa(var caracter:char);

implementation

	Uses

		crt,ProceduresVarios,MenuPcpal;

	Type

		TMatriz = record
				Codigo : char;
				end;

{	Procedure Pausa(var caracter:char);

	begin
		repeat

			//delay(100);
			until readkey='p';

		end;}

	Procedure ModifSimulacion;
	var

		i : integer;
		j : integer;
		k : integer;
		l : integer;
		m : integer;
		clchar : char;
		Salida : integer;
		Mapatriz : array [1..100,1..100] of TMatriz;
		topex : integer;
		topey : integer;
		aux : string;
		Mapa : text;

	begin
readkey;
		clrscr;
readkey;
		Salida := 1;
		i := 1;
//		CrearMatriz(Mapatriz,topex,topey);

		Assign(Mapa,'mapamundi.txt');
		reset(Mapa);

		topex := -213;

		m := 0;

		repeat

			readln(Mapa,aux);

			l := 0;

			m := m + 1;

			repeat

				l := l + 1;

				Mapatriz [l,m].Codigo := aux[l];

				if l > topex then
					topex := l;

			until l = length(aux);

		until EOF(Mapa);

		topey := m;


//		writeln('Esto simboliza las cosas que ocurren dia a dia');
		writeln('Dia : ');
		writeln; writeln;
//		writeln('Presionar P para pausar');
//		writeln('Presionar S para salir al menu');

		repeat
		begin

			gotoxy(12,2);
			write(i);
			delay(2000);

			for j := 1 to topey do
				for k := 1 to topex do
					write(Mapatriz[k,j].Codigo);

			if keypressed then
			begin

				clchar:=readkey;

				if clchar='p' then
				//Pausa(clchar);
				readkey;

				if clchar='s' then
				Menu(Salida);

			end;
		end;

		until 5<4;

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
			' ' : begin textbackground(black); write(lineatexto[I]); end;
			'0' : begin textbackground(black);textcolor(brown); write(lineatexto[I]); end;
			'1' : begin textbackground(black);textcolor(green); write(lineatexto[I]); end;
			'2' : begin textbackground(black);textcolor(lightgreen); write(lineatexto[I]); end;
			'3' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'4' : begin textbackground(black);textcolor(lightgray); write(lineatexto[I]); end;
			'5' : begin textbackground(black);textcolor(7); write(lineatexto[I]); end;
			'6' : begin textbackground(black);textcolor(brown); write(lineatexto[I]); end;
			'7' : begin textbackground(black);textcolor(lightgray); write(lineatexto[I]); end;
			'8' : begin textbackground(black);textcolor(magenta); write(lineatexto[I]); end;
			'9' : begin textbackground(black);textcolor(red); write(lineatexto[I]); end;
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
	//LeerINT(SalidaMapa);
	//until ((SalidaMapa > 0) and (SalidaMapa < 3));
	//case SalidaMapa of
	//1 : Menu(SalidaMapa);   {guardar y volver al menu}
	//end;

	end;

end.
