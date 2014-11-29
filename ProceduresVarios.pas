Unit ProceduresVarios;

interface

	Procedure EscrDelay(tiempo:integer;cadena:string);

	Procedure LeerINT (var Variable : integer);

	Procedure LeerReal (var Variable : Real);

	Procedure CrearArchivos;

	Procedure EditarFactores(var Salida : integer);

	//Procedure CrearMatriz(var Matriz : array of TMatriz; var X : integer ; var Y : integer);

	function Aleatorio(limit:longint):longint;

// AGREGADO:

	Procedure MostrarTerrenosDAT;

	Procedure LeerArchivo(nombre:string);

	Function VisualizarMapaConColores(caracter:char):char;

	Procedure LeerArchivoSegunPoblacion(nombre:string);

	Function ObtenerPoblacionVivosYZombies(x,y:integer):string;

	Function VisualizarMapaSegunPoblacion(caracter:char; VivosZombies:string):char;

	Procedure VisualizarDescripcionPoblacion();

	Procedure PintarFondo(cadena:string; color:byte);

	Procedure PintarTexto(cadena:string; color:byte);

	Procedure ActualizarPoblacionMundial();

	Function BuscarFactor(codigoFactor:string):real;

	Procedure RecorrerMapa(x:integer;y:integer);

	Procedure MostraPoblacionPuntoXY(x:integer;y:integer);

implementation

Uses

	crt,MenuPcpal,SysUtils;


