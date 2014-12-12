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

	Tregpos = record
		x:integer;
		y:integer;
		end;

	Procedure MostrarMapa(ruta:string);
	Procedure ImprLineasMapa(var lineatexto:string);
	Procedure ModifSimulacion(dias:integer; periodo:integer; rutaM:string; rutaF:string; rutaP:string);
	Procedure MostrarPoblaciones(x:integer;y:integer; var Mapatriz:TMatriz);
	Procedure MostrarPoblacionesViejo;
	Procedure CrearMatriz(Var MatrizMapa : TMatriz; RutaM : string; RutaP : string);
	Procedure DibujarMatriz (var Mapatriz : TMatriz ; topex : integer ; topey : integer ; x : integer ; y : integer);
	Procedure Pausa(var caracter:char;var Mapatriz:TMatriz);
	Procedure NuevoFoco(var i:integer;var j:integer;var Mapatriz:TMatriz);
	Procedure ActualizarMatriz (var Matrizmapa : TMatriz; topex : integer; topey : integer; alfa : real; beta : real; delta : real; xi : real; pi : real; rho : real);
	Procedure Guardar(var mapatriz:TMatriz;topex:integer;topey:integer);
	Procedure MigracionAire (var Matriz:TMatriz;topex:integer;topey:integer);
	Procedure MigracionTierra (Var Matriz:TMatriz;topex:integer;topey:integer);
	Function InViaje(poblacionTotal: longint; poblacionInfectada: longint; cantidadDePasajeros: integer): longInt;

