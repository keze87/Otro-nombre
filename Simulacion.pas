unit Simulacion;

interface

type

	TRegMatriz = record
			Codigo : char;
			Descripcion : string;
			caracter : char;
			CantSuceptibles : real;
			CantInfectados : real;
			CantZombies : real;
			TasaNatalidad : real;
			FactorMovilidad : real;
			end;

	TMatriz = array[1..100,1..100] of TRegMatriz;

	Procedure MostrarMapa(var SalidaMapa:integer; var ruta:string);

	Procedure ImprLineasMapa(var lineatexto:string);

	Procedure ModifSimulacion(ruta:string);

	Procedure MostrarPoblaciones;

	Procedure CrearMatriz(var MatrizMapa:TMatriz);

	Procedure DibujarMatriz (var Mapatriz : TMatriz ; topex : integer ; topey : integer ; x : integer ; y : integer);

	Procedure Pausa(var caracter:char);

implementation

	Uses

		crt,ProceduresVarios,MenuPcpal;

	Type

{		TMatriz = record
				Codigo : char;
				Descripcion : string;
				end;}

		TPoblaciones = record
		PuntoX : integer;
		PuntoY : integer;
		Descripcion : string[30];
		CantSuceptibles : longInt;
		CantInfectados : longInt;
		CantZombies : longInt;
		TasaNatalidad : real;
		FactorMovilidad : real;
		end;


	TFactores = record
		Codigo{de factor} : string[2];
		Descripcion : string[30];
		Valor : real;
		end;

	Procedure Pausa(var caracter:char);
        var
                key:char;
                i:integer;
                j:integer;

	begin
                j:=1;
                i:=1;
		repeat
			//delay(100);
                     {   if keypressed then
				begin     }
                                repeat

                                until keypressed;
					    key:=readkey;
          					if  (key = #0) then
          					begin
              						key:=readkey;
              							case key of
                   						#72 : if j>1 then begin j:=j-1; gotoxy(i,j); end;
                   						#80 : begin j:=j+1; gotoxy(i,j); end;
                   						#75 : if i>1 then begin i:=i-1; gotoxy(i,j); end;
                   						#77 : begin i:=i+1; gotoxy(i,j); end;
								end;
                                                         {       end;   }


				end;

			until key='p';
		end;

	Procedure DibujarMatriz (var Mapatriz : TMatriz ; topex : integer ; topey : integer ; x : integer ; y : integer);
		var

			k : integer;
			j : integer;

		begin

			clrscr;
			for j := 1 to topey-1 do //Experimental
				begin

					for k := 1 to topex do
					begin

						if ((k = x) and (j = y)) then
							textbackground(green);
						if ((k <> x) or (j <> y)) then
							textbackground(black);

						case Mapatriz[k,j].Codigo of

							' ' : begin write(Mapatriz[k,j].Codigo); end;
							'0' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;
							'1' : begin textcolor(green); write(Mapatriz[k,j].Codigo); end;
							'2' : begin textcolor(lightgreen); write(Mapatriz[k,j].Codigo); end;
							'3' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;
							'4' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;
							'5' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;
							'6' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;
							'7' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;
							'8' : begin textcolor(magenta); write(Mapatriz[k,j].Codigo); end;
							'9' : begin textcolor(red); write(Mapatriz[k,j].Codigo); end;

						end;

					end;
				writeln;
				end;
	end;

	Procedure CrearMatriz(Var MatrizMapa : TMatriz);
		var

			Mapa : text;
			aux : string;
			i : integer;
			j : integer;
			regPoblacion : TPoblaciones;
			Poblaciones: file of TPoblaciones;

		begin

			j:=1;

			Assign(Mapa,'mapamundi.txt');
			Assign(Poblaciones,'poblaciones.DAT');
			reset(Mapa);

			while not eof(Mapa) do
			begin

				readln(Mapa,aux);

				for i:=1 to length(aux) do
				begin

					MatrizMapa[i,j].caracter := aux[i];
					j:=j+1;

				end;

			end;

			close(Mapa);

			reset(Poblaciones);

			while not eof(Poblaciones) do
			begin

				read(Poblaciones,regPoblacion);
				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].CantSuceptibles:=regPoblacion.CantSuceptibles;
				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].CantInfectados:=regPoblacion.CantInfectados;
				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].CantZombies:=regPoblacion.CantZombies;
				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].TasaNatalidad:=regPoblacion.TasaNatalidad;
				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].FactorMovilidad:=regPoblacion.FactorMovilidad;

			end;

			close(Poblaciones);

end;

	Procedure MostrarPoblaciones;
		var

			x : integer;
			y : integer;
			l : integer;
			m : integer;
			Mapatriz : array [1..100,1..100] of TRegMatriz;
			topex : integer;
			topey : integer;
			aux : string;
			Mapa : text;
			Poblaciones : file of TPoblaciones;
			auxP : TPoblaciones;
			clchar : char;

		begin

			//clrscr;

			Assign(Mapa,'mapamundi.txt');
			reset(Mapa);

			Assign(Poblaciones,'Poblaciones.DAT');

			topex := -213;

			m := 0;

			repeat

				readln(Mapa,aux);

				l := 0;

				m := m + 1;

				repeat

					l := l + 1;

					reset(Poblaciones);

					repeat

						read(Poblaciones,auxP);

					until ((auxP.PuntoX = l) and (auxP.PuntoY = m));

					Mapatriz [l,m].Codigo := aux[l];
					Mapatriz [l,m].Descripcion := auxP.Descripcion;

					close(Poblaciones);

					if l > topex then
						topex := l;

				until l = length(aux);

			until EOF(Mapa);

			topey := m;
			writeln;

			x := 1;
			y := 1;

			DibujarMatriz(Mapatriz,topex,topey,x,y);

			repeat

