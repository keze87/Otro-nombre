Unit ProceduresVarios;

interface

	Procedure EscrDelay(tiempo:integer;cadena:string);

	Procedure LeerINT (var Variable : integer);

	Procedure LeerReal (var Variable : Real);

	Procedure CrearArchivos;

	Procedure EditarFactores(var Salida : integer);

	Procedure MostrarTerrenosDAT;

	Procedure LeerArchivo(nombre:string);

	Procedure LeerArchivoSegunPoblacion(nombre:string);

	Procedure VisualizarDescripcionPoblacion;

	Procedure VisualizarDescripcionSimulacion;

	Procedure PintarFondo(cadena:string; color:byte);

	Procedure PintarTexto(cadena:string; color:byte);

	Procedure ActualizarPoblacionMundial;

	Function BuscarFactor(codigoFactor:string):real;

	Function VerNegativo(nro:integer):integer;

	Function Aleatorio(limit:longint):longint;

	Function VisualizarMapaConColores(caracter:char):char;

	Function ObtenerPoblacionVivosYZombies(x,y:integer):string;

	Function VisualizarMapaSegunPoblacion(caracter:char; VivosZombies:string):char;

implementation

Uses

	crt,MenuPcpal,SysUtils,Simulacion;

Type

	TTerrenos = record
		Codigo : integer;
		Descripcion : string[30];
		end;

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

	Procedure EscrDelay(tiempo:integer;cadena:string);
	var

		longitud:integer;
		I:integer;

	begin

		longitud:=length(cadena);

		for I:=1 to longitud do
		begin

			write(cadena[I]);
			delay(abs(tiempo));

		end;

		if tiempo > 0 then
			writeln;

	end;


	Procedure LeerINT (var Variable : integer);
	begin

		repeat

			{$I-}

				readln(Variable);

			{$I+}

		until not(IOResult<>0);

	end;

	Procedure LeerReal (var Variable : Real);
	begin

		repeat

			{$I-}

				readln(Variable);

			{$I+}

		until not(IOResult<>0);

		end;

	Procedure CrearArchivos;
	const

		Velocidad = 15;

	var

		Mapa : Text;
		MapaB: Text;
		texto : string;
		i : integer;
		j : integer;
		longitud : integer;

		Terrenos : file of TTerrenos;
		auxT : TTerrenos;
		Poblaciones : file of TPoblaciones;
		auxP : TPoblaciones;
		Factores : file of TFactores;
		auxF : TFactores;

		aux : integer;
		ruta : string;

		MapaNuevo : Text;
		PoblacionesNuevo : file of TPoblaciones;
		FactoresNuevo : file of TFactores;

	begin

		clrscr;

		textcolor(10);

		{*** Mapa ***}

		Assign(Mapa,'mapamundi.txt');
		rewrite(Mapa);

		writeln(Mapa,'                                                                         ');
		writeln(Mapa,'                   4248 4422828                                          ');
		writeln(Mapa,'                 4648 4445331818       6                2                ');
		writeln(Mapa,'           428           4449888               8  0 12428824 3  8 3      ');
		writeln(Mapa,'    2228 1 4242  42668   447668         61     4 22424382828222288283 4  ');
		writeln(Mapa,'22 4544422444228268  48  448    2      764882424482232444788141212122887 ');
		writeln(Mapa,'  345663348344488         48         768 554344282444244438882346823541  ');
		writeln(Mapa,'    4    4828248886  828            4 4  42886658248343448112112    8    ');
		writeln(Mapa,'          461888118 44282         4833324768164482032322248276888  4     ');
		writeln(Mapa,'          846818248238888           4373986766640200330482816881         ');
		writeln(Mapa,'          8448876686816            44878888647604400030310008814         ');
		writeln(Mapa,'           42088764816            488 6 16  888242440000070762  4        ');
		writeln(Mapa,'           4064878549             64    4 2778 424410000026834 2         ');
		writeln(Mapa,'            05788667               100    807600656400871618  8          ');
		writeln(Mapa,'            86577888              40000000260760085660676888             ');
		writeln(Mapa,'              6084               000000000260006660887661728             ');
		writeln(Mapa,'               4    5            0000600002 0006  64766668               ');
		writeln(Mapa,'               642   2           00704000028 00    86 867                ');
		writeln(Mapa,'                  8  5           416740450230      88  576  2            ');
		writeln(Mapa,'                   8 2280        4276653482468     8   4                 ');
		writeln(Mapa,'                    18121         66 656422060          6                ');
		writeln(Mapa,'                    4766222           4644209           8 41             ');
		writeln(Mapa,'                    8888812           454328            8  22  2         ');
		writeln(Mapa,'                    882122222         443248             1      68       ');
		writeln(Mapa,'                    2212222888         42248                6            ');
		writeln(Mapa,'                     2232222           66878 4                4 4        ');
		writeln(Mapa,'                      026658          408178 3              24323        ');
		writeln(Mapa,'                      476648           4078  4             2000008       ');
		writeln(Mapa,'                      4664             60583               40009008      ');
		writeln(Mapa,'                      0768            0444                 00000054      ');
		writeln(Mapa,'                      0889              6                  6   054       ');
		writeln(Mapa,'                     476                                       363       ');
		writeln(Mapa,'                     48                                               7  ');
		writeln(Mapa,'                     48                                                  ');
		writeln(Mapa,'                     8                                                   ');
		writeln(Mapa,'                      8                                                  ');
		writeln(Mapa,'                                                                         ');

		close(Mapa);

		{*** Factores ***}

		Assign(Factores,'Factores.DAT');
		rewrite(Factores);

		{alpha}

		auxF.Codigo := 'al' ;
		auxF.Descripcion := ' Salvacion ante ataque ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		{beta}

		auxF.Codigo := 'be' ;
		auxF.Descripcion := ' Transmisión ' ;
		auxF.Valor := 0.0005 ;

		write(Factores,auxF);

		{delta}

		auxF.Codigo := 'de' ;
		auxF.Descripcion := ' Muerte por causa natural ' ;
		auxF.Valor := 0.00005 ;

		write(Factores,auxF);

		{xi}

		auxF.Codigo := 'xi' ;
		auxF.Descripcion := ' Resurreccion Zombie ' ;
		auxF.Valor := 0.06 ;

		write(Factores,auxF);

		{pi}

		auxF.Codigo := 'pi' ;
		auxF.Descripcion := ' Tasa de natalidad ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		{rho}

		auxF.Codigo := 'ro' ;
		auxF.Descripcion := ' Latente de infección ' ;
		auxF.Valor := 0.0000009 ;

		write(Factores,auxF);

		close(Factores);

		{*** Poblaciones ***}

		Assign(Poblaciones,'Poblaciones.DAT');
		rewrite(Poblaciones);

		Assign(MapaB,'mapamundi.txt');
		reset(MapaB);

		j:=1;

		while not eof(MapaB) do
		begin

			readln(MapaB,texto);
			longitud:=length(texto);

			for i:=1 to longitud do
			begin

				case texto[i] of

					'0': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona desertica';
						auxP.CantSuceptibles:= Aleatorio(100000);
						auxP.CantInfectados:= 0;
						auxP.CantZombies:= 0;
						auxP.CantRemovidos:= 0;
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'1': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona pueblerina';
						auxP.CantSuceptibles:= Aleatorio(300000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= 0;
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'2': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona selvatica';
						auxP.CantSuceptibles:= Aleatorio(600000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= 0;
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'3': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona de montes';
						auxP.CantSuceptibles:= Aleatorio(200000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= 0;
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'4': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona mediamente poblada';
						auxP.CantSuceptibles:= Aleatorio(4000000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= 0;
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'5': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona poblada';
						auxP.CantSuceptibles:= Aleatorio(6000000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= 0;
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'6': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona de montana';
						auxP.CantSuceptibles:= Aleatorio(100000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'7': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona rural';
						auxP.CantSuceptibles:= Aleatorio(100000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'8': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona densamente poblada';
						auxP.CantSuceptibles:= Aleatorio(10000000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					'9': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona de recepcion de migracion';
						auxP.CantSuceptibles:= Aleatorio(5000000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= 0;
						auxP.FactorMovilidad:= 1;

						end;

					else begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Agua';
						auxP.CantSuceptibles:=0;
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.TasaNatalidad:=0;
						auxP.FactorMovilidad:=0;

						end;

				end;

				write(Poblaciones,auxP);

			end;

			j:=j+1;

		end;

		close(Poblaciones);
		close(MapaB);

		{*** Terrenos ***}

		Assign(Terrenos,'Terrenos.DAT');
		rewrite(Terrenos);

		auxT.Codigo := 0 ; auxT.Descripcion:= ' desertica ';

		write(Terrenos,auxT);

		auxT.Codigo := 1 ; auxT.Descripcion:= ' pueblerina ';

		write(Terrenos,auxT);

		auxT.Codigo := 2 ; auxT.Descripcion:= ' selvatica ';

		write(Terrenos,auxT);

		auxT.Codigo := 3 ; auxT.Descripcion:= ' de montes ';

		write(Terrenos,auxT);

		auxT.Codigo := 4 ; auxT.Descripcion:= ' mediamente poblada ';

		write(Terrenos,auxT);

		auxT.Codigo := 5 ; auxT.Descripcion:= ' poblada ';

		write(Terrenos,auxT);

		auxT.Codigo := 6 ; auxT.Descripcion:= ' de montana ';

		write(Terrenos,auxT);

		auxT.Codigo := 7 ; auxT.Descripcion:= ' rural ';

		write(Terrenos,auxT);

		auxT.Codigo := 8 ; auxT.Descripcion:= ' densamente poblada ';

		write(Terrenos,auxT);

		auxT.Codigo := 9 ; auxT.Descripcion:= ' de recepcion de migracion ';

		write(Terrenos,auxT);

		close(Terrenos);

		//separador

		GotoXY(25,1);

		EscrDelay(Velocidad,'**** Archivos a procesar ****');

		GotoXY(1,4);

		EscrDelay(Velocidad,'1) Por Defecto.');

		writeln;

		EscrDelay(Velocidad,'2) Elegir Archivos.');

		writeln;

		repeat

			leerInt(aux);

		until (aux = 1) or (aux = 2);

		writeln;

		if aux = 2 then
		begin

			EscrDelay(Velocidad,'Ingrese el nombre de los archivos.');
			EscrDelay(Velocidad,'(Para usar el archivo por defecto, presione ENTER)');

			writeln;
			EscrDelay(-Velocidad,'Archivo Mapa: ');
			readln(ruta);

			if not(length(ruta) = 0) then
			begin

				if fileexists(ruta) then
				begin

					rewrite(Mapa);

					assign(MapaNuevo,ruta);

					reset(MapaNuevo);

					readln(MapaNuevo,texto);

					repeat

						writeln(Mapa,texto);

						readln(MapaNuevo,texto);

					until EOF(MapaNuevo);

					close(Mapa);
					close(MapaNuevo);

				end

				else
				begin

					clrscr;
					writeln('Archivo inexistente');
					writeln('Presiona Enter para continuar.');
					delay(100);
					readln;
					CrearArchivos;

				end;

			end;

			writeln;
			EscrDelay(-Velocidad,'Archivo Poblaciones: ');
			readln(ruta);

			if not(length(ruta) = 0) then
			begin

				if fileexists(ruta) then
				begin

					rewrite(Poblaciones);

					assign(PoblacionesNuevo,ruta);

					reset(PoblacionesNuevo);

					read(PoblacionesNuevo,auxP);

					repeat

						write(Poblaciones,auxP);

						read(PoblacionesNuevo,auxP);

					until EOF(PoblacionesNuevo);

					close(Poblaciones);
					close(PoblacionesNuevo);

				end

				else
				begin

					clrscr;
					writeln('Archivo inexistente');
					writeln('Presiona Enter para continuar.');
					delay(100);
					readln;
					CrearArchivos;

				end;

			end;

			writeln;
			EscrDelay(-Velocidad,'Archivo Factores: ');
			readln(ruta);

			if not(length(ruta) = 0) then
			begin

				if fileexists(ruta) then
				begin

					rewrite(Factores);

					assign(FactoresNuevo,ruta);

					reset(FactoresNuevo);

					read(FactoresNuevo,auxF);

					repeat

						write(Factores,auxF);

						read(FactoresNuevo,auxF);

					until EOF(FactoresNuevo);

					close(Factores);
					close(FactoresNuevo);

				end

				else
				begin

					clrscr;
					writeln('Archivo inexistente');
					writeln('Presiona Enter para continuar.');
					delay(100);
					readln;
					CrearArchivos;

				end;

			end;

		end;

	end;

	function Aleatorio(limit:longint):longint;
	begin

		Randomize;

		Aleatorio := abs(random(limit));

	end;

	Procedure EditarFactores(var Salida : integer);
	const

		velocidad = 15;

	var

		FactoresViejos : file of TFactores;
		Factores : file of TFactores;
		auxF : TFactores;
		auxFV : TFactores;
		i : integer;

	begin

		Assign(FactoresViejos,'Factores.DAT');
		Rename(FactoresViejos,'Factores.TMP');
		reset(FactoresViejos);

		Assign(Factores,'Factores.DAT');
		rewrite(Factores);

		clrscr;
		writeln;

		read(FactoresViejos,auxFV);

		for i := 1 to 5 do
		begin

			write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

			auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

			read(FactoresViejos,auxFV);

		end;

		write (' '); EscrDelay(-Velocidad,'Factor'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

		auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

		close(Factores);
		close(FactoresViejos);
		erase(FactoresViejos);

		MenuFactores(Salida);

	end;

	// Muestra los datos de los terrenos que estan almacenadas por defecto
	Procedure MostrarTerrenosDAT;
	var

		Terreno : file of TTerrenos;
		DatoTemporal : TTerrenos;
		i : Integer;

	begin

		Assign(Terreno, 'Terrenos.DAT');

		if not FileExists('Terrenos.DAT') then
		begin

			Writeln('El archivo Terrenos.DAT no existe.');

		end
		else
		begin

			Reset(Terreno);
			textbackground(black);
			Writeln('                              LEYENDA ');
			Writeln;
			for i := 1 to FileSize(Terreno) do
			begin

				Read(Terreno, DatoTemporal);
				Write('              Codigo : ', DatoTemporal.Codigo);
				Write('  Descripcion : Zona', DatoTemporal.Descripcion);
				Writeln;

			end;

		Close(Terreno);
		Writeln('               Otro       Descripcion : Otros terrenos');

	end;

end;

	// Muestra el archivo 'mapamundi.txt' con algunos colores basicos
	Procedure LeerArchivo(nombre:string);
	var

		archivoTexto : text;
		caracter : char;
		cont : integer;

	begin

		assign(archivoTexto,nombre);

		cont := 1;

		{$I-}

			reset(archivoTexto);

		{$I+}

		if ioresult<>0 then
			Writeln('El archivo ',nombre, ' no existe.')
		else
		begin

			writeln;
			write('   ');

			while not eof(archivoTexto) do
			begin

				cont := cont + 1;

				read(archivoTexto,caracter);

				write(VisualizarMapaConColores(caracter));

				if eoln(archivoTexto) then
					cont := 0;

				if cont = 1 then
					write('   ');

			end;

			writeln;
			close(archivoTexto);
			TextColor(10);
			TextBackground(Black);

		end;
	end;

	// Devuelve un caracter con el color de texto y color de fondo
	Function VisualizarMapaConColores(caracter:char):char;
	begin

		textbackground(Black);

		case caracter of
			'0' : begin textbackground(LightCyan); textcolor(Yellow); end;
			'1' : begin textbackground(LightCyan); textcolor(LightRed); end;
			'2' : begin textbackground(LightCyan); textcolor(LightGreen); end;
			'3' : begin textbackground(LightCyan); textcolor(Green); end;
			'4' : begin textbackground(LightCyan); textcolor(LightMagenta); end;
			'5' : begin textbackground(LightCyan); textcolor(Blue); end;
			'6' : begin textbackground(LightCyan); textcolor(Magenta); end;
			'7' : begin textbackground(LightCyan); textcolor(LightRed); end;
			'8' : begin textbackground(LightCyan); textcolor(LightBlue); end;
			'9' : begin textbackground(LightCyan); textcolor(white); end;
			' ' : textbackground(LightCyan);
		end;

		VisualizarMapaConColores:=caracter;

	end;

	// Muestra el archivo 'mapamundi.txt' segun en enunciado del Trabajo Practico
	Procedure LeerArchivoSegunPoblacion(nombre:string);
	var

		archivoTexto: text;
		lineaTexto:string;
		i,j:integer;
		PoblacionVivosYZombies:string;

	begin

		assign(archivoTexto,nombre);

		{$I-}

			reset(archivoTexto);

		{$I+}

		if ioresult<>0 then
			Writeln('El archivo ', nombre, ' no existe.')
		else
		begin

			i:=1;
			while not eof(archivoTexto) do
			begin

				readln(archivoTexto,lineaTexto);

				for j := 1 to Length(lineaTexto) do
				begin

					PoblacionVivosYZombies:=ObtenerPoblacionVivosYZombies(j,i);
					write(VisualizarMapaSegunPoblacion(lineaTexto[j],PoblacionVivosYZombies));

				end;
				i:=i+1;
				writeln;

			end;

			writeln;
			close(archivoTexto);
			VisualizarDescripcionPoblacion();
		end;
	end;

	// Devuelve una cadena con la cantidad personas vivas y personas zombies
	Function ObtenerPoblacionVivosYZombies(x,y:integer):string;
	var

		Poblacion : file of TPoblaciones;
		DatoTemporal : TPoblaciones;
		i: Integer;
		PoblacionVivos,PoblacionZombies : string;

	begin;

		Assign(Poblacion, 'Poblaciones.DAT');

		if not FileExists('Poblaciones.DAT') then
		begin
			Writeln('El archivo Poblaciones.DAT no existe.');
		end
		else
		begin
			Reset(Poblacion);
			for i := 1 to FileSize(Poblacion) do
			begin

				Read(Poblacion, DatoTemporal);

				if (DatoTemporal.PuntoX=x) and (DatoTemporal.PuntoY=y) then
				begin
					PoblacionVivos:=IntToStr(DatoTemporal.CantSuceptibles);
					PoblacionZombies:=IntToStr(DatoTemporal.CantZombies);
					break;
				end;
			end;

		Close(Poblacion);

		ObtenerPoblacionVivosYZombies:=PoblacionVivos+'&'+PoblacionZombies;

		end;
	end;

	// Devuelve un caracter pintado con colores de ciertas caracteristicas
	Function VisualizarMapaSegunPoblacion(caracter:char; VivosZombies:string):char;
	var

		Vivos,Zombies:longInt;

	begin

		textbackground(black);

		Val(copy(VivosZombies, 1, pos('&',VivosZombies)-1), Vivos);	// Obtenemos y almacenamos la cantidad de Personas Vivas en la variable 'Vivos'
		Val(copy(VivosZombies, pos('&',VivosZombies)+1, Length(VivosZombies)-pos('&',VivosZombies)), Zombies);	// Obtenemos y almacenamos la cantidad de Personas Zombies en la variable 'Zombies'

		if Vivos > 75 then
			textcolor(LightGreen)

		else
		if Vivos > 50 then
			textcolor(LightBlue)

		else
		if Vivos > 25 then
			textcolor(Yellow)

		else
			textcolor(Magenta);

		if (Vivos=0) and (Zombies<=25) then
			textcolor(LightRed);

		VisualizarMapaSegunPoblacion:=caracter;

	end;

	Procedure VisualizarDescripcionPoblacion;
	begin

		TextColor(LightGreen);
		TextBackground(Black);
		Writeln('                            LEYENDA ');
		Writeln;
		Write('           '); PintarFondo('  ',10); Write('    '); PintarTexto('Area con poblacion de vivos > 75',10);					// LightGreen
		Write('           '); PintarFondo('  ',9);  Write('    '); PintarTexto('Area con poblacion de vivos > 50',9);					// LightBlue
		Write('           '); PintarFondo('  ',14); Write('    '); PintarTexto('Area con poblacion de vivos > 25',14);					// Yellow
		Write('           '); PintarFondo('  ',5);  Write('    '); PintarTexto('Area con poblacion de vivos < = 25',5);					// Magenta
		Write('           '); PintarFondo('  ',12); Write('    '); PintarTexto('Area con poblacion de vivos = 0 y zombies <= 25',12);	// LightRed
		writeln;
		TextColor(LightGreen);
		TextBackground(Black);

	end;

	Procedure VisualizarDescripcionSimulacion;
	begin

		TextColor(LightGreen);
		TextBackground(Black);
		Writeln('                               LEYENDA ');
		Writeln;
		Write('              '); PintarFondo('  ',7); Write('    ');  PintarTexto('Area con poblacion de Zombies = 0',7);					// LightGray
		Write('              '); PintarFondo('  ',14); Write('    '); PintarTexto('Area con poblacion de Zombies > 1',14);					// Yellow
		Write('              '); PintarFondo('  ',5); Write('    ');  PintarTexto('Area con poblacion de Zombies > 10',5);					// Magenta
		Write('              '); PintarFondo('  ',4);  Write('    '); PintarTexto('Area con poblacion de Zombies > 50',4);					// Red
		Write('              '); PintarFondo('  ',3); Write('    '); PintarTexto('Area con poblacion de Zombies < 0',3);					// Cyan
		writeln;
		TextColor(LightGreen);
		TextBackground(Black);
	end;

	Procedure PintarFondo(cadena:string; color:byte);
	begin

		TextBackground(color);
		write(cadena);
		TextBackground(black);

	end;

	Procedure PintarTexto(cadena:string; color:byte);
	begin

		TextBackground(black);
		TextColor(color);
		writeln(cadena);

	end;

	Procedure ActualizarPoblacionMundial;
	var

		PoblacionAnterior : file of TPoblaciones;
		PoblacionNueva : file of TPoblaciones;
		DatoTemporalAnterior : TPoblaciones;
		DatoTemporalNuevo : TPoblaciones;
		k : Integer;

		S_ultimo,Z_ultimo,R_ultimo,I_ultimo,S,Z,R,I: longInt;
		alpha,beta,delta,xi,pi,rho : Real;
		{
		alpha = Factor de salvacion ante ataque
		beta  = Factor de transmision
		delta = Factor de muerte por causa natural
		xi    = Factor de Resurreccion Zombi
		pi    = Tasa de natalidad
		rho   = Factor Latente de infeccion
		}

	begin

		Assign(PoblacionAnterior, 'Poblaciones.DAT');
		Rename(PoblacionAnterior,'Poblaciones.tmp');

		Assign(PoblacionNueva,'Poblaciones.DAT');
		rewrite(PoblacionNueva);

		if not FileExists('Poblaciones.DAT') then
		begin

			Writeln('El archivo Poblaciones.DAT no existe.');

		end
		else
		begin

			Reset(PoblacionAnterior);
			Writeln;

			for k := 1 to FileSize(PoblacionAnterior) do
			begin

				Read(PoblacionAnterior, DatoTemporalAnterior);
				S:=DatoTemporalAnterior.CantSuceptibles;
				I:=DatoTemporalAnterior.CantInfectados;
				Z:=DatoTemporalAnterior.CantZombies;
				R:=DatoTemporalAnterior.CantRemovidos;

				pi:=BuscarFactor('pi');
				beta:=BuscarFactor('be');
				delta:=BuscarFactor('de');
				rho:=BuscarFactor('ro');
				xi:=BuscarFactor('xi');
				alpha:=BuscarFactor('al');

				S_ultimo:= Trunc((pi * (S + I)) - (beta * S * Z) - (delta * S));
				I_ultimo:= Trunc((beta * S * Z) - (delta * I) - (rho * I));

				R_ultimo:= Trunc((delta * S) + (delta * I) + (alpha * S * Z) - (rho * R));
				Z_ultimo:= Trunc((rho * I) + (xi * R) - (alpha * S * Z));

				// Actualizo el valor de las nuevas poblaciones:
				DatoTemporalNuevo.PuntoX:=DatoTemporalAnterior.PuntoX;
				DatoTemporalNuevo.PuntoY:=DatoTemporalAnterior.PuntoY;
				DatoTemporalNuevo.Descripcion:=DatoTemporalAnterior.Descripcion;

				DatoTemporalNuevo.CantSuceptibles := S_ultimo;
				DatoTemporalNuevo.CantInfectados := I_ultimo;
				DatoTemporalNuevo.CantZombies := Z_ultimo;
				DatoTemporalNuevo.CantRemovidos := R_ultimo;

				DatoTemporalNuevo.TasaNatalidad:=pi;
				DatoTemporalNuevo.FactorMovilidad:=DatoTemporalAnterior.FactorMovilidad;

				write(PoblacionNueva,DatoTemporalNuevo);

			end;

			close(PoblacionNueva);
			close(PoblacionAnterior);
			erase(PoblacionAnterior);

		end;
	end;

	Function BuscarFactor(codigoFactor:string):real;
	var

		Factores : file of TFactores;
		DatoTemporal : TFactores;

	begin

		Assign(Factores,'Factores.DAT');
		reset(Factores);
		if not FileExists('Factores.DAT') then
		begin

			Writeln('El archivo Factores.DAT no existe.');

		end
		else
		while not eof(Factores) do
		begin

			read(Factores,DatoTemporal);
			if (DatoTemporal.Codigo=codigoFactor) then
			begin

				BuscarFactor:=DatoTemporal.Valor;
				break; // Rompe el ciclo for

			end;
		end;

		close(Factores);
	end;

	function VerNegativo(nro:integer):integer;
	begin
		if (nro < 1) then
			VerNegativo:=0
		else
			VerNegativo:=nro;
	end;

end.
