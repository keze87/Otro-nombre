unit Simulacion;

interface

type

	TRegMatriz = record
			codigo : char;
			Descripcion : string;
			caracter : char;
			CantSuceptibles : longInt;
			CantInfectados : longInt;
			CantZombies : longInt;
			CantRemovidos : longInt;
			TasaNatalidad : real;
			FactorMovilidad : real;
			end;

	TMatriz = array[1..100,1..100] of TRegMatriz;

	Procedure MostrarMapa(var SalidaMapa:integer; var ruta:string);
	Procedure ImprLineasMapa(var lineatexto:string);
	Procedure ModifSimulacion(dias:integer; periodo:integer; ruta:string);
	Procedure MostrarPoblaciones(x:integer;y:integer; var Mapatriz:TMatriz);
	Procedure MostrarPoblacionesViejo;
	Procedure CrearMatriz(var MatrizMapa:TMatriz);
	Procedure DibujarMatriz (var Mapatriz : TMatriz ; topex : integer ; topey : integer ; x : integer ; y : integer);
	Procedure Pausa(var caracter:char;var Mapatriz:TMatriz);
	Procedure NuevoFoco(var i:integer;var j:integer;var Mapatriz:TMatriz);
	Procedure ActualizarMatriz (var Matriz : TMatriz; topex : integer; topey : integer);

implementation

	Uses

		crt,ProceduresVarios,MenuPcpal,AnalisisZombi;

	Type

		TPoblaciones = record
		PuntoX : integer;
		PuntoY : integer;
		Descripcion : string[30];
		CantSuceptibles : longInt;
		CantInfectados : longInt;
		CantZombies : longInt;
		CantRemovidos : longInt;
		TasaNatalidad : real;
		FactorMovilidad : real;
		end;

	TFactores = record
		Codigo{de factor} : string[2];
		Descripcion : string[30];
		Valor : real;
		end;

	Procedure NuevoFoco(var i:integer;var j:integer;var Mapatriz:TMatriz);
		Var

			foco:integer;

		Begin

			GotoXY(1,25);

			write('Ingrese cantidad de infectados: ');

			LeerINT(foco);

			mapatriz[i,j].CantInfectados:=mapatriz[i,j].CantInfectados+foco;

			GotoXY(i,j);

		end;

	Procedure Pausa(var caracter:char;var mapatriz:TMatriz);
		var

			key:char;
			i:integer;
			j:integer;

		begin

			j:=1;

			i:=1;

			repeat

				delay(33);

				{   if keypressed then
					begin     }

				key:=readkey;

				if key = 'f' then

					NuevoFoco(i,j,mapatriz);

				if key = 'i' then

					mostrarpoblaciones(i,j,mapatriz);

				if (key = #0) then

					begin

						key:=readkey;

						case key of

							#72 : if j>1 then begin j:=j-1; gotoxy(i,j); end;

							#80 : begin j:=j+1; gotoxy(i,j); end;

							#75 : if i>1 then begin i:=i-1; gotoxy(i,j); end;

							#77 : begin i:=i+1; gotoxy(i,j); end;

							end;

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

			Assign(Poblaciones,'Poblaciones.DAT');

			reset(Mapa);

			while not eof(Mapa) do
			begin

				readln(Mapa,aux);

				for i:=1 to length(aux) do
				begin

					MatrizMapa[i,j].codigo := aux[i];

				end;

			j:=j+1;

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

				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].Descripcion:=regPoblacion.Descripcion;

			end;

			close(Poblaciones);

