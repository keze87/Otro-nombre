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
		7 : begin TextColor(White);halt; end;
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

	begin

		ClrScr;
		writeln;

		GotoXY(20,1);
		EscrDelay(Velocidad,'**** Factores De Expansion ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'Inserte descripcion de factores aqui.');
		writeln;
		GotoXY(27,22);
		EscrDelay(Velocidad,'1) Volver al Menu Principal');
		writeln;

		repeat
			LeerINT(SalidaFac);
		until ((SalidaFac > 0) and (SalidaFac < 2));

		case SalidaFac of
		1 : Menu(SalidaFac);
		end;

	end;

	Procedure MenuPoblaciones(var SalidaPobl : integer);

	begin

		ClrScr;
		writeln;

		GotoXY(27,1);
		EscrDelay(Velocidad,'**** Poblaciones ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'Inserte descripcion de poblaciones aqui.');
		writeln;
		GotoXY(27,22);
		EscrDelay(Velocidad,'1) Volver al Menu Principal');
		writeln;

		repeat
			LeerINT(SalidaPobl);
		until ((SalidaPobl > 0) and (SalidaPobl < 2));

		case SalidaPobl of
		1 : Menu(SalidaPobl);
		end;

	end;

	Procedure MenuTerreno(var SalidaMenuTerr : integer);

	begin

		ClrScr;
		writeln;

		GotoXY(27,1);
		EscrDelay(Velocidad,'**** Menu Terreno ****');
		GotoXY(1,4);
		EscrDelay(Velocidad,'Inserte descripcion de terreno aqui.');
		writeln;
		GotoXY(27,22);
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

	var ruta:string;
        dias:integer;

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
                        dias:=30;
                        ruta:='mapamundi.txt';
                        MostrarMapa(SalidaNueva, ruta);        {estas tres}
                        delay(3000);                           {lineas van a tener que ir}
                        ModifSimulacion(SalidaNueva, dias);    {en un procedimiento nuevo}

                        end;
		2 : begin
		writeln('Ingrese la ruta del archivo de texto');
		read(ruta);
		MostrarMapa(SalidaNueva,ruta);
		end;

	end;
	end;


	end.

end.

end.
