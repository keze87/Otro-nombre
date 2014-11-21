Unit ProceduresVarios;

interface

Procedure EscrDelay(tiempo:integer;cadena:string);

Procedure LeerINT (var Variable : integer);

Procedure LeerReal (var Variable : Real);

Procedure CrearArchivos;

Procedure EditarFactores(var Salida : integer);

//Procedure CrearMatriz(var Matriz : array of TMatriz; var X : integer ; var Y : integer);

implementation

Uses

	crt,MenuPcpal;


TYPE

	TTerrenos = record
		Codigo{de terreno} : integer; // la guia dice char;
		Descripcion : string[30];
		end;

	TPoblaciones = record
		PuntoX : integer;
		PuntoY : integer;
		Descripcion : string[30];
		CantSuceptibles : longInt;
		CantInfectados : longInt;
		CantZombies : longInt;
		TasaNatalidad : integer;
		FactorMovilidad : integer;
		end;

	TFactores = record
		Codigo{de factor} : string[2];
		Descripcion : string[30];
		Valor : real;
		end;

	TMatriz = record
		Codigo : char;
		end;

Procedure EscrDelay(tiempo:integer;cadena:string);
	var

		longitud:integer;
		I:integer;

	begin

		longitud:=length(cadena);

		for I:=1 to longitud do
			begin
				write(cadena[I]);
				delay(abs(tiempo));
			end;

		if tiempo > 0 then
			writeln;

	end;


Procedure LeerINT (var Variable : integer);
	begin

	repeat
		{$I-}
			readln(Variable);
		{$I+}

	until not(IOResult<>0);

	end;

Procedure LeerReal (var Variable : Real);
	begin

	repeat

		{$I-}
			readln(Variable);
		{$I+}

	until not(IOResult<>0);

	end;

Procedure CrearArchivos;
	var

		Mapa : Text;
		Terrenos : file of TTerrenos;
		auxT : TTerrenos;
		Poblaciones : file of TPoblaciones;
		auxP : TPoblaciones;
		Factores : file of TFactores;
		auxF : TFactores;

	begin

		{*** Mapa ***}

		Assign(Mapa,'mapamundi.txt');
		rewrite(Mapa);

		writeln(Mapa,'                                                                         ');
		writeln(Mapa,'                   4248 4422828                                          ');
		writeln(Mapa,'                 4648 4445331818       6                2                ');
		writeln(Mapa,'           428           4449888               8  O 12428824 3  8 3      ');
		writeln(Mapa,'    2228 1 4242  42668   447668         61     4 22424382828222288283 4  ');
		writeln(Mapa,'22 4544422444228268  48  448    2      764882424482232444788141212122887 ');
		writeln(Mapa,'  345663348344488         48         768 554344282444244438882346823541  ');
		writeln(Mapa,'    4    4828248886  828            4 4  42886658248343448112112    8    ');
		writeln(Mapa,'          461888118 44282         483332476816448203232224827688A  4     ');
		writeln(Mapa,'          8468182482388S8           4373986766640200330482816881         ');
		writeln(Mapa,'          8448876686816            4487888D647604400030310008814         ');
		writeln(Mapa,'           42088764816            488 6 16  88V242440000070762  4        ');
		writeln(Mapa,'           4064878549             64    4 2778 424410000026834 2         ');
		writeln(Mapa,'            05788667               100    807600656400871618  8          ');
		writeln(Mapa,'            86577888              40000000260760085660676888             ');
		writeln(Mapa,'              6084               0000000002600T6660887661728             ');
		writeln(Mapa,'               4    5            0000600002 0006  64766668               ');
		writeln(Mapa,'               642   2           00704000028 00    86 867                ');
		writeln(Mapa,'                  8  5           416740450230      88  576  2            ');
		writeln(Mapa,'                   8 228O        4276653482468     8   4                 ');
		writeln(Mapa,'                    18121         66 656422060          6                ');
		writeln(Mapa,'                    476622A           4644209           8 41             ');
		writeln(Mapa,'                    8888812           454328            8  22  2         ');
		writeln(Mapa,'                    882122222         443248             1      68       ');
		writeln(Mapa,'                    221222288S         42248                6            ');
		writeln(Mapa,'                     2232222           66878 4                4 4        ');
		writeln(Mapa,'                      026658          408178 3              24323        ');
		writeln(Mapa,'                      476648           4078  4             2000008       ');
		writeln(Mapa,'                      4664             60583               40009008      ');
		writeln(Mapa,'                      0768            O444                 00000054      ');
		writeln(Mapa,'                      0889              6                  6   054       ');
		writeln(Mapa,'                     476                                       363       ');
		writeln(Mapa,'                     48                                               7  ');
		writeln(Mapa,'                     48                                                  ');
		writeln(Mapa,'                     8                                                   ');
		writeln(Mapa,'                      8                                                  ');
		writeln(Mapa,'                                                                         ');

		close(Mapa);

		{*** Factores ***}

		Assign(Factores,'Factores.DAT');
		rewrite(Factores);

		{alpha}

		auxF.Codigo := 'al' ;
		auxF.Descripcion := ' Salvación ante ataque ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		{beta}

		auxF.Codigo := 'be' ;
		auxF.Descripcion := ' Transmisión ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		{delta}

		auxF.Codigo := 'de' ;
		auxF.Descripcion := ' Muerte por causa natural ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		{epsilon}

		auxF.Codigo := 'ep' ;
		auxF.Descripcion := ' Resurrección Zombie ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		{pi}

		auxF.Codigo := 'pi' ;
		auxF.Descripcion := ' Tasa de natalidad ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		{rho}

		auxF.Codigo := 'ro' ;
		auxF.Descripcion := ' Latente de infección ' ;
		auxF.Valor := 0 ;

		write(Factores,auxF);

		close(Factores);

		{*** Poblaciones ***}

		Assign(Poblaciones,'Poblaciones.DAT');
		rewrite(Poblaciones);

		auxP.PuntoX := 1; if auxP.PuntoX <> 1 then write('Esto hay que cambiar');//Ni idea

		close(Poblaciones);

		{*** Terrenos ***}

		Assign(Terrenos,'Terrenos.DAT');
		rewrite(Terrenos);

		auxT.Codigo := 0 ; auxT.Descripcion:= ' desértica ';

		write(Terrenos,auxT);

		auxT.Codigo := 1 ; auxT.Descripcion:= ' pueblerina ';

		write(Terrenos,auxT);

		auxT.Codigo := 2 ; auxT.Descripcion:= ' selvática ';

		write(Terrenos,auxT);

		auxT.Codigo := 3 ; auxT.Descripcion:= ' de montes ';

		write(Terrenos,auxT);

		auxT.Codigo := 4 ; auxT.Descripcion:= ' mediamente poblada ';

		write(Terrenos,auxT);

		auxT.Codigo := 5 ; auxT.Descripcion:= ' poblada ';

		write(Terrenos,auxT);

		auxT.Codigo := 6 ; auxT.Descripcion:= ' de montaña ';

		write(Terrenos,auxT);

		auxT.Codigo := 7 ; auxT.Descripcion:= ' rural ';

		write(Terrenos,auxT);

		auxT.Codigo := 8 ; auxT.Descripcion:= ' densamente poblada ';

		write(Terrenos,auxT);

		auxT.Codigo := 9 ; auxT.Descripcion:= ' de recepción de migración ';

		write(Terrenos,auxT);

		close(Terrenos);

	end;

