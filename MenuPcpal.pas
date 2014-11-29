unit MenuPcpal;

interface

	Procedure Menu (var SalidaMenu : integer);
	Procedure MenuSimulacion(var SalidaMenuSim : integer);
	Procedure MenuTerreno(var SalidaMenuTerr : integer);
	Procedure MenuPoblaciones(var SalidaPobl : integer);
	Procedure MenuFactores(var SalidaFac : integer);
	Procedure MenuMundo(var SalidaMundo : integer);
	Procedure MenuAjustes (var SalidaMenu : integer);
	Procedure MenuNuevaSim(var SalidaNueva : integer);

implementation

	Uses

		crt,ProceduresVarios,Simulacion;

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
			TasaNatalidad : integer;
			FactorMovilidad : integer;
			end;

		TFactores = record
			Codigo{de factor} : string[2];
			Descripcion : string[30];
			Valor : real;
			end;

	Const

		Velocidad = 15;

	Procedure Menu (var SalidaMenu : integer);

	begin

		textcolor(10);
		ClrScr;

		writeln;
		GotoXY(28,1);
		EscrDelay(Velocidad,'**** Menu Principal ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'1) Visualizar el terreno.' {(Con su debida descripcion)});
		writeln;
		EscrDelay(Velocidad,'2) Visualizar las poblaciones.' {(Con su debida descripcion)});
		writeln;
		EscrDelay(Velocidad,'3) Visualizar los factores constantes.');
		writeln;
		EscrDelay(Velocidad,'4) Visualizar el mundo.');
		writeln;
		EscrDelay(Velocidad,'5) Simulacion.');
		writeln;
		EscrDelay(Velocidad,'6) Ajustes.');
		writeln;
		EscrDelay(Velocidad,'7) Salir del Programa.');
		writeln;
		EscrDelay(Velocidad,'Ingrese la opcion deseada:');
		writeln;

		repeat

			LeerINT(SalidaMenu);

		until ((SalidaMenu > 0) and (SalidaMenu < 8));

		case SalidaMenu of

			1 : MenuTerreno(SalidaMenu);
			2 : MenuPoblaciones(SalidaMenu);
			3 : MenuFactores(SalidaMenu);
			4 : MenuMundo(SalidaMenu);
			5 : MenuSimulacion(SalidaMenu);
			6 : MenuAjustes(SalidaMenu);
			7 : begin TextColor(lightgray);halt; end;

		end;

	end;

	Procedure MenuMundo(var SalidaMundo : integer);
	var
		ruta : string;

	begin

		ClrScr;
		writeln;
		ruta := 'mapamundi.txt';
		GotoXY(20,1);
		EscrDelay(Velocidad,'**** Mundo ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'Inserte descripcion de mundo aqui.');
		readln;
		MostrarMapa(SalidaMundo,ruta);
		writeln;
		//GotoXY(27,22);
		textcolor(10);
		EscrDelay(Velocidad,'1) Volver al Menu Principal.');
		writeln;

		repeat

			LeerINT(SalidaMundo);

		until ((SalidaMundo > 0) and (SalidaMundo < 2));

		case SalidaMundo of

			1 : Menu(SalidaMundo);

		end;

	end;


	Procedure MenuFactores(var SalidaFac : integer);
	var
		Factores : file of TFactores;
		auxF : TFactores;

	begin

		Assign(Factores,'Factores.DAT');
		reset(Factores);

		ClrScr;
		writeln;

		GotoXY(20,1);
		EscrDelay(Velocidad,'**** Factores De Expansion ****');

		writeln;writeln;
		while not eof(Factores) do
		begin

		read(Factores,auxF);

		write (' ');EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxF.Descripcion); EscrDelay(-Velocidad,'= '); writeln(auxF.Valor:0:2);
		end;

		GotoXY(3,18);
		EscrDelay(Velocidad,'1) Editar Factores');
		GotoXY(3,20);
		EscrDelay(Velocidad,'2) Volver al Menu Principal');
		writeln;

		close(Factores);

		repeat

			LeerINT(SalidaFac);

		until ((SalidaFac > 0) and (SalidaFac < 3));

		case SalidaFac of

			1 : EditarFactores(SalidaFac);
			2 : Menu(SalidaFac);

		end;

	end;

	Procedure MenuPoblaciones(var SalidaPobl : integer);

	begin
		ClrScr;
		writeln;
		GotoXY(27,1);
		EscrDelay(Velocidad,'**** Poblaciones ****');
		writeln;
		gotoXY(1,6);
		LeerArchivo('mapamundi.txt');										
		writeln;
		EscrDelay(Velocidad,'1) Posicionar el cursor en el mapa');					
		writeln;
		EscrDelay(Velocidad,'2) Volver al Menu Principal');					
		writeln;

		repeat
			LeerINT(SalidaPobl);
		until ((SalidaPobl > 0) and (SalidaPobl < 3));

		case SalidaPobl of
			1 : begin
					gotoXY(1,3);
					writeln('Teclas de direccion para ver la descripcion y la cantidad de habitantes');
					writeln('Para salir de mapa presione ESC');	
					writeln;			
					RecorrerMapa(wherex,wherey);	
					gotoxy(1,50);
					Menu(SalidaPobl);	
					readkey;	
				end;
			2 : Menu(SalidaPobl);
		end;

	end;

	Procedure MenuTerreno(var SalidaMenuTerr : integer);

        var
		Terrenos : file of TTerrenos;
		auxT : TTerrenos;

	begin

		Assign(Terrenos,'Terrenos.DAT');
		reset(Terrenos);

		ClrScr;
		writeln;

		GotoXY(31,1);
		EscrDelay(Velocidad,'**** Terrenos ****');

		writeln;writeln;

		while not eof(Terrenos) do
		begin

		read(Terrenos,auxT);

		write (' ');EscrDelay(-Velocidad,'Area'); EscrDelay(-Velocidad,auxT.Descripcion); EscrDelay(-Velocidad,'= '); writeln(auxT.Codigo);

		writeln;
		end;
		close(Terrenos);

		GotoXY(27,24);
		EscrDelay(Velocidad,'1) Volver al Menu Principal');
		writeln;

		repeat

			LeerINT(SalidaMenuTerr);

		until ((SalidaMenuTerr > 0) and (SalidaMenuTerr < 2));

		Menu(SalidaMenuTerr);

	end;


	Procedure MenuSimulacion(var SalidaMenuSim : integer);

	begin

		ClrScr;
		writeln;
		GotoXY(27,1);
		EscrDelay(Velocidad,'**** Menu Simulacion ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'1) Retomar Simulacion.');
		writeln;
		EscrDelay(Velocidad,'2) Empezar Simulacion.');
		writeln;
		EscrDelay(Velocidad,'3) Volver al Menu Principal.');
		writeln;
		EscrDelay(Velocidad,'Ingrese la opcion deseada');
		writeln;

		repeat

			LeerINT(SalidaMenuSim);

		until ((SalidaMenuSim > 0) and (SalidaMenuSim < 4));

		case SalidaMenuSim of

			1 : SalidaMenuSim := 5;
			2 : MenuNuevaSim(SalidaMenuSim);
			3 : Menu(SalidaMenuSim);

		end;

	end;

	Procedure MenuAjustes (var SalidaMenu : integer);
	var

		A : Text;

	begin

		ClrScr;
		writeln;
		GotoXY(27,1);
		EscrDelay(Velocidad,'**** Menu Ajustes ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'1) Desactivar Introducccion.');
		writeln;
		EscrDelay(Velocidad,'2) Activar Introduccion.');
		writeln;
		EscrDelay(Velocidad,'Ingrese la opcion deseada');
		writeln;

		repeat

			LeerINT(SalidaMenu);

		until ((SalidaMenu > 0) and (SalidaMenu < 3));

		case SalidaMenu of

			1 : begin

				Assign(A,'Introduccion');
				rewrite(A);
				writeln(A,'Esto Desactiva la Introduccion');
				close(A);

				end;

			2 : begin

				Assign(A,'Introduccion');
				rewrite(A);
				close(A);

				end;

		end;

		Menu(SalidaMenu);

	end;

	Procedure MenuNuevaSim(var SalidaNueva : integer);

	var

		ruta:string;
		dias:integer;
		periodo:integer;

	begin

		ClrScr;

		GotoXY(27,1);
		EscrDelay(Velocidad,'**** Nueva Simulacion ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'Seleccione escenario:');
		GotoXY(6,6);
		EscrDelay(Velocidad,'1)Tierra');
		GotoXY(6,8);
		EscrDelay(Velocidad,'2)Escenario personalizado...');
		writeln;

		repeat

			LeerINT(SalidaNueva);

		until ((SalidaNueva > 0) and (SalidaNueva < 3));

		case SalidaNueva of

			1 : begin

				writeln;
				write('Ingrese cantidad de dias: ');
				LeerINT(dias);
				writeln;
				write('Ingrese periodo de actualizacion: ');
				LeerINT(periodo);

				ModifSimulacion(dias,periodo,'mapamundi.txt');

				end;

			2 : begin

				writeln;
				writeln('Ingrese la ruta del archivo de texto');
				read(ruta);
				write('Ingrese cantidad de dias: ');
				LeerINT(dias);
				writeln;
				write('Ingrese periodo de actualizacion: ');
				LeerINT(periodo);
				ModifSimulacion(dias,periodo,ruta);

				end;

		end;

	end;

end.
