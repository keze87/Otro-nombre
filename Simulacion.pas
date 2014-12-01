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

	Procedure MostrarMapa(ruta:string);
	Procedure ImprLineasMapa(var lineatexto:string);
	Procedure ModifSimulacion(dias:integer; periodo:integer; rutaM:string; rutaF:string; rutaP:string);
	Procedure MostrarPoblaciones(x:integer;y:integer; var Mapatriz:TMatriz);
	Procedure CrearMatriz(Var MatrizMapa : TMatriz; RutaM : string; RutaP : string);
	Procedure DibujarMatriz (var Mapatriz : TMatriz ; topex : integer ; topey : integer ; x : integer ; y : integer);
	Procedure Pausa(var caracter:char;var Mapatriz:TMatriz);
	Procedure NuevoFoco(var i:integer;var j:integer;var Mapatriz:TMatriz);
	Procedure ActualizarMatriz (var Matriz : TMatriz; topex : integer; topey : integer; alfa : real; beta : real; delta : real; xi : real; pi : real; rho : real);
	Procedure Guardar(var mapatriz:TMatriz;topex:integer;topey:integer);

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
		Codigo{de factor} : string[2];
		Descripcion : string[30];
		Valor : real;
		end;

	Procedure Guardar(var mapatriz:TMatriz;topex:integer;topey:integer);
		var

			i:integer;
			j:integer;
			//rutaP:string;
			//rutaF:string;
			ArchPoblaciones:file of TPoblaciones;
			ArchFactores:file of TFactores;
			Factores:file of TFactores;
			RegP:TPoblaciones;
			RegF:TFactores;
			//rta:char;

		begin

				gotoxy(1,25);

				{writeln('Guardar factores como: ');
				readkey;
				rutaF:='newfactores.dat';
				read(rutaF);
				while fileexists(rutaF) do
				begin

					writeln('Archivo existente. Sobreescribir?(s/n)');
					read(rta);
					case rta of
						's': Assign(ArchFactores,rutaF);
						'n': begin

							writeln('Guardar factores como: ');
							read(rutaF);

							end;
					end;
				end;
				if (not fileexists(rutaF)) then
					Assign(ArchFactores,rutaF);

				 writeln('Guardar poblaciones como: ');
				read(rutaP);
				while fileexists(rutaP) do
				begin

					writeln('Archivo existente. Sobreescribir?(s/n)');
					read(rta);
					case rta of
						's': Assign(ArchPoblaciones,rutaP);
						'n': begin

								writeln('Guardar poblaciones como: ');
								read(rutaP);

							end;

					end;

				end;

				if not fileexists(rutaP) then}

				Assign(ArchPoblaciones,'newpoblaciones.DAT');

				Assign(ArchFactores,'newfactores.DAT');

				Assign(Factores,'Factores.DAT');

				Reset(Factores);

				Rewrite(ArchFactores);

				while not eof(Factores) do
				begin

					read(Factores,RegF);

					write(ArchFactores,RegF);

				end;

				close(Factores);

				close(ArchFactores);

				rewrite(ArchPoblaciones);

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
		Var

			foco:integer;

		Begin

			GotoXY(1,24);

			write('Ingrese cantidad de infectados: ');

			LeerINT(foco);

			mapatriz[i,j].CantInfectados:={mapatriz[i,j].CantInfectados+}foco;

			write('Ingrese cantidad de Zombies: ');

			LeerINT(foco);

			mapatriz[i,j].CantZombies := foco;

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
				begin

					gotoxy(1,25);
					write('                                         ');
					mostrarpoblaciones(i,j-1,mapatriz);

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

			gotoxy(1,25);

			write(x,' ',y,' ',mapatriz[x,y].Descripcion);

			gotoxy(x,y+1);

	end;

	Procedure ModifSimulacion(dias:integer; periodo:integer; rutaM:string; rutaF:string; rutaP:string);
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

			if not fileexists(RutaF) then
				rutaF := 'Factores.DAT';

			if not fileexists(RutaM) then
				rutaM := 'mapamundi.txt';

			if not fileexists(RutaP) then
				rutaP := 'Poblaciones.DAT';

			Assign(Factores,RutaF{'Factores.DAT'});
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

			Assign(Mapa,RutaM{'mapamundi.txt'});
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

			topey := 37;
			topex := 74;  {despues lo arreglo para que lo tome de la medida del archivo}

			writeln;

			repeat

				textcolor(10);

				if (peri = periodo) or (i = 1) then
				begin

				clrscr;

				totalS := 0;
				totalI := 0;
				totalR := 0;
				totalZ := 0;

				write('Dia : ',i,' ((P)ausa,(S)alir,(G)uardar,En Pausa((I)nfo,(F)oco Infeccion))');

				for j := 1 to topey-1 do //Experimental
				begin

					for k := 1 to topex do
					begin

						if Mapatriz[k,j].CantZombies < 100 then
							textcolor(lightgray);

						if Mapatriz[k,j].CantZombies > 100 then
							textcolor(yellow);

						if Mapatriz[k,j].CantZombies > 1000 then
							textcolor(magenta);

						if Mapatriz[k,j].CantZombies > 10000 then
							textcolor(red);

						write(Mapatriz[k,j].Codigo);

						totalS := totalS + Mapatriz [i,j].CantSuceptibles;
						totalI := totalI + Mapatriz [i,j].CantInfectados;
						totalR := totalR + Mapatriz [i,j].CantRemovidos;
						totalZ := totalZ + Mapatriz [i,j].CantZombies;

					end;

						writeln;

				end;

				write('S = ',totalS,' I = ',totalI,' R = ',totalR,' Z = ',totalZ);

				Delay(1000);

				//readkey;

				peri := 0;

				end;

				if keypressed then
				begin

					clchar:=readkey;

					if clchar='p' then
						Pausa(clchar,mapatriz);

					if clchar='g' then
						Guardar(mapatriz,topex,topey);

					if clchar='s' then
						Menu(Salida);

				end;

			i := i + 1;
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

		Assign(mundi, ruta);

		Reset(mundi);

		while not eof(mundi) do
		begin

			readln(mundi, texto);

			ImprLineasMapa(texto);

			writeln;

		end;

	end;

	procedure ActualizarMatriz (var Matriz : TMatriz; topex : integer; topey : integer; alfa : real; beta : real; delta : real; xi : real; pi : real; rho : real);
	var

		i : integer;
		j : integer;

	begin

		for j := 1 to topey-1 do
			for i := 1 to topex do
				begin

					Calculo(Matriz [i,j].CantSuceptibles,Matriz [i,j].CantZombies,Matriz [i,j].CantRemovidos,Matriz [i,j].CantInfectados,alfa,beta,delta,xi,pi,rho);

				end;

	end;

end.
