Unit AnalisisZombi;

interface

	type

		TFactores = record
			Codigo{de factor} : string[2];
			Descripcion : string[30];
			Valor : real;
			end;

	procedure Calculo (var S : longInt; var Z : longInt; var R : longInt; var I : longInt; alfa : real; beta : real; delta : real; xi : real; pi : real; rho :real);

implementation

	procedure Calculo (var S : longInt; var Z : longInt; var R : longInt; var I : longInt; alfa : real; beta : real; delta : real; xi : real; pi : real; rho :real);

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

		Sa : Real;
		Za : Real;
		Ra : Real;
		Ia : Real;

	begin

		Sa :=  S + (( pi * ( S + I )) - ( beta * S * Z ) - ( delta * S ));

		Ia := I + (( beta * S * Z ) - ( delta * I ) - ( rho * I ));

		Za := Z + (( rho * I ) + ( xi * R ) - ( alfa * S * Z ));

		Ra := R + (( delta * S ) + ( delta * I ) + ( alfa * S * Z ) - ( xi * R ));

		if Sa > 0 then
			S := abs(trunc(Sa))
		else
			S := 0;

		if Ia > 0 then
			I := abs(trunc(Ia))
		else
			I := 0;

		if Za > 0 then
			Z := abs(trunc(Za))
		else
			Z := 0;

		if Ra > 0 then
			R := abs(trunc(Ra))
		else
			R := 0;

	end;

end.
