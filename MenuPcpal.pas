unit MenuPcpal; 

interface

	Procedure Menu (var SalidaMenu : integer);

implementation

	Uses
	
		crt,ProceduresVarios;
		
	Procedure Menu (var SalidaMenu : integer);
		begin
		
			ClrScr;
		
			writeln;
			EscrDelay(50,'**** Menu Principal ****');
			writeln;
			EscrDelay(50,'1) Visualizar el terreno.' {(Con su debida descripcion)});
			writeln;
			EscrDelay(50,'2) Visualizar las poblaciones.' {(Con su debida descripcion)});
			writeln;
			EscrDelay(50,'3) Visualizar los factores constantes.');
			writeln;
			EscrDelay(50,'4) Visualizar el mundo.');
			writeln;
			EscrDelay(50,'5) Simulacion');
			writeln;
			EscrDelay(50,'Ingrese la opcion deseada');
			writeln;
			
			repeat
			
				LeerINT(SalidaMenu);
				
				if ((SalidaMenu > 5) or (SalidaMenu < 1)) then
					EscrDelay(50,'Intentalo nuevamente');
								
			until ((SalidaMenu > 0) and (SalidaMenu < 6));
			
			if SalidaMenu = 5 then
				begin
				
					ClrScr;
					writeln;
					EscrDelay(50,'**** Menu Simulacion ****');
					writeln;
					EscrDelay(50,'1) Retomar Simulacion.');
					writeln;
					EscrDelay(50,'2) Empezar Simulacion.');
					writeln;
					EscrDelay(50,'Ingrese la opcion deseada');
					writeln;
					
					repeat
			
						LeerINT(SalidaMenu);
						
						if ((SalidaMenu > 2) or (SalidaMenu < 1)) then
							EscrDelay(50,'Intentalo nuevamente');
				
					until ((SalidaMenu > 0) and (SalidaMenu < 3));
					
					case SalidaMenu of
						1 : SalidaMenu := 5;
						2 : SalidaMenu := 6;
					end;
				
				end;
			
			if SalidaMenu = 6 then
				begin
				
					ClrScr;
					writeln;
					EscrDelay(50,'**** Menu Ajustes ****');
					writeln;
					EscrDelay(50,'1) Desactivar Animaciones.');
					writeln;
					EscrDelay(50,'2) Activar Animaciones.');
					writeln;
					EscrDelay(50,'Ingrese la opcion deseada');
					writeln;
					
					repeat
			
						LeerINT(SalidaMenu);
						
						if ((SalidaMenu > 2) or (SalidaMenu < 1)) then
							EscrDelay(50,'Intentalo nuevamente');
				
					until ((SalidaMenu > 0) and (SalidaMenu < 3));
					
					case SalidaMenu of
						1 : SalidaMenu := 7;
						2 : SalidaMenu := 8;
					end;
				
				end;
			
		end;
end.			 
