Unit AnalisisZombi;

interface

uses Simulacion, ProceduresVarios;

	type

		TFactores = record
			Codigo{de factor} : string[2];
			Descripcion : string[30];
			Valor : real;
			end;

	procedure Calculo (var Matrizmapa : TMatriz;i : integer; j : integer ; alfa : real; beta : real; delta : real; xi : real; pi : real; rho :real);

implementation

	procedure Calculo (var Matrizmapa : TMatriz;i : integer; j : integer ; alfa : real; beta : real; delta : real; xi : real; pi : real; rho :real);

	{a = actual
	S = susceptibles
	Z = zombie
	R = Removidos //Re muertos
	I = Infectados
	alfa = Factor de salvacion
	beta = Factor de trasmicion
	delta = Factor de muerte natural
	xi = Factor resurreccion
	pi = tasa de natalidad
	rho = factor latente de infeccion}

	var


		S : longint;

		Z : longint;

		R : longint;

		Inf : longint;



		Sa : longint;

		Za : longint;

		Ra : longint;

		Ia : longint;	
begin



        S := Matrizmapa [i,j].CantSuceptibles;

        Z := Matrizmapa [i,j].CantZombies;

        R := Matrizmapa [i,j].CantRemovidos;

        Inf := Matrizmapa [i,j].CantInfectados;





        Sa := trunc( S + (( pi * ( S + Inf )) - ( beta * S * Z ) - ( delta * S )));

        Ia := trunc( Inf + (( beta * S * Z ) - ( delta * Inf ) - ( rho * Inf )));

        Za := trunc( Z + (( rho * Inf ) + ( xi * R ) - ( alfa * S * Z )));

        Ra := trunc( R + (( delta * S ) + ( delta * Inf ) + ( alfa * S * Z ) - ( xi * R )));

        if Matrizmapa [i,j].CantSuceptibles + VerNegativo(Sa) >= 2147483647 then
        	Matrizmapa [i,j].CantSuceptibles := 2147483646 {o cualquier valor menor que 2147483647}
        else
        	Matrizmapa [i,j].CantSuceptibles := VerNegativo(Sa);

	if Matrizmapa [i,j].CantZombies + VerNegativo(Za) >= 2147483647 then
		Matrizmapa [i,j].CantZombies := 2147483646
	else
        	Matrizmapa [i,j].CantZombies := VerNegativo(Za);

	if Matrizmapa [i,j].CantRemovidos + VerNegativo(Ra) >= 2147483647 then
		Matrizmapa [i,j].CantRemovidos := 2147483646
	else
        	Matrizmapa [i,j].CantRemovidos := VerNegativo(Ra);

	if Matrizmapa [i,j].CantInfectados + VerNegativo(Ia) >= 2147483647 then
		Matrizmapa [i,j].CantInfectados := 2147483646
	else
        Matrizmapa [i,j].CantInfectados := VerNegativo(Ia);


	end;


end.
