unit Simulacion;



interface



type



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



	Procedure MostrarMapa(var SalidaMapa:integer; var ruta:string);



	Procedure ImprLineasMapa(var lineatexto:string);



	Procedure ModifSimulacion(dias:integer; periodo:integer; ruta:string);



	Procedure MostrarPoblaciones(x:integer;y:integer; var Mapatriz:TMatriz);



	Procedure CrearMatriz(var MatrizMapa:TMatriz);



	Procedure DibujarMatriz (var Mapatriz : TMatriz ; topex : integer ; topey : integer ; x : integer ; y : integer);



	Procedure Pausa(var caracter:char;var Mapatriz:TMatriz);
	
	
	
	Procedure NuevoFoco(var i:integer;var j:integer;var Mapatriz:TMatriz);



implementation



	Uses



		crt,ProceduresVarios,MenuPcpal;



	Type



{		TMatriz = record

				Codigo : char;

				Descripcion : string;

				end;}



		TPoblaciones = record

		PuntoX : integer;

		PuntoY : integer;

		Descripcion : string[30];

		CantSuceptibles : longInt;

		CantInfectados : longInt;

		CantZombies : longInt;

		TasaNatalidad : real;

		FactorMovilidad : real;

		end;





	TFactores = record

		Codigo{de factor} : string[2];

		Descripcion : string[30];

		Valor : real;

		end;
		
		
	Procedure NuevoFoco(var i:integer;var j:integer;var Mapatriz:TMatriz);


        Var

           foco:integer;

        Begin


                GotoXY(1,25);

                write('Ingrese cantidad de infectados: ');

                LeerINT(foco);

                mapatriz[i,j].CantInfectados:=mapatriz[i,j].CantInfectados+foco;

                GotoXY(i,j);



        end;



	Procedure Pausa(var caracter:char;var mapatriz:TMatriz);

		var



			key:char;

			i:integer;

			j:integer;



	begin



		j:=1;

		i:=1;



		repeat

			delay(33);

			{   if keypressed then

				begin     }



{				repeat



				until keypressed;}



				key:=readkey;

				if key = 'f' then



                                        NuevoFoco(i,j,mapatriz);



				if key = 'i' then



					mostrarpoblaciones(i,j,mapatriz);





					if  (key = #0) then

					begin



						key:=readkey;



							case key of

							#72 : if j>1 then begin j:=j-1; gotoxy(i,j); end;

							#80 : begin j:=j+1; gotoxy(i,j); end;

							#75 : if i>1 then begin i:=i-1; gotoxy(i,j); end;

							#77 : begin i:=i+1; gotoxy(i,j); end;

							end;

{       end;   }



				end;



			until key='p';

		end;



	Procedure DibujarMatriz (var Mapatriz : TMatriz ; topex : integer ; topey : integer ; x : integer ; y : integer);

		var



			k : integer;

			j : integer;



		begin



			clrscr;

			for j := 1 to topey-1 do //Experimental

				begin



					for k := 1 to topex do

					begin



						if ((k = x) and (j = y)) then

							textbackground(green);

						if ((k <> x) or (j <> y)) then

							textbackground(black);



						case Mapatriz[k,j].Codigo of



							' ' : begin write(Mapatriz[k,j].Codigo); end;

							'0' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;

							'1' : begin textcolor(green); write(Mapatriz[k,j].Codigo); end;

							'2' : begin textcolor(lightgreen); write(Mapatriz[k,j].Codigo); end;

							'3' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;

							'4' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;

							'5' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;

							'6' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;

							'7' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;

							'8' : begin textcolor(magenta); write(Mapatriz[k,j].Codigo); end;

							'9' : begin textcolor(red); write(Mapatriz[k,j].Codigo); end;



						end;



					end;

				writeln;

				end;

	end;



	Procedure CrearMatriz(Var MatrizMapa : TMatriz);

		var



			Mapa : text;

			aux : string;

			i : integer;

			j : integer;

			regPoblacion : TPoblaciones;

			Poblaciones: file of TPoblaciones;



		begin



			j:=1;



			Assign(Mapa,'mapamundi.txt');

			Assign(Poblaciones,'Poblaciones.DAT');

			reset(Mapa);



			while not eof(Mapa) do

			begin



				readln(Mapa,aux);



				for i:=1 to length(aux) do

				begin



				//	MatrizMapa[i,j].caracter := aux[i];

					MatrizMapa[i,j].codigo := aux[i];





				end;

			j:=j+1;

			end;



			close(Mapa);



			reset(Poblaciones);



			while not eof(Poblaciones) do

			begin



				read(Poblaciones,regPoblacion);

				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].CantSuceptibles:=regPoblacion.CantSuceptibles;

				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].CantInfectados:=regPoblacion.CantInfectados;

				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].CantZombies:=regPoblacion.CantZombies;

				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].TasaNatalidad:=regPoblacion.TasaNatalidad;

				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].FactorMovilidad:=regPoblacion.FactorMovilidad;

				MatrizMapa[regPoblacion.PuntoX,regPoblacion.PuntoY].Descripcion:=regPoblacion.Descripcion;

			end;



			close(Poblaciones);