implementation

	Uses

		crt,ProceduresVarios,MenuPcpal,AnalisisZombi,SysUtils;

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
		Codigo : string[2];
		Descripcion : string[30];
		Valor : real;
		end;

	Procedure Guardar(var mapatriz:TMatriz;topex:integer;topey:integer);
	var

		i:integer;
		j:integer;
		ArchPoblaciones:file of TPoblaciones;
		ArchFactores:file of TFactores;
		Factores:file of TFactores;
		RegP:TPoblaciones;
		RegF:TFactores;

		rta : char;
		rutaP : string;
		rutaF : string;

	begin

		writeln;
		write('Guardar poblaciones como: ');
		readln(rutaP);

		while fileexists(rutaP) do
		begin

			writeln('Archivo ya existente. Sobreescribir? (S/N)');
			readln(rta);
			writeln;

			case rta of

				's' : break;
				'S' : break;
				else begin write('Guardar poblaciones como: '); readln(rutaP); end;

			end;

		end;

		Assign(ArchPoblaciones,rutaP);
		rewrite (ArchPoblaciones);

		writeln;
		write('Guardar factores como: ');

		readln(rutaF);

		while fileexists(rutaF) do
		begin

			writeln('Archivo ya existente. Sobreescribir? (S/N)');
			readln(rta);

			writeln;

			case rta of

				's' : break;
				'S' : break;
				else begin write('Guardar poblaciones como: '); readln(rutaF); end;

			end;

		end;

		Assign(ArchFactores,rutaF);
		Rewrite(ArchFactores);

		Assign(Factores,'Factores.DAT'); //Esto no debería ser así
		Reset(Factores);

		while not eof(Factores) do
		begin

			read(Factores,RegF);
			write(ArchFactores,RegF);

		end;

		close(Factores);
		close(ArchFactores);

		for j:=1 to topey do
			for i:=1 to topex do

				begin

					RegP.PuntoX := i;

					RegP.PuntoY := j;

					RegP.Descripcion := mapatriz[i,j].Descripcion;

					RegP.CantSuceptibles := mapatriz[i,j].CantSuceptibles;

					RegP.CantInfectados := mapatriz[i,j].CantInfectados;

					RegP.CantZombies := mapatriz[i,j].CantZombies;

					RegP.TasaNatalidad := mapatriz[i,j].TasaNatalidad;

					RegP.FactorMovilidad := mapatriz[i,j].FactorMovilidad;

					write(ArchPoblaciones,RegP);

				end;

		close(ArchPoblaciones);

	end;

	Procedure NuevoFoco(var i:integer;var j:integer;var Mapatriz:TMatriz);
	var

		foco:integer;

	begin

		GotoXY(1,37);

		textcolor(cyan);

		write('Ingrese cantidad de infectados: ');

		LeerINT(foco);

		mapatriz[i,j-1].CantInfectados := foco;

		write('Ingrese cantidad de Zombies: ');

		LeerINT(foco);

		textcolor(lightgray);

		mapatriz[i,j-1].CantZombies := foco;

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

			key:=readkey;

			if (key = 'f') then
				NuevoFoco(i,j,mapatriz);

			if (key = 'i') then
			begin

				gotoxy(1,25+12);
				write('                                                ');
				mostrarpoblaciones(i,j,mapatriz);

			end;

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

		for j := 1 to topey-1 do
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

	Procedure CrearMatriz(Var MatrizMapa : TMatriz; RutaM : string; RutaP : string);
	var

		Mapa : text;
		aux : string;
		i : integer;
		j : integer;
		regPoblacion : TPoblaciones;
		Poblaciones: file of TPoblaciones;

	begin

		j:=1;

		Assign(Mapa,RutaM);
		Assign(Poblaciones,RutaP);

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

		gotoxy(1,37);

		textcolor(cyan);

		write(x,' ',y,' ',mapatriz[x,y-1].Descripcion,' ');
		write(mapatriz[x,y-1].CantSuceptibles,' ',mapatriz[x,y-1].CantZombies);

		textcolor(lightgray);

		gotoxy(x,y);

	end;

	Procedure ModifSimulacion(dias:integer; periodo:integer; rutaM:string; rutaF:string; rutaP:string);
	var

		i : integer;
		j : integer;
		k : integer;
		m : integer;
		peri : integer;
		Aire : integer;
		clchar : char;
		Salida : integer;
		Mapatriz : TMatriz;
		topex : integer;
		topey : integer;
		aux : string;
		Mapa : text;

		totalS : longInt;
		totalI : longInt;
		totalR : longInt;
		totalZ : longInt;

		Factores : file of TFactores;
		auxF : TFactores;
		alfa : real;
		beta : real;
		delta : real;
		xi : real;
		pi : real;
		rho : real;

	begin

		clrscr;

		Salida := 1;
		i := 1;
		peri := 1;
		Aire := 1;

		if not fileexists(RutaF) then
			rutaF := 'Factores.DAT';

		if not fileexists(RutaM) then
			rutaM := 'mapamundi.txt';

		if not fileexists(RutaP) then
			rutaP := 'Poblaciones.DAT';

		Assign(Factores,RutaF);
		reset(Factores);

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

		close(Factores);

		CrearMatriz(Mapatriz,RutaM,RutaP);

		Assign(Mapa,RutaM);
		reset(Mapa);

		m := 0;

		repeat

			readln(Mapa,aux);

			topex := length(aux);

			m := m + 1;

		until EOF(Mapa);

		topey := m;

		writeln;

		repeat

			textcolor(10);

			if (Aire = 7) then
			begin

				MigracionAire (Mapatriz,topex,topey);
				Aire := 0;

			end;

			if (peri = periodo) or (i = 1) then
			begin

				clrscr;

				totalS := 0;
				totalI := 0;
				totalR := 0;
				totalZ := 0;

				write('Dia : ',i,' ((P)ausa,(S)alir,(G)uardar,En Pausa((I)nfo,(F)oco Infeccion))');

				for j := 1 to topey-1 do
				begin

					for k := 1 to topex do
					begin

						if Mapatriz[k,j].CantZombies = 0 then
							textcolor(lightgray);

						if Mapatriz[k,j].CantZombies > 1 then
							textcolor(yellow);

						if Mapatriz[k,j].CantZombies  > 10 then
							textcolor(magenta);

						if Mapatriz[k,j].CantZombies > 50 then
							textcolor(red);

						if Mapatriz[k,j].CantZombies < 0 then
							textcolor(red);


						write(Mapatriz[k,j].Codigo);

						textcolor(lightgray);

					if totalS + Mapatriz [k,j].CantSuceptibles >= 2147483647 then
						totalS := 2147483646
					else
						totalS := totalS + Mapatriz [k,j].CantSuceptibles;

					if totalZ + Mapatriz [k,j].CantZombies >= 2147483647 then
						totalZ := 2147483646
					else
						totalZ := totalZ + Mapatriz [k,j].CantZombies;

					if totalR + Mapatriz [k,j].CantRemovidos >= 2147483647 then
						totalR := 2147483646
					else
						totalR := totalR + Mapatriz [k,j].CantRemovidos;

					if totalI + Mapatriz [k,j].CantInfectados >= 2147483647 then
						totalI := 2147483646
					else
						totalI := totalI + Mapatriz [k,j].CantInfectados;

					end;

					writeln;

				end;

				write('S = ',totalS,' I = ',totalI,' R = ',totalR,' Z = ',totalZ);

				Delay(1000);

				peri := 0;

				end;

				if keypressed then
				begin

					clchar:=readkey;

					if (clchar='p') {or (clchar='P')} then
						Pausa(clchar,mapatriz);

					if (clchar='g') or (clchar='G') then
						Guardar(mapatriz,topex,topey);

					if (clchar='s') or (clchar='S') then
						Menu(Salida);

				end;

			i := i + 1;
			Aire := Aire + 1;
			peri := peri + 1;

			ActualizarMatriz(Mapatriz,topex,topey,alfa,beta,delta,xi,pi,rho);

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

	Procedure MostrarMapa(ruta:string);
	var

		texto:string;
		mundi:text;

	begin

		ClrScr;

		Assign(mundi,ruta);

		Reset(mundi);

		while not eof(mundi) do
		begin

			readln(mundi,texto);

			ImprLineasMapa(texto);

			writeln;

		end;

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

		Assign(Mapa,'mapamundi.txt');
		reset(Mapa);

		Assign(Poblaciones, 'Poblaciones.DAT');
		reset(Poblaciones);

		topex := -1;

		m := 0;

		repeat

			readln(Mapa,aux);

			l := 0;
			m := m + 1;

			repeat

				l := l + 1;

				repeat

					read(Poblaciones,auxP);

				until ((auxP.PuntoX = l) and (auxP.PuntoY = m));

				Mapatriz [l,m].Codigo := aux[l];
				Mapatriz [l,m].Descripcion := auxP.Descripcion;
				Mapatriz [l,m].CantSuceptibles := auxP.CantSuceptibles;

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

			if keypressed then
			begin

				clchar := readkey;

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

			Delay(20);
			window(1,1,80,250);

		until clchar = 's';

		window(1,1,80,25);

	end;

	procedure ActualizarMatriz (var Matrizmapa : TMatriz; topex : integer; topey : integer; alfa : real; beta : real; delta : real; xi : real; pi : real; rho : real);
	var

		i : integer;
		j : integer;

	begin

		for j := 2 to topey do
			for i := 1 to topex do
				begin

					Calculo(Matrizmapa,i,j,alfa,beta,delta,xi,pi,rho);

				end;

		MigracionTierra (Matrizmapa,topex,topey);

	end;


	function InViaje(poblacionTotal: longint; poblacionInfectada: longint; cantidadDePasajeros: integer): longInt;
	var

		i:integer;
		infectadosEnViaje: integer;

	begin

		infectadosEnViaje := 0;

		for i:=1 to cantidadDePasajeros do
		begin

			if(random(poblacionTotal) <= poblacionInfectada) then
			begin

				infectadosEnViaje := infectadosEnViaje + 1;

			end;

		end;

		InViaje := infectadosEnViaje;

	end;

	Procedure MigracionAire (var Matriz:TMatriz;topex:integer;topey:integer);
	type

		TAire = record
			x : integer;
			y : integer;
			end;

	var

		cant : integer;
		Pos : array [1..100] of TAire;
		i : integer;
		j : integer;
		k : integer;

		aux : longInt;

	begin

		cant := 0;

		for j := 1 to topey-1 do
			for i := 1 to topex do
				if Matriz[i,j].Codigo = '9' then
				begin

					cant := cant + 1;
					Pos[cant].x := i;
					Pos[cant].y := j;

				end;

		if cant > 0 then
			for j := 1 to topey-1 do
				for i := 1 to topex do
					if Matriz[i,j].Codigo = '8' then
					begin

						if Matriz[i,j].CantSuceptibles > cant then
						begin

							aux := trunc(( Matriz[i,j].CantSuceptibles * 0.0025 / 100 ) / cant) + 1;

							Matriz[i,j].CantSuceptibles := Matriz[i,j].CantSuceptibles - VerNegativo(trunc(( Matriz[i,j].CantSuceptibles * 0.0025 / 100 )));

							if aux > 0 then
								for k := 1 to cant do
								begin

									Matriz[Pos[k].x,Pos[k].y].CantInfectados := Matriz[Pos[k].x,Pos[k].y].cantInfectados + trunc(InViaje(Matriz[Pos[k].x,Pos[k].y].CantSuceptibles + Matriz[Pos[k].x,Pos[k].y].CantInfectados,Matriz[Pos[k].x,Pos[k].y].CantInfectados,aux));
									Matriz[Pos[k].x,Pos[k].y].CantSuceptibles := Matriz[Pos[k].x,Pos[k].y].CantSuceptibles + aux;

								end;

						end;
					end;

	end;

	Procedure MigracionTierra (Var Matriz:TMatriz;topex:integer;topey:integer);
	type

		TTierra = record
			x : integer;
			y : integer;
			end;

	var

		i : integer;
		j : integer;
		k : integer;
		aux : real;
		auxS : real;
		auxZ : real;
		cant : integer;
		Pos : array [1..8] of TTierra;

	begin

		for j := 1 to topey-1 do
				for i := 1 to topex do
				begin

					cant := 0;

					if (Matriz[i,j].Codigo <> ' ') and (Matriz[i,j].CantSuceptibles > 0) and (Matriz[i,j].CantZombies > 0) then
					begin

						if (i-1 >= 1) and (Matriz[i-1,j].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i-1;
							Pos[cant].y := j;

						end;

						if (j-1 >= 1) and (Matriz[i,j-1].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i;
							Pos[cant].y := j-1;

						end;

						if (i+1 <= topex) and (Matriz[i+1,j].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i+1;
							Pos[cant].y := j;

						end;

						if (j+1 <= topey) and (Matriz[i,j+1].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i;
							Pos[cant].y := j+1;

						end;

						if (i-1 >= 1) and (j-1 >= 1) and (Matriz[i-1,j-1].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i-1;
							Pos[cant].y := j-1;

						end;

						if (i-1 >= 1) and (j+1 <= topey) and (Matriz[i-1,j+1].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i-1;
							Pos[cant].y := j+1;

						end;

						if (i+1 <= topex) and (j-1 >= 1) and (Matriz[i+1,j-1].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i+1;
							Pos[cant].y := j-1;

						end;

						if (i+1 <= topex) and (j+1 <= topey) and (Matriz[i+1,j+1].Codigo <> ' ') then
						begin

							cant := cant + 1;

							Pos[cant].x := i+1;
							Pos[cant].y := j+1;

						end;

						//separador

						if cant > 0 then
						begin

							aux := Matriz[i,j].CantZombies * 100 / (Matriz[i,j].CantSuceptibles + Matriz[i,j].CantZombies);

							auxS := trunc((aux * Matriz[i,j].CantSuceptibles / 100) / cant);

							Matriz[i,j].CantSuceptibles := Matriz[i,j].CantSuceptibles - VerNegativo((trunc(auxS) * cant));

							aux := aux * Matriz[i,j].FactorMovilidad;

							auxZ := trunc((aux * Matriz[i,j].CantZombies / 100) / cant);

							Matriz[i,j].CantZombies := Matriz[i,j].CantZombies - VerNegativo((trunc(auxS) * cant));

							for k := 1 to cant do
							begin

								Matriz[Pos[k].x,Pos[k].y].CantSuceptibles := Matriz[Pos[k].x,Pos[k].y].CantSuceptibles + trunc(auxS);

								Matriz[Pos[k].x,Pos[k].y].CantZombies := Matriz[Pos[k].x,Pos[k].y].CantZombies + trunc(auxZ);

							end;

						end;
					end;
				end;

	end;
end.
