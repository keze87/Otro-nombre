PROGRAM Zombie;

USES 

	crt,Introduccion,MenuPcpal,ProceduresVarios;
	
VAR

	SalidaMenu : integer;
	
BEGIN

	IntroZ;
	
	Menu (SalidaMenu);
	
	{case SalidaMenu of
		1: Terreno;
		2: Poblaciones;
		3: Factores;
		4: Mundo;
		5: SimulacionR;
		6: SimulacionN;
		7: DesacA;
		8: ActiA;
	end;}
	
END.