end;

	Procedure MostrarPoblaciones(x:integer; y:integer;var mapatriz:TMatriz);
		begin

			gotoxy(1,25);    {y donde pueda ser visto segun linux}

			write(x,' ',y,' ',mapatriz[x,y].Descripcion);

			gotoxy(x,y);

	end;

	Procedure ModifSimulacion(dias:integer; periodo:integer; ruta:string);
		var

			i : integer;
			j : integer;
			k : integer;
			l : integer;
			m : integer;
			peri : integer;
			clchar : char;
			Salida : integer;
			Mapatriz : TMatriz;
			topex : integer;
			topey : integer;
			aux : string;
			Mapa : text;

		begin

			clrscr;

			Salida := 1;

			i := 1;
			peri := 1;

			CrearMatriz(Mapatriz);

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

			repeat

				textcolor(10);

				if (peri = periodo) or (i = 1) then
				begin

				clrscr;

				write('Dia : ',i,' ((P)ausa,(S)alir,Dentro de Pausa((I)nfo,(F)oco Infeccion))');

				//writeln;

				for j := 1 to topey-1 do //Experimental
				begin

					for k := 1 to topex do
					begin

						{case Mapatriz[k,j].Codigo of

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

						end;}

						if Mapatriz[k,j].CantZombies < 100 then
							textcolor(lightgray);

						if Mapatriz[k,j].CantZombies > 100 then
							textcolor(yellow);

						if Mapatriz[k,j].CantZombies > 1000 then
							textcolor(magenta);

						if Mapatriz[k,j].CantZombies > 10000 then
							textcolor(red);

						write(Mapatriz[k,j].Codigo);

					end;

					//if j <> topey then
						writeln;

				end;

				Delay(1000);

				peri := 0;

				end;

				if keypressed then
				begin

					clchar:=readkey;

					if clchar='p' then
						Pausa(clchar,mapatriz);

						{ if clchar='g' then
							Guardar(clchar); }

					if clchar='s' then
						Menu(Salida);

				end;

			i := i + 1;
			peri := peri + 1;

			ActualizarMatriz(Mapatriz,topex,topey);

			until i >= dias + 1;

			close(Mapa);

			readkey;

			Menu(Salida);

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

	Procedure MostrarPoblacionesViejo;
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

			Assign(Poblaciones, 'Poblaciones.DAT');
			reset(Poblaciones);

			topex := -213;

			m := 0;

			repeat

				readln(Mapa,aux);

				l := 0;

				m := m + 1;

				repeat

					l := l + 1;

					//reset(Poblaciones); //seguro que esto es lo que dijo la profe en el parcial

					repeat

						read(Poblaciones,auxP);

					until ((auxP.PuntoX = l) and (auxP.PuntoY = m));

					Mapatriz [l,m].Codigo := aux[l];
					Mapatriz [l,m].Descripcion := auxP.Descripcion;
					Mapatriz [l,m].CantSuceptibles := auxP.CantSuceptibles;
					//writeln(Mapatriz [l,m].CantSuceptibles:0:0);

					//close(Poblaciones);

					if l > topex then
						topex := l;

				until l = length(aux);

			until EOF(Mapa);

			topey := m;
			writeln;

			close(Poblaciones);

			x := 1;
			y := 1;
			DibujarMatriz(Mapatriz,topex,topey,x,y);

			repeat

				//repeat

					if keypressed then
					begin

						clchar := readkey;

						//if ((clchar <> Char(75)) and (clchar <> Char(72)) and (clchar <> Char(80)) and (clchar <> Char(77))) then
						if (clchar = 's') then
						begin

							Menu(topex);

						end;

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

					writeln(' PuntoX : ',x,', PuntoY : ',y);
					write(' Descripcion : ',Mapatriz [x,y].Descripcion);
					if Mapatriz [x,y].Codigo <> ' ' then
					write(', Habitantes : ',Mapatriz [x,y].CantSuceptibles);

					//readKey;
					Delay(20);
					window(1,1,80,250);

			//until clchar = 's';

		until 5 < 4;

		window(1,1,80,25);

	end;

	procedure ActualizarMatriz (var Matriz : TMatriz; topex : integer; topey : integer);
	var

		Factores : file of TFactores;
		auxF : TFactores;
		alfa : real;
		beta : real;
		delta : real;
		xi : real;
		pi : real;
		rho : real;

		totalS : longInt;
		totalI : longInt;
		totalR : longInt;
		totalZ : longInt;

		i : integer;
		j : integer;

	begin

		Assign(Factores,'Factores.DAT');
		reset(Factores);

		totalS := 0;
		totalI := 0;
		totalR := 0;
		totalZ := 0;

		repeat

			read(Factores,auxF);

			case auxF.Codigo of

				'al' : alfa := auxF.Valor;
				'be' : beta := auxF.Valor;
				'de' : delta := auxF.Valor;
				'xi' : xi := auxF.Valor;
				'pi' : pi := auxF.Valor;
				'ro' : rho := auxF.Valor;

			end;

		until EOF(Factores);

		for j := 1 to topey-1 do
			for i := 1 to topex do
				begin

					Calculo(Matriz [i,j].CantSuceptibles,Matriz [i,j].CantZombies,Matriz [i,j].CantRemovidos,Matriz [i,j].CantInfectados,alfa,beta,delta,xi,pi,rho);

					totalS := totalS + Matriz [i,j].CantSuceptibles;
					totalI := totalI + Matriz [i,j].CantInfectados;
					totalR := totalR + Matriz [i,j].CantRemovidos;
					totalZ := totalZ + Matriz [i,j].CantZombies;

				end;

		writeln('S = ',totalS,' I = ',totalI,' R = ',totalR,' Z = ',totalZ);
		readkey;

	end;

end.