Procedure EditarFactores(var Salida : integer);
	const

		velocidad = 15;

	var

		FactoresViejos : file of TFactores;
		Factores : file of TFactores;
		auxF : TFactores;
		auxFV : TFactores;

	begin

		Assign(FactoresViejos,'Factores.DAT');
		Rename(FactoresViejos,'Factores.TMP');
		reset(FactoresViejos);

		Assign(Factores,'Factores.DAT');
		rewrite(Factores);

		clrscr;
		writeln;

		read(FactoresViejos,auxFV);

		write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

		auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

		read(FactoresViejos,auxFV);

		write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

		auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

		read(FactoresViejos,auxFV);

		write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

		auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

		read(FactoresViejos,auxFV);

		write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

		auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

		read(FactoresViejos,auxFV);

		write (' '); EscrDelay(-Velocidad,'Factor de'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

		auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

		read(FactoresViejos,auxFV);

		write (' '); EscrDelay(-Velocidad,'Factor'); EscrDelay(-Velocidad,auxFV.Descripcion); EscrDelay(-Velocidad,'('); write(auxFV.Valor:0:2); EscrDelay(-Velocidad,')= '); LeerReal(auxF.Valor);

		auxF.Codigo := auxFV.Codigo; auxF.Descripcion := auxFV.Descripcion; write(Factores,auxF);

		close(Factores);
		erase(FactoresViejos);
		close(FactoresViejos);
		erase(FactoresViejos);

		MenuFactores(Salida);

	end;

{Procedure CrearMatriz(var Matriz : array [1..3000,1..3000] of TMatriz ; var X : integer ; var Y : integer);
	var

		Mapa : text;
		aux : string;
		i : integer;
		k : integer;

	begin

		Assign(Mapa,'mapamundi.txt');
		reset(Mapa);

		X := -213;

		k := 0;

		repeat

			readln(Mapa,aux);

			i := 0;

			k := k + 1;

			repeat

				i := i + 1;

				Matriz [i,k].Codigo := aux[i];

			until EOL(aux);

		until EOF(Mapa);

	X := k;

	end;}

end.
