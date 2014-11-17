PROGRAM Zombie;

USES 

	crt,Introduccion,MenuPcpal,ProceduresVarios;
	
VAR

	SalidaMenu : integer;
	
BEGIN

	IntroZ;

	CrearMapa;

	Menu (SalidaMenu);

END.
