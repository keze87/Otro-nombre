unit MenuPcpal; 

interface

	Procedure Menu (var SalidaMenu : integer);

implementation

	Uses
	
		crt;
		
	Procedure Menu (var SalidaMenu : integer);
		begin
		
			ClrScr;
		
			writeln;
			writeln('**** Menu Principal ****');
			writeln;
			writeln('1) Visualizar el terreno.' {(Con su debida descripcion)});
			writeln;
			writeln('2) Visualizar las poblaciones.' {(Con su debida descripcion)});
			writeln;
			writeln('3) Visualizar los factores constantes.');
			writeln;
			writeln('4) Visualizar el mundo.');
			writeln;
			writeln('5) Simulacion');
			writeln;
			writeln('Ingrese la opcion deseada');
			writeln;
			
			repeat
			
				{$I-} 
				readln(SalidaMenu);
				{$I+}
				
				if IOResult<>0 then  
					begin  
						Writeln ('Intentalo nuevamente');  
					end; 
				
			until ((SalidaMenu > 0) and (SalidaMenu < 6));
			
			if SalidaMenu = 5 then
				begin
				
					ClrScr;
					writeln;
					writeln('**** Menu Simulacion ****');
					writeln;
					writeln('1) Retomar Simulacion.');
					writeln;
					writeln('2) Empezar Simulacion.');
					writeln;
					writeln('Ingrese la opcion deseada');
					writeln;
					
					repeat
			
						{$I-} 
						readln(SalidaMenu);
						{$I+}
				
						if IOResult<>0 then  
							begin  
								Writeln ('Intentalo nuevamente');  
							end; 
				
					until ((SalidaMenu > 0) and (SalidaMenu < 3));
					
					case SalidaMenu of
						1 : SalidaMenu := 5;
						2 : SalidaMenu := 6;
					end;
				
				end;
			
		end;
end.			 