{			for j := 1 to topey-1 do //Experimental
				begin
					for k := 1 to topex do
					begin
						if ((k = x) and (j = y)) then
							textbackground(green);
						if ((k <> x) or (j <> y)) then
							textbackground(black);
						case Mapatriz[k,j].Codigo of
							' ' : begin write(Mapatriz[k,j].Codigo); end;
							'0' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;
							'1' : begin textcolor(green); write(Mapatriz[k,j].Codigo); end;
							'2' : begin textcolor(lightgreen); write(Mapatriz[k,j].Codigo); end;
							'3' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;
							'4' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;
							'5' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;
							'6' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;
							'7' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;
							'8' : begin textcolor(magenta); write(Mapatriz[k,j].Codigo); end;
							'9' : begin textcolor(red); write(Mapatriz[k,j].Codigo); end;
						end;
					end;
				writeln;
				end;}

			repeat

				if keypressed then
					begin

					clchar:=readkey;

					if ((clchar = Char(77)) and (x < topex-1)) then
					begin

						x := x + 1;
						clrscr;
						DibujarMatriz(Mapatriz,topex,topey,x,y);
						window(1,1,80,250);

					end;

					if ((clchar = Char(80)) and (y < topey-1)) then
					begin

						y := y + 1;
						clrscr;
						DibujarMatriz(Mapatriz,topex,topey,x,y);
						window(1,1,80,250);

					end;

					if ((clchar = Char(72)) and (y > 1)) then
					begin

						y := y - 1;
						clrscr;
						DibujarMatriz(Mapatriz,topex,topey,x,y);
						window(1,1,80,250);

					end;

					if ((clchar = Char(75)) and (x > 1)) then
					begin

						x := x - 1;
						clrscr;
						DibujarMatriz(Mapatriz,topex,topey,x,y);
						window(1,1,80,250);

					end;


				end;

				clrscr;
				DibujarMatriz(Mapatriz,topex,topey,x,y);
				Window(30,20,50,250);
				//writeln(x,' ',y);
				writeln(x,' ',y,' ',Mapatriz [x,y].Descripcion);
				readKey;
				window(1,1,80,250);

			until clchar = 's';

		until 5 < 4;

		window(1,1,80,25);

	end;


	Procedure ModifSimulacion(ruta:string);
		var

			i : integer;
			j : integer;
			k : integer;
			l : integer;
			m : integer;
			clchar : char;
			Salida : integer;
			Mapatriz : array [1..100,1..100] of TRegMatriz;
			topex : integer;
			topey : integer;
			aux : string;
			Mapa : text;

		begin

			clrscr;
			Salida := 1;
			i := 1;
			//CrearMatriz(Mapatriz,topex,topey);

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
			writeln;


			//writeln('Esto simboliza las cosas que ocurren dia a dia');
			//writeln('Presionar P para pausar');
			//writeln('Presionar S para salir al menu');

			repeat

				textcolor(10);
				writeln('Dia : ',i,' (Pausa (P), Salir (S))');
				//writeln;

				for j := 1 to topey-1 do //Experimental
				begin

					for k := 1 to topex do
					begin

						case Mapatriz[k,j].Codigo of

							' ' : begin write(Mapatriz[k,j].Codigo); end;
							'0' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;
							'1' : begin textcolor(green); write(Mapatriz[k,j].Codigo); end;
							'2' : begin textcolor(lightgreen); write(Mapatriz[k,j].Codigo); end;
							'3' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;
							'4' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;
							'5' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;
							'6' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;
							'7' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;
							'8' : begin textcolor(magenta); write(Mapatriz[k,j].Codigo); end;
							'9' : begin textcolor(red); write(Mapatriz[k,j].Codigo); end;

						end;

					end;

					//if j <> topey then
						writeln;

				end;

				if keypressed then
				begin

					clchar:=readkey;

					if clchar='p' then

						Pausa(clchar);

					if clchar='s' then

				               Menu(Salida);

				end;


			Delay(1000);
			i := i + 1;

			until 5<4;

			Menu(Salida);

			close(Mapa);

		end;

	Procedure ImprLineasMapa(var lineatexto:string);

	var

		I:integer;
		longitud:integer;

	begin

		longitud:=length(lineatexto);

		for I:=1 to longitud do
		begin

			case lineatexto[I] of

			' ' : begin  write(lineatexto[I]); end;
			'0' : begin textcolor(brown); write(lineatexto[I]); end;
			'1' : begin textcolor(green); write(lineatexto[I]); end;
			'2' : begin textcolor(lightgreen); write(lineatexto[I]); end;
			'3' : begin textcolor(7); write(lineatexto[I]); end;
			'4' : begin textcolor(lightgray); write(lineatexto[I]); end;
			'5' : begin textcolor(7); write(lineatexto[I]); end;
			'6' : begin textcolor(brown); write(lineatexto[I]); end;
			'7' : begin textcolor(lightgray); write(lineatexto[I]); end;
			'8' : begin textcolor(magenta); write(lineatexto[I]); end;
			'9' : begin textcolor(red); write(lineatexto[I]); end;

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
