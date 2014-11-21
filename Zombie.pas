PROGRAM Zombie;

USES

	crt,Introduccion,MenuPcpal,ProceduresVarios;

VAR

	SalidaMenu : integer;

BEGIN

	IntroZ;

	CrearArchivos;

	Menu (SalidaMenu);

END.