Type

	TTerrenos = record
		Codigo{de terreno} : integer; // la guia dice char;
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
		Codigo{de factor} : string[2];
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
		var

			Mapa : Text;
			MapaB: text;
			texto:string;
			i:integer;
			j:integer;
			longitud:integer;

			Terrenos : file of TTerrenos;
			auxT : TTerrenos;
			Poblaciones : file of TPoblaciones;
			auxP : TPoblaciones;
			Factores : file of TFactores;
			auxF : TFactores;

		begin

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
			auxF.Valor := 0.5 ;

			write(Factores,auxF);

			{beta}

			auxF.Codigo := 'be' ;
			auxF.Descripcion := ' Transmisión ' ;
			auxF.Valor := 0.1 ;

			write(Factores,auxF);

			{delta}

			auxF.Codigo := 'de' ;
			auxF.Descripcion := ' Muerte por causa natural ' ;
			auxF.Valor := 0.5 ;

			write(Factores,auxF);

			{xi}

			auxF.Codigo := 'xi' ;
			auxF.Descripcion := ' Resurreccion Zombie ' ;
			auxF.Valor := 0.1 ;

			write(Factores,auxF);

			{pi}

			auxF.Codigo := 'pi' ;
			auxF.Descripcion := ' Tasa de natalidad ' ;
			auxF.Valor := 0.8 ;

			write(Factores,auxF);

			{rho}

			auxF.Codigo := 'ro' ;
			auxF.Descripcion := ' Latente de infección ' ;
			auxF.Valor := 0.5 ;

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
						auxP.CantSuceptibles:= Aleatorio(300);
						auxP.CantInfectados:= 0;
						auxP.CantZombies:= 0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'1': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona pueblerina';
						auxP.CantSuceptibles:= Aleatorio(1000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'2': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona selvatica';
						auxP.CantSuceptibles:= Aleatorio(600);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'3': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona de montes';
						auxP.CantSuceptibles:= Aleatorio(2000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'4': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona mediamente poblada';
						auxP.CantSuceptibles:= Aleatorio(4000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'5': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona poblada';
						auxP.CantSuceptibles:= Aleatorio(6000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'6': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona de montana';
						auxP.CantSuceptibles:= Aleatorio(1000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'7': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona rural';
						auxP.CantSuceptibles:= Aleatorio(1000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'8': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona densamente poblada';
						auxP.CantSuceptibles:= Aleatorio(10000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

						end;

					'9': begin

						auxP.PuntoX:=i;
						auxP.PuntoY:=j;
						auxP.Descripcion:='Zona de recepcion de migracion';
						auxP.CantSuceptibles:= Aleatorio(50000);
						auxP.CantInfectados:=0;
						auxP.CantZombies:=0;
						auxP.CantRemovidos:= Aleatorio(300);
						auxP.TasaNatalidad:= random;
						auxP.FactorMovilidad:= random;

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
				//write(Poblaciones,auxP);

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

		end;

	function Aleatorio(limit:longint):longint;
	begin

		Randomize;

		Aleatorio := abs(random(limit));//abs(temp mod limit);

	end;

	Procedure EditarFactores(var Salida : integer);
		const

			velocidad = 15;

		var

			FactoresViejos : file of TFactores;
			Factores : file of TFactores;
			auxF : TFactores;
			auxFV : TFactores;

		begin

			Assign(FactoresViejos,'Factores.DAT');
			Rename(FactoresViejos,'Factores.TMP');
			reset(FactoresViejos);

			Assign(Factores,'Factores.DAT');
			rewrite(Factores);

			clrscr;
			writeln;

			read(FactoresViejos,auxFV);

			write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

			auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

			read(FactoresViejos,auxFV);

			write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

			auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

			read(FactoresViejos,auxFV);

			write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

			auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

			read(FactoresViejos,auxFV);

			write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

			auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

			read(FactoresViejos,auxFV);

			write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

			auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

			read(FactoresViejos,auxFV);

			write (' '); EscrDelay(-Velocidad,'Factor'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

			auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

			close(Factores);
			//erase(FactoresViejos);
			close(FactoresViejos);
			erase(FactoresViejos);

			MenuFactores(Salida);

		end;

// AGREGADO!!! Muestra los datos de los terrenos que estan almacenadas por defecto
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
		Writeln('                              LEYENDA ');
		Writeln;
		for i := 1 to FileSize(Terreno) do
		begin
			Read(Terreno, DatoTemporal);
			Write('              Codigo : ', DatoTemporal.Codigo);
			Write('  Descripcion : ', DatoTemporal.Descripcion);
			Writeln;
		end;
		Close(Terreno);
		Writeln('               Otro       Descripcion : Otros terrenos');
	end;

end;

// AGREGADO!!!. Leemos el archivo 'mapamundi.txt' con algunos colores basicos
Procedure LeerArchivo(nombre:string);
var
	archivoTexto: text;
	caracter:char;
begin
	assign(archivoTexto,nombre);
	{$I-}
	reset(archivoTexto);
	{$I+}
	if ioresult<>0 then
		Writeln('El archivo ', nombre, ' no existe.')
	else
	begin
		while not eof(archivoTexto) do
		begin
			read(archivoTexto,caracter);
			write(VisualizarMapaConColores(caracter));
		end;
		writeln;
		close(archivoTexto);
		TextColor(LightGreen);				// Volvemos a colocar el Texto en color Verde claro
		TextBackground(Black);				// Volvemos a colocar el fondo del texto en color Negro
	end;
end;

// AGREGADO!!!. Funcion que devuelve un caracter con el color de texto y color de fondo
Function VisualizarMapaConColores(caracter:char):char;
begin;
	textbackground(LightCyan);
	case caracter of
		'0' : textcolor(Yellow);
		'1' : textcolor(LightRed);
		'2' : textcolor(LightGreen);
		'3' : textcolor(Green);
		'4' : textcolor(LightMagenta);
		'5' : textcolor(Blue);
		'6' : textcolor(Magenta);
		'7' : textcolor(LightRed);
		'8' : textcolor(LightBlue);
		'9' : textcolor(white);
		else  textcolor(black);
	end;
	VisualizarMapaConColores:=caracter;	// Devolvemos el caracter con ciertos colores
end;

// AGREGADO!!!. Leemos el archivo 'mapamundi.txt' segun en enunciado del Trabajo Practico
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

// Funcion que devuelve una cadena con la cantidad personas vivas y personas zombies
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

// Funcion que devuelve un caracter pintado con colores de ciertas caracteristicas
	Function VisualizarMapaSegunPoblacion(caracter:char; VivosZombies:string):char;
	var

		Vivos,Zombies:longInt;
		error:integer;

	begin

		textbackground(LightCyan);
		//Vivos:=StrToInt(copy(VivosZombies, 1, pos('&',VivosZombies)-1));
		//Zombies:=StrToInt(copy(VivosZombies, pos('&',VivosZombies)+1, Length(VivosZombies)-pos('&',VivosZombies)));

		Val(copy(VivosZombies, 1, pos('&',VivosZombies)-1), Vivos, error);												// Obtenemos y almacenamos la cantidad de Personas Vivas en la variable 'Vivos'
		Val(copy(VivosZombies, pos('&',VivosZombies)+1, Length(VivosZombies)-pos('&',VivosZombies)), Zombies, error);	// Obtenemos y almacenamos la cantidad de Personas Zombies en la variable 'Zombies'

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

		VisualizarMapaSegunPoblacion:=caracter;			// Devolvemos el caracter con ciertos colores

	end;

	Procedure VisualizarDescripcionPoblacion();
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
		TextColor(LightGreen);				// Volvemos a colocar el Texto en color Verde claro
		TextBackground(Black);				// Volvemos a colocar el fondo del texto en color Negro

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

	Procedure ActualizarPoblacionMundial();
	var

		PoblacionAnterior : file of TPoblaciones;
		PoblacionNueva : file of TPoblaciones;
		DatoTemporalAnterior : TPoblaciones;
		DatoTemporalNuevo : TPoblaciones;
		k : Integer;

		S_ultimo,Z_ultimo,R_ultimo,I_ultimo,S,Z,R,I: longInt;
		//	S = Susceptibles, Z = Zombies, R = Removidos. I = Infectados
		alpha,beta,delta,xi,pi,rho : Real;
		{
		alpha = Factor de salvaciÃ³n ante ataque
		beta  = Factor de transmisiÃ³n
		delta = Factor de muerte por causa natural
		xi    = Factor de ResurrecciÃ³n Zombi
		pi    = Tasa de natalidad
		rho   = Factor Latente de infecciÃ³n
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

				pi:=BuscarFactor('pi');
				beta:=BuscarFactor('be');
				delta:=BuscarFactor('de');
				rho:=BuscarFactor('ro');
				xi:=BuscarFactor('xi');
				alpha:=BuscarFactor('al');

				S_ultimo:= Trunc((pi * (S + I)) - (beta * S * Z) - (delta * S));		// Trunc elimina la parte decimal
				I_ultimo:= Trunc((beta * S * Z) - (delta * I) - (rho * I));

				R:=0;															// Si y solo si R = 0
				R_ultimo:= Trunc((delta * S) + (delta * I) + (alpha * S * Z) - (rho * R));
				Z_ultimo:= Trunc((rho * I) + (xi * R) - (alpha * S * Z));				// Revisar!!!! porque R siempre sera R = 0, ya que R no se guarda en ningun lado

				// Actualizamos el valor de las nuevas poblaciones:
				DatoTemporalNuevo.PuntoX:=DatoTemporalAnterior.PuntoX;
				DatoTemporalNuevo.PuntoY:=DatoTemporalAnterior.PuntoY;
				DatoTemporalNuevo.Descripcion:=DatoTemporalAnterior.Descripcion;

				DatoTemporalNuevo.CantSuceptibles := S_ultimo;
				DatoTemporalNuevo.CantInfectados := I_ultimo;
				DatoTemporalNuevo.CantZombies := Z_ultimo;

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
				break;				// Rompemos el ciclo for

			end;
		end;

		close(Factores);
	end;

	Procedure RecorrerMapa(x:integer;y:integer); // Inicia en x=1, y=5
	var

		tecla:char;
		Xinicial,Yinicial,Xfinal,Yfinal:integer;

	begin

		Xinicial:=x;
		Yinicial:=y;
		Xfinal:=73;				// EL mapa consta de un maximo de 73 en x (ancho)
		Yfinal:=(y-1)+37;		// EL mapa consta de un maximo de 37 en y (alto)

		repeat
			repeat

				tecla:=readkey;

			until (tecla='H') or (tecla='P') or (tecla='M') or (tecla='K')or (tecla=chr(27)) ;		// Verif8ica que solo sean las FLECHAS o ESC

			case tecla of
			'H': begin	// ARRIBA

					if (y > Yinicial) then
					begin

						y:=y-1;
						gotoxy(x,y);
						MostraPoblacionPuntoXY(x,y-5);
						gotoxy(x,y);

					end
					else sound (820);

				end;

			'P': begin	// ABAJO

					if (y < Yfinal) then
					begin

						y:=y+1;
						gotoxy(x,y);
						MostraPoblacionPuntoXY(x,y-5);
						gotoxy(x,y);

					end
					else sound (820);

				end;

			'M': begin	// DERECHA

					if (x < Xfinal) then
					begin

						x:=x+1;
						gotoxy(x,y);
						MostraPoblacionPuntoXY(x,y-5);
						gotoxy(x,y);

					end
					else sound (820);

				end;

			'K': begin	// IZQUIERDA

					if (x > Xinicial) then
					begin

						x:=x-1;
						gotoxy(x,y);
						MostraPoblacionPuntoXY(x,y-5);
						gotoxy(x,y);

					end
					else sound (820);

				end;
			end;
		until tecla=chr(27);				// chr(27) = ESC

	end;

	Procedure MostraPoblacionPuntoXY(x:integer;y:integer);
	var

		Poblacion : file of TPoblaciones;
		DatoTemporal : TPoblaciones;
		i ,k: Integer;

	begin

		Assign(Poblacion, 'Poblaciones.DAT');
		if not FileExists('Poblaciones.DAT') then
		begin

			Writeln('El archivo Poblaciones.DAT no existe.');

		end
		else
		begin

			Reset(Poblacion);
			Writeln;
			for i := 1 to FileSize(Poblacion) do
			begin

				Read(Poblacion, DatoTemporal);

				if (DatoTemporal.PuntoX=x) and (DatoTemporal.PuntoY=y) then
				begin

					gotoxy(2,52);
					delline;
					Write(' X = ', DatoTemporal.PuntoX);
					Write(', Y = ', DatoTemporal.PuntoY);
					Write(', Descripcion = ', DatoTemporal.Descripcion);
					Write(', Habitantes = ', DatoTemporal.CantSuceptibles);
					break;

				end;
			end;

			Close(Poblacion);
		end;
	end;
end.
