Unit AnalisisZombi;

interface

	type

		TFactores = record
			Codigo{de factor} : string[2];
			Descripcion : string[30];
			Valor : real;
			end;

		TRegMatriz = record
			codigo : char;
			Descripcion : string;
			caracter : char;
			CantSuceptibles : real;
			CantInfectados : real;
			CantZombies : real;
			TasaNatalidad : real;
			FactorMovilidad : real;
			end;

		TMatriz = array[1..100,1..100] of TRegMatriz;



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

		Sa := pi * ( S + I ) - beta * S * Z - delta * S;

		Ia := beta * S * Z - delta * I - rho * I;

		Za := rho * I + xi * R - alfa * S * Z;

		Ra := delta * S + delta * I + alfa * S * Z - rho * R;

		S := trunc(Sa);
		I := trunc(Ia);
		Z := trunc(Za);
		R := trunc(Ra);

	end;

	procedure ActualizarMatriz (var Matriz : TMatriz);
	var

		Factores : file of TFactores;
		auxF : TFactores;
		alfa : real;
		beta : real;
		delta : real;
		xi : real;
		pi : real;
		rho : real;

	begin

		Assign(Factores,'Factores.DAT');
		reset(Factores);

		repeat

			read(Factores,auxF);

			case auxF.Codigo of

				'al' : alfa := auxF.Valor;
				'be' : beta := auxF.Valor;
				'de' : delta := auxF.Valor;
				'xi' : xi := auxF.Valor;
				'pi' : pi := auxF.Valor;
				'ro' : rho := auxF.Valor;

			end;

		until EOF(Factores);

	end;

end.