end;



	Procedure MostrarPoblaciones(x:integer; y:integer;var mapatriz:TMatriz);

		{var}



		        {x : integer;

			y : integer;

			l : integer;

			m : integer:

			Mapatriz : array [1..100,1..100] of TRegMatriz;

			topex : integer;

			topey : integer;

			aux : string;

			Mapa : text;

			Poblaciones : file of TPoblaciones;

			auxP : TPoblaciones;

			clchar : char;  }



		begin





                                gotoxy(1,25);    {y donde pueda ser visto segun linux}

				write(x,' ',y,' ',mapatriz[x,y].Descripcion);

                                gotoxy(x,y);



	end;





	Procedure ModifSimulacion(dias:integer; periodo:integer; ruta:string);

		var



			i : integer;

			j : integer;

			k : integer;

			l : integer;

			m : integer;

			clchar : char;

			Salida : integer;

			Mapatriz : TMatriz;

			topex : integer;

			topey : integer;

			aux : string;

			Mapa : text;



		begin



			clrscr;

			Salida := 1;

			i := 1;

			CrearMatriz(Mapatriz);



		        Assign(Mapa,'mapamundi.txt');

			reset(Mapa);



			topex := -213;



			m := 0;



			repeat



				readln(Mapa,aux);



				l := 0;



				m := m + 1;



				repeat



					l := l + 1;



					Mapatriz [l,m].Codigo := aux[l];



					if l > topex then

						topex := l;



				until l = length(aux);



			until EOF(Mapa);



			topey := m;

			writeln;





			//writeln('Esto simboliza las cosas que ocurren dia a dia');

			//writeln('Presionar P para pausar');

			//writeln('Presionar S para salir al menu');



			repeat



				textcolor(10);

				writeln('Dia : ',i,' (Pausa (P), Salir (S))');

				//writeln;



				for j := 1 to topey-1 do //Experimental

				begin



					for k := 1 to topex do

					begin



						case Mapatriz[k,j].Codigo of



							' ' : begin write(Mapatriz[k,j].Codigo); end;

							'0' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;

							'1' : begin textcolor(green); write(Mapatriz[k,j].Codigo); end;

							'2' : begin textcolor(lightgreen); write(Mapatriz[k,j].Codigo); end;

							'3' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;

							'4' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;

							'5' : begin textcolor(7); write(Mapatriz[k,j].Codigo); end;

							'6' : begin textcolor(brown); write(Mapatriz[k,j].Codigo); end;

							'7' : begin textcolor(lightgray); write(Mapatriz[k,j].Codigo); end;

							'8' : begin textcolor(magenta); write(Mapatriz[k,j].Codigo); end;

							'9' : begin textcolor(red); write(Mapatriz[k,j].Codigo); end;



						end;



					end;



					//if j <> topey then

						writeln;



				end;



				if keypressed then

				begin



					clchar:=readkey;



					if clchar='p' then



						Pausa(clchar,mapatriz);



                                       { if clchar='g' then

                                                Guardar(clchar); }



					if clchar='s' then



				               Menu(Salida);



				end;





			Delay(1000);

			i := i + 1;



			until 5<4;



			Menu(Salida);



			close(Mapa);



		end;



	Procedure ImprLineasMapa(var lineatexto:string);



	var



		I:integer;

		longitud:integer;



	begin



		longitud:=length(lineatexto);



		for I:=1 to longitud do

		begin



			case lineatexto[I] of



			' ' : begin  write(lineatexto[I]); end;

			'0' : begin textcolor(brown); write(lineatexto[I]); end;

			'1' : begin textcolor(green); write(lineatexto[I]); end;

			'2' : begin textcolor(lightgreen); write(lineatexto[I]); end;

			'3' : begin textcolor(7); write(lineatexto[I]); end;

			'4' : begin textcolor(lightgray); write(lineatexto[I]); end;

			'5' : begin textcolor(7); write(lineatexto[I]); end;

			'6' : begin textcolor(brown); write(lineatexto[I]); end;

			'7' : begin textcolor(lightgray); write(lineatexto[I]); end;

			'8' : begin textcolor(magenta); write(lineatexto[I]); end;

			'9' : begin textcolor(red); write(lineatexto[I]); end;



			end;



		textbackground(black);



		end;



	end;



	Procedure MostrarMapa(var SalidaMapa:integer; var ruta:string);



	var



		texto:string;

		mundi:text;



	begin



		ClrScr;

		Assign(mundi, ruta);

		Reset(mundi);



		while not eof(mundi) do

		begin



			readln(mundi, texto);

			ImprLineasMapa(texto);

			writeln;



		end;



	//repeat

	//LeerINT(SalidaMapa);

	//until ((SalidaMapa > 0) and (SalidaMapa < 3));

	//case SalidaMapa of

	//1 : Menu(SalidaMapa);   {guardar y volver al menu}

	//end;



	end;



end.
