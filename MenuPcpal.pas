unit MenuPcpal; 

interface

	Procedure Menu (var SalidaMenu : integer);
	Procedure MenuSimulacion(var SalidaMenuSim : integer);
    Procedure MenuTerreno(var SalidaMenuTerr : integer);
    Procedure MenuPoblaciones(var SalidaPobl : integer);
    Procedure MenuFactores(var SalidaFac : integer);
    Procedure MenuMundo(var SalidaMundo : integer);



implementation

	Uses

		crt,ProceduresVarios;
		
	Const
	
		Velocidad = 30;

	Procedure MenuMundo(var SalidaMundo : integer);

	begin

					ClrScr;
					writeln;
                    GotoXY(20,1);
					EscrDelay(Velocidad,'**** Mundo ****');
					GotoXY(1,4);
					EscrDelay(Velocidad,'Inserte descripcion de mundo aqui.');
					writeln;
                    GotoXY(27,22);
					EscrDelay(Velocidad,'1) Volver al Menu Principal');
					writeln;

					repeat
						LeerINT(SalidaMundo);
					until ((SalidaMundo > 0) and (SalidaMundo < 2));

					Menu(SalidaMundo);
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

					Menu(SalidaFac);
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

					Menu(SalidaPobl);
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
						2 : SalidaMenuSim := 6;
                        3 : Menu(SalidaMenuSim);
					end;
    end;

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
			EscrDelay(Velocidad,'5) Simulacion');
			writeln;
            EscrDelay(Velocidad,'6) Salir del Programa');
			writeln;
			EscrDelay(Velocidad,'Ingrese la opcion deseada');
			writeln;

			repeat
                  
                 LeerINT(SalidaMenu);

			until ((SalidaMenu > 0) and (SalidaMenu < 7));

			case SalidaMenu of
				1 : MenuTerreno(SalidaMenu);
                2 : MenuPoblaciones(SalidaMenu);
                3 : MenuFactores(SalidaMenu);
                4 : MenuMundo(SalidaMenu);
				5 : MenuSimulacion(SalidaMenu);
				6 : halt;

                                end;
				end;

	end.

end.
