Unit ProceduresVarios;

interface

Procedure EscrDelay(tiempo:integer;cadena:string); {Pone un delay entre caracter y caracter al escribir una cadena por pantalla}

Procedure LeerINT (var Variable : integer);

Procedure CrearMapa;

implementation

Uses

	crt;

Procedure EscrDelay(tiempo:integer;cadena:string);
var
	longitud:integer;
	I:integer;
begin
	longitud:=length(cadena);
	for I:=1 to longitud do
		begin
			write(cadena[I]);
			delay(tiempo);
		end;

		writeln;

end;


Procedure LeerINT (var Variable : integer);
	begin
		{$I-}
			readln(Variable);
		{$I+}

		if IOResult<>0 then
			begin
				writeln;
			end;
	end;

Procedure CrearMapa;
var
	Mapa : Text;
begin

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
	
end;



end.
