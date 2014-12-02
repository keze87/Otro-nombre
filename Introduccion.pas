unit Introduccion;

interface

	Procedure Intro (i : integer);

	Procedure IntroZ;

implementation

	Uses

		crt;

	Procedure IntroZ;
	var

		contIntro : Integer;
		A : text;
		aux : string;
		mundocruel : boolean;

	begin

		cursoroff;

		aux :='q';
		Assign(A,'Introduccion');

		{$I-}

			reset(A);

		{$I+}

		if not(IOResult<>0) then
		begin

			readln(A,aux);

			close(A);

		end;

		if not(aux = 'Esto Desactiva la Introduccion') then
		begin

			contIntro := 0;
			mundocruel := false;

			repeat

				contIntro := contIntro + 1;

				if keypressed then
				mundocruel := true;

				if not(mundocruel) then
					Intro(1);

			until contIntro = 2;

			if mundocruel then
				Delay(1000);

			if not(mundocruel) then
				Intro(7)

		end;

		cursoron;

	end;

	Procedure Intro (i : integer);
	const

		Velocidad = 300;

	var

		conti : integer;
		k : integer;

	begin

		cursoroff;

		Delay (Velocidad);
		ClrScr;

		TextColor(White);
		writeln('            O888DO');
		write('            +::~OD~');TextColor(Green);writeln('                                         ZOZO8');TextColor(White);
		write('            $:O~DD');TextColor(Green);writeln('                                          Z?8$O8');TextColor(White);
		write('            +::~~+');TextColor(Green);writeln('                                          8=8?$8');TextColor(White);
		write('            +:$$~+');TextColor(Green);writeln('                                          I?=?78');TextColor(White);
		write('              7$77');TextColor(Green);writeln('                               ?Z         I??7O8');TextColor(White);
		write('             7I?Z?Z');TextColor(Green);writeln('                               ?O7O$$8O:::77$8ZZ~');TextColor(White);
		write('            7?IZ?7Z');TextColor(Green);writeln('                                       ~   ~~:::?');TextColor(White);
		write('      =+=   7Z??77ZZZ');TextColor(Green);writeln('                                   $$$  ~  I::?');TextColor(White);
		write('      =+=   IZ?7ZZZZZ');TextColor(Green);writeln('                                   88   :  II:$');TextColor(White);
		write('         ++ 7Z7787ZII');TextColor(Green);writeln('                                         Z~ ::$');TextColor(White);
		write('            7Z7787ZII');TextColor(Green);writeln('                                         O~ ::$');TextColor(White);
		write('            7Z7787Z');TextColor(Green);writeln('                                          ZI  ::$');TextColor(White);
		write('            ZZZZZZD~');TextColor(Green);writeln('                                         8877888~');TextColor(White);
		write('            ZIIIIZD ');TextColor(Green);writeln('                                        ZZZZZZ88=');TextColor(White);
		write('            ZZZZIZD~    M                    ');TextColor(Green);writeln('             7Z888   ZZ8O');TextColor(White);
		write('           ZZZZ8IIDD8  88M              ');TextColor(Green);writeln('                ZZZ8       Z88O');TextColor(White);
		write('          ZZZD   ZIIIO              ');TextColor(Green);writeln('                   I88O         ZZ88');TextColor(White);
		write('          ZZ      $Z$                ');TextColor(Green);writeln('                  7D8            Z8');TextColor(White);
		write('         7                        ');TextColor(Green);writeln('                     OOO            =Z');TextColor(White);
		write('       $$                                   ');TextColor(Green);writeln('           78O             8');TextColor(White);
		write('      8~   ????????????                    ');TextColor(Green);writeln('            O   ?????????????Z');TextColor(White);
		write('          ???????????                        ');TextColor(Green);writeln('              ??????????????');TextColor(White);

		Delay (Velocidad);
		ClrScr;

		writeln('          8DDDN8');TextColor(White);
		write('          =::~OD             ');TextColor(Green);writeln('                                  $OOZOO');TextColor(White);
		write('          $:Z:DN        ');TextColor(Green);writeln('                                   O   7==??Z8');TextColor(White);
		write('          Z,$~~8                                     ');TextColor(Green);writeln('          8==O?Z8');TextColor(White);
		write('          =::~:+           ');TextColor(Green);writeln('                                    ???=?78');TextColor(White);
		write('           +I$~=                                        ');TextColor(Green);writeln('       ?+??7O8');TextColor(White);
		write('            $$$7,            ');TextColor(Green);writeln('                       +IZ         I77Z8Z');TextColor(White);
		write('          II?I$+???I7         ');TextColor(Green);writeln('                               ~    :::::I');TextColor(White);
		write('          7Z?I8?77Z?Z         ');TextColor(Green);writeln('                              ?+$7Z$ZOII:I');TextColor(White);
		write('          7Z?787ZZ~~+           ');TextColor(Green);writeln('                            D   ::  II,$');TextColor(White);
		write('          7Z?78IZZ~~=               ');TextColor(Green);writeln('                            ZZ:  ::$');TextColor(White);
		write('         ?7Z?7DIZZ:==        ');TextColor(Green);writeln('                                     $~ ::$');TextColor(White);
		write('       +  IZ778IZZ==        ');TextColor(Green);writeln('                                     ,DI ::$');TextColor(White);
		write('          IZII8IZZ         ');TextColor(Green);writeln('                                     OOI  ::Z');TextColor(White);
		write('          OIIIIZDD          ');TextColor(Green);writeln('                                    I7I7ZZ8D');TextColor(White);
		write('          OIIZZDDD          ');TextColor(Green);writeln('                                   I777O8DZ88');TextColor(White);
		write('         $II$8DDD8         ');TextColor(Green);writeln('                                   IIO8O    Z8');TextColor(White);
		write('         ZIZD DDDD         ');TextColor(Green);writeln('                                   7D,      O8');TextColor(White);
		write('        ZI$8   8D8 ~DM       ');TextColor(Green);writeln('                                 Z8       Z8');TextColor(White);
		write('       $Z      888DN M       ');TextColor(Green);writeln('                                 78        8');TextColor(White);
		write('       Z        ODD         ');TextColor(Green);writeln('                                  8         Z');TextColor(White);
		write('    88   +??????????+       ');TextColor(Green);writeln('                                   ?????????Z?');TextColor(White);
		write('  MMMN??+??????????????          ');TextColor(Green);writeln('                        ??????+????????8??');TextColor(White);

		Delay (Velocidad);
		ClrScr;

		write('           ODDDDO      ');TextColor(Green);writeln('                                                  O');TextColor(White);
		writeln('           +::~OD');TextColor(White);
		write('           +::~OD~     ');TextColor(Green);writeln('                                       ZZZO8O');TextColor(White);
		write('           $:$~~D      ');TextColor(Green);writeln('                                       7=??$$O');TextColor(White);
		write('           +::~~=      ');TextColor(Green);writeln('                                       8=8?$ZO');TextColor(White);
		write('            =7$~+       ');TextColor(Green);writeln('                                      7OO?$ZO');TextColor(White);
		write('             $$$$          ');TextColor(Green);writeln('                        ?O         I??7OOO');TextColor(White);
		write('            7I?IZ7$$7      ');TextColor(Green);writeln('                         ?Z77Z$$O:::77$OO$$');TextColor(White);
		write('           7Z?I8?7ZZIZ      ');TextColor(Green);writeln('                               ??77$$8II?:I');TextColor(White);
		write('           7Z?I87Z~~ZI      ');TextColor(Green);writeln('                               Z$  ~  ??::I');TextColor(White);
		write('           7Z?787Z~~~+      ');TextColor(Green);writeln('                                   O:   ::Z');TextColor(White);
		write('          I7Z?787Z~~++      ');TextColor(Green);writeln('                                    Z=  ::Z');TextColor(White);
		write('        =  7Z7787Z++=       ');TextColor(Green);writeln('                                    DI  ::Z');TextColor(White);
		write('           7Z7787Z          ');TextColor(Green);writeln('                                   OI   ::Z');TextColor(White);
		write('           ZZ$ZZZD          ');TextColor(Green);writeln('                                   88777888');TextColor(White);
		write('           ZIIIZZD~         ');TextColor(Green);writeln('                                  7Z88888Z8');TextColor(White);
		write('           ZZIIZD~          ');TextColor(Green);writeln('                                  7Z8    Z8');TextColor(White);
		write('            8ZIZZ88O M      ');TextColor(Green);writeln('                                7Z8     Z8');TextColor(White);
		write('            88ZZ88~   M      ');TextColor(Green);writeln('                               788     Z8');TextColor(White);
		write('            DD~~~              ');TextColor(Green);writeln('                             ZO      Z');TextColor(White);
		write('             D                  ');TextColor(Green);writeln('                            88      O');TextColor(White);
		write('             D                 ');TextColor(Green);writeln('                             $O');TextColor(White);
		write('      ?????MMM????????????         ');TextColor(Green);writeln('                     ????8????????????');TextColor(White);
		write('           ?????????               ');TextColor(Green);writeln('                         ????????????');TextColor(White);

		Delay (Velocidad);
		ClrScr;

		write('          ZOOOO      ');TextColor(Green);writeln('                                                     8');TextColor(White);
		write('         +~::=OD     ');TextColor(Green);writeln('                                        $Z$ZO');TextColor(White);
		write('         =:::~OD     ');TextColor(Green);writeln('                                        Z?8ZO8');TextColor(White);
		write('         $~:$~8D     ');TextColor(Green);writeln('                                     ,  $=??$8');TextColor(White);
		write('         +:::~~+     ');TextColor(Green);writeln('                                        ??=?78');TextColor(White);
		write('         =::Z$~+       ');TextColor(Green);writeln('                                      788?Z8       8');TextColor(White);
		write('     +=    ,$$$7         ');TextColor(Green);writeln('                         ?O          77$8Z');TextColor(White);
		write('     +    ?II?Z?ZZ      ');TextColor(Green);writeln('                           +O7OZZ8=::::ZO8ZZ');TextColor(White);
		write('     +   I$ZZZ77ZZ?     ');TextColor(Green);writeln('                                 +++II7$O??:I');TextColor(White);
		write('     ++++=$Z??77Z~I      ');TextColor(Green);writeln('                                $Z$  ~  I::I');TextColor(White);
		write('         IZOZZZZO~?      ');TextColor(Green);writeln('                                O:   ~  ?I:$');TextColor(White);
		write('         IZZ?787Z        ');TextColor(Green);writeln('                                      $= ::$');TextColor(White);
		write('         IZZII87Z       ');TextColor(Green);writeln('                                       O= ::$');TextColor(White);
		write('         IZZ7I87Z        ');TextColor(Green);writeln('                                     OI  ::$');TextColor(White);
		write('         $$ZZZ$$D         ');TextColor(Green);writeln('                                    8877888');TextColor(White);
		write('       $Z$O888IZD         ');TextColor(Green);writeln('                                7Z8888888Z88,');TextColor(White);
		write('      $ZZ8=  8IID          ');TextColor(Green);writeln('                              7ZZ8      OZ8,');TextColor(White);
		write('    $Z$     $IID~          ');TextColor(Green);writeln('                            788Z        Z8,');TextColor(White);
		write('      $        $ID         ');TextColor(Green);writeln('                             ZO,         Z88O');TextColor(White);
		write('       8        ZD         ');TextColor(Green);writeln('                             88,          O8O');TextColor(White);
		write('      M            D        ');TextColor(Green);writeln('                            8,            $$');TextColor(White);
		write('                    D~      ');TextColor(Green);writeln('                            8             OO');TextColor(White);
		write('    ??????????????MM?+,     ');TextColor(Green);writeln('                          +???????????????I?O??');TextColor(White);
		write('         +??????????         ');TextColor(Green);writeln('                               ??????????????');TextColor(White);

		Delay (Velocidad);
		ClrScr;

		write('            O888D8         ');TextColor(Green);writeln('                                            ');TextColor(White);
		write('            +::~OD~         ');TextColor(Green);writeln('                                ZO$O8      ');TextColor(White);
		write('            Z:O~DD        ');TextColor(Green);writeln('                                  Z?8ZO8     ');TextColor(White);
		write('            +::~~=        ');TextColor(Green);writeln('                                  8=8?$8    ');TextColor(White);
		write('            +:Z$~=         ');TextColor(Green);writeln('                                 ??=?78    ');TextColor(White);
		write('              7777         ');TextColor(Green);writeln('                      +Z         I??7O8    ');TextColor(White);
		write('             77?Z?Z+       ');TextColor(Green);writeln('                       ?O$OZ$OO:::77$8Z$:   ');TextColor(White);
		write('            I?7Z?7Z+         ');TextColor(Green);writeln('                             =,, ~~::,I:  ');TextColor(White);
		write('      ===   7Z??77ZZZ        ');TextColor(Green);writeln('                           ~Z$  ~  I::I:  ');TextColor(White);
		write('      ===   IO?7ZOZZ$         ');TextColor(Green);writeln('                          +D   :  II:$~  ');TextColor(White);
		write('         == IZ7787Z$I         ');TextColor(Green);writeln('                                $~ ::$=  ');TextColor(White);
		write('            7Z7787Z$I          ');TextColor(Green);writeln('                               O~ ::$~ ');TextColor(White);
		write('            IZ7787Z+           ');TextColor(Green);writeln('                              77, ::$~ ');TextColor(White);
		write('            $ZZZZZD7           ');TextColor(Green);writeln('                              88$7888+  ');TextColor(White);
		write('            ZIIIIZDI           ');TextColor(Green);writeln('                             ZZZZZZ88?   ');TextColor(White);
		write('            ZZZZIZD7    M      ');TextColor(Green);writeln('                           7Z888   OZOO  ');TextColor(White);
		write('           ZZZZ8II8DD  88M     ');TextColor(Green);writeln('                         =ZZ8       $O88 ');TextColor(White);
		write('          $$ZD   Z7778        ');TextColor(Green);writeln('                         I$88         ?Z88 ');TextColor(White);
		write('          $$      $Z$         ');TextColor(Green);writeln('                         7ZD            Z8 ');TextColor(White);
		write('         $                     ');TextColor(Green);writeln('                        OOO            :Z ');TextColor(White);
		write('       ,$                      ');TextColor(Green);writeln('                        7ZO             8 ');TextColor(White);
		write('      OZ   ????????????        ');TextColor(Green);writeln('                        OI  ?????????????$');TextColor(White);
		write('          ??????????+          ');TextColor(Green);writeln('                            ??????????????');TextColor(White);

		Delay (Velocidad);
		ClrScr;

		write('           ODDDDZ                       ');TextColor(Green);writeln('                                 O');TextColor(White);
		write('           =::~OD,             ');TextColor(Green);writeln('                                         ');TextColor(White);
		write('           +:~~8D~             ');TextColor(Green);writeln('                               ZZZOOO   ');TextColor(White);
		write('           $:Z~~D            ');TextColor(Green);writeln('                                 $=??$ZO  ');TextColor(White);
		write('           +::~~=             ');TextColor(Green);writeln('                                8=8?$ZO  ');TextColor(White);
		write('            =7Z~=            ');TextColor(Green);writeln('                                 78O?$ZO  ');TextColor(White);
		write('             $$$$             ');TextColor(Green);writeln('                     ?O,        I??7OOO  ');TextColor(White);
		write('           ,7I?IZ$$$7,        ');TextColor(Green);writeln('                      +Z7I$77O:::II$ZO$$ ');TextColor(White);
		write('           7Z?I8?7ZZIZ        ');TextColor(Green);writeln('                             ??77Z$87II:I');TextColor(White);
		write('           7Z?I87Z=~ZI        ');TextColor(Green);writeln('                             Z$  =  ?I::I');TextColor(White);
		write('           7Z?787Z=~~=        ');TextColor(Green);writeln('                                 O:   ::Z');TextColor(White);
		write('          I7Z?787Z=~+=        ');TextColor(Green);writeln('                                  $=  ::Z');TextColor(White);
		write('        =  7Z7787Z?+=         ');TextColor(Green);writeln('                                  DI  ::Z');TextColor(White);
		write('           7Z7787Z,            ');TextColor(Green);writeln('                                OI   ::Z');TextColor(White);
		write('           $Z$$ZZD,            ');TextColor(Green);writeln('                                88777888');TextColor(White);
		write('           ZIIIZZD+            ');TextColor(Green);writeln('                               7Z88888Z8');TextColor(White);
		write('           ZZIIZD=             ');TextColor(Green);writeln('                               7Z8    Z8');TextColor(White);
		write('            8ZIZZ88O M         ');TextColor(Green);writeln('                             7Z8     Z8');TextColor(White);
		write('            88ZZ88=   M         ');TextColor(Green);writeln('                            788     Z8');TextColor(White);
		write('            DD~~~               ');TextColor(Green);writeln('                            ZO      Z');TextColor(White);
		write('             D                  ');TextColor(Green);writeln('                            88      O');TextColor(White);
		write('             D                  ');TextColor(Green);writeln('                            $O           ');TextColor(White);
		write('      +????MMM????????????      ');TextColor(Green);writeln('                        ????8????????????');TextColor(White);
		write('           +???????+            ');TextColor(Green);writeln('                            ????????????');TextColor(White);

		if i = 7 then
		begin

			conti := 0;
			k := 0;

			repeat

				conti := conti +1;

				Delay (Velocidad - k);
				ClrScr;
				k := k + 20;

				if conti <= 1 then begin writeln('            O888DO');TextColor(White); end;
				if conti <= 2 then begin write('            +::~OD~');TextColor(Green);writeln('                                         ZOZO8');TextColor(White); end;
				if conti <= 3 then begin write('            $:O~DD');TextColor(Green);writeln('                                          Z?8$O8');TextColor(White); end;
				if conti <= 4 then begin write('            +::~~+');TextColor(Green);writeln('                                          8=8?$8');TextColor(White); end;
				if conti <= 5 then begin write('            +:$$~+');TextColor(Green);writeln('                                          I?=?78');TextColor(White); end;
				if conti <= 6 then begin write('              7$77');TextColor(Green);writeln('                               ?Z         I??7O8');TextColor(White); end;
				if conti <= 7 then begin write('             7I?Z?Z');TextColor(Green);writeln('                               ?O7O$$8O:::77$8ZZ~');TextColor(White); end;
				if conti <= 8 then begin write('            7?IZ?7Z');TextColor(Green);writeln('                                       ~   ~~:::?');TextColor(White); end;
				if conti <= 9 then begin write('      =+=   7Z??77ZZZ');TextColor(Green);writeln('                                   $$$  ~  I::?');TextColor(White); end;
				if conti <= 10 then begin write('      =+=   IZ?7ZZZZZ');TextColor(Green);writeln('                                   88   :  II:$');TextColor(White); end;
				if conti <= 11 then begin write('         ++ 7Z7787ZII');TextColor(Green);writeln('                                         Z~ ::$');TextColor(White); end;
				if conti <= 12 then begin write('            7Z7787ZII');TextColor(Green);writeln('                                         O~ ::$');TextColor(White); end;
				if conti <= 13 then begin write('            7Z7787Z');TextColor(Green);writeln('                                          ZI  ::$');TextColor(White); end;
				if conti <= 14 then begin write('            ZZZZZZD~');TextColor(Green);writeln('                                         8877888~');TextColor(White); end;
				if conti <= 15 then begin write('            ZIIIIZD ');TextColor(Green);writeln('                                        ZZZZZZ88=');TextColor(White); end;
				if conti <= 16 then begin write('            ZZZZIZD~    M                    ');TextColor(Green);writeln('             7Z888   ZZ8O');TextColor(White); end;
				if conti <= 17 then begin write('           ZZZZ8IIDD8  88M              ');TextColor(Green);writeln('                ZZZ8       Z88O');TextColor(White); end;
				if conti <= 18 then begin write('          ZZZD   ZIIIO              ');TextColor(Green);writeln('                   I88O         ZZ88');TextColor(White); end;
				if conti <= 19 then begin write('          ZZ      $Z$                ');TextColor(Green);writeln('                  7D8            Z8');TextColor(White); end;
				if conti <= 20 then begin write('         7                        ');TextColor(Green);writeln('                     OOO            =Z');TextColor(White); end;
				if conti <= 21 then begin write('       $$                                   ');TextColor(Green);writeln('           78O             8');TextColor(White); end;
				if conti <= 22 then begin write('      8~   ????????????                    ');TextColor(Green);writeln('            O   ?????????????Z');TextColor(White); end;
				if conti <= 23 then begin write('          ???????????                        ');TextColor(Green);writeln('              ??????????????');TextColor(White); end;

				Delay (Velocidad - k);
				ClrScr;

				if conti <= 1 then begin writeln('          8DDDN8');TextColor(White); end;
				if conti <= 2 then begin write('          =::~OD             ');TextColor(Green);writeln('                                  $OOZOO');TextColor(White); end;
				if conti <= 3 then begin write('          $:Z:DN        ');TextColor(Green);writeln('                                   O   7==??Z8');TextColor(White); end;
				if conti <= 4 then begin write('          Z,$~~8                                     ');TextColor(Green);writeln('          8==O?Z8');TextColor(White); end;
				if conti <= 5 then begin write('          =::~:+           ');TextColor(Green);writeln('                                    ???=?78');TextColor(White); end;
				if conti <= 6 then begin write('           +I$~=                                        ');TextColor(Green);writeln('       ?+??7O8');TextColor(White); end;
				if conti <= 7 then begin write('            $$$7,            ');TextColor(Green);writeln('                       +IZ         I77Z8Z');TextColor(White); end;
				if conti <= 8 then begin write('          II?I$+???I7         ');TextColor(Green);writeln('                               ~    :::::I');TextColor(White); end;
				if conti <= 9 then begin write('          7Z?I8?77Z?Z         ');TextColor(Green);writeln('                              ?+$7Z$ZOII:I');TextColor(White); end;
				if conti <= 10 then begin write('          7Z?787ZZ~~+           ');TextColor(Green);writeln('                            D   ::  II,$');TextColor(White); end;
				if conti <= 11 then begin write('          7Z?78IZZ~~=               ');TextColor(Green);writeln('                            ZZ:  ::$');TextColor(White); end;
				if conti <= 12 then begin write('         ?7Z?7DIZZ:==        ');TextColor(Green);writeln('                                     $~ ::$');TextColor(White); end;
				if conti <= 13 then begin write('       +  IZ778IZZ==        ');TextColor(Green);writeln('                                     ,DI ::$');TextColor(White); end;
				if conti <= 14 then begin write('          IZII8IZZ         ');TextColor(Green);writeln('                                     OOI  ::Z');TextColor(White); end;
				if conti <= 15 then begin write('          OIIIIZDD          ');TextColor(Green);writeln('                                    I7I7ZZ8D');TextColor(White); end;
				if conti <= 16 then begin write('          OIIZZDDD          ');TextColor(Green);writeln('                                   I777O8DZ88');TextColor(White); end;
				if conti <= 17 then begin write('         $II$8DDD8         ');TextColor(Green);writeln('                                   IIO8O    Z8');TextColor(White); end;
				if conti <= 18 then begin write('         ZIZD DDDD         ');TextColor(Green);writeln('                                   7D,      O8');TextColor(White); end;
				if conti <= 19 then begin write('        ZI$8   8D8 ~DM       ');TextColor(Green);writeln('                                 Z8       Z8');TextColor(White); end;
				if conti <= 20 then begin write('       $Z      888DN M       ');TextColor(Green);writeln('                                 78        8');TextColor(White); end;
				if conti <= 21 then begin write('       Z        ODD         ');TextColor(Green);writeln('                                  8         Z');TextColor(White); end;
				if conti <= 22 then begin write('    88   +??????????+       ');TextColor(Green);writeln('                                   ?????????Z?');TextColor(White); end;
				if conti <= 23 then begin write('  MMMN??+??????????????          ');TextColor(Green);writeln('                        ??????+????????8??');TextColor(White); end;

				Delay (Velocidad - k);
				ClrScr;

				if conti <= 1 then begin write('           ODDDDO      ');TextColor(Green);writeln('                                                  O');TextColor(White); end;
				if conti <= 2 then begin writeln('           +::~OD');TextColor(White); end;
				if conti <= 3 then begin write('           +::~OD~     ');TextColor(Green);writeln('                                       ZZZO8O');TextColor(White); end;
				if conti <= 4 then begin write('           $:$~~D      ');TextColor(Green);writeln('                                       7=??$$O');TextColor(White); end;
				if conti <= 5 then begin write('           +::~~=      ');TextColor(Green);writeln('                                       8=8?$ZO');TextColor(White); end;
				if conti <= 6 then begin write('            =7$~+       ');TextColor(Green);writeln('                                      7OO?$ZO');TextColor(White); end;
				if conti <= 7 then begin write('             $$$$          ');TextColor(Green);writeln('                        ?O         I??7OOO');TextColor(White); end;
				if conti <= 8 then begin write('            7I?IZ7$$7      ');TextColor(Green);writeln('                         ?Z77Z$$O:::77$OO$$');TextColor(White); end;
				if conti <= 9 then begin write('           7Z?I8?7ZZIZ      ');TextColor(Green);writeln('                               ??77$$8II?:I');TextColor(White); end;
				if conti <= 10 then begin write('           7Z?I87Z~~ZI      ');TextColor(Green);writeln('                               Z$  ~  ??::I');TextColor(White); end;
				if conti <= 11 then begin write('           7Z?787Z~~~+      ');TextColor(Green);writeln('                                   O:   ::Z');TextColor(White); end;
				if conti <= 12 then begin write('          I7Z?787Z~~++      ');TextColor(Green);writeln('                                    Z=  ::Z');TextColor(White); end;
				if conti <= 13 then begin write('        =  7Z7787Z++=       ');TextColor(Green);writeln('                                    DI  ::Z');TextColor(White); end;
				if conti <= 14 then begin write('           7Z7787Z          ');TextColor(Green);writeln('                                   OI   ::Z');TextColor(White); end;
				if conti <= 15 then begin write('           ZZ$ZZZD          ');TextColor(Green);writeln('                                   88777888');TextColor(White); end;
				if conti <= 16 then begin write('           ZIIIZZD~         ');TextColor(Green);writeln('                                  7Z88888Z8');TextColor(White); end;
				if conti <= 17 then begin write('           ZZIIZD~          ');TextColor(Green);writeln('                                  7Z8    Z8');TextColor(White); end;
				if conti <= 18 then begin write('            8ZIZZ88O M      ');TextColor(Green);writeln('                                7Z8     Z8');TextColor(White); end;
				if conti <= 19 then begin write('            88ZZ88~   M      ');TextColor(Green);writeln('                               788     Z8');TextColor(White); end;
				if conti <= 20 then begin write('            DD~~~              ');TextColor(Green);writeln('                             ZO      Z');TextColor(White); end;
				if conti <= 21 then begin write('             D                  ');TextColor(Green);writeln('                            88      O');TextColor(White); end;
				if conti <= 22 then begin write('             D                 ');TextColor(Green);writeln('                             $O');TextColor(White); end;
				if conti <= 23 then begin write('      ?????MMM????????????         ');TextColor(Green);writeln('                     ????8????????????');TextColor(White); end;
				if conti <= 24 then begin write('           ?????????               ');TextColor(Green);writeln('                         ????????????');TextColor(White); end;

				Delay (Velocidad - k);
				ClrScr;

				if conti <= 1 then begin write('          ZOOOO      ');TextColor(Green);writeln('                                                     8');TextColor(White); end;
				if conti <= 2 then begin write('         +~::=OD     ');TextColor(Green);writeln('                                        $Z$ZO');TextColor(White); end;
				if conti <= 3 then begin write('         =:::~OD     ');TextColor(Green);writeln('                                        Z?8ZO8');TextColor(White); end;
				if conti <= 4 then begin write('         $~:$~8D     ');TextColor(Green);writeln('                                     ,  $=??$8');TextColor(White); end;
				if conti <= 5 then begin write('         +:::~~+     ');TextColor(Green);writeln('                                        ??=?78');TextColor(White); end;
				if conti <= 6 then begin write('         =::Z$~+       ');TextColor(Green);writeln('                                      788?Z8       8');TextColor(White); end;
				if conti <= 7 then begin write('     +=    ,$$$7         ');TextColor(Green);writeln('                         ?O          77$8Z');TextColor(White); end;
				if conti <= 8 then begin write('     +    ?II?Z?ZZ      ');TextColor(Green);writeln('                           +O7OZZ8=::::ZO8ZZ');TextColor(White); end;
				if conti <= 9 then begin write('     +   I$ZZZ77ZZ?     ');TextColor(Green);writeln('                                 +++II7$O??:I');TextColor(White); end;
				if conti <= 10 then begin write('     ++++=$Z??77Z~I      ');TextColor(Green);writeln('                                $Z$  ~  I::I');TextColor(White); end;
				if conti <= 11 then begin write('         IZOZZZZO~?      ');TextColor(Green);writeln('                                O:   ~  ?I:$');TextColor(White); end;
				if conti <= 12 then begin write('         IZZ?787Z        ');TextColor(Green);writeln('                                      $= ::$');TextColor(White); end;
				if conti <= 13 then begin write('         IZZII87Z       ');TextColor(Green);writeln('                                       O= ::$');TextColor(White); end;
				if conti <= 14 then begin write('         IZZ7I87Z        ');TextColor(Green);writeln('                                     OI  ::$');TextColor(White); end;
				if conti <= 15 then begin write('         $$ZZZ$$D         ');TextColor(Green);writeln('                                    8877888');TextColor(White); end;
				if conti <= 16 then begin write('       $Z$O888IZD         ');TextColor(Green);writeln('                                7Z8888888Z88,');TextColor(White); end;
				if conti <= 17 then begin write('      $ZZ8=  8IID          ');TextColor(Green);writeln('                              7ZZ8      OZ8,');TextColor(White); end;
				if conti <= 18 then begin write('    $Z$     $IID~          ');TextColor(Green);writeln('                            788Z        Z8,');TextColor(White); end;
				if conti <= 19 then begin write('      $        $ID         ');TextColor(Green);writeln('                             ZO,         Z88O');TextColor(White); end;
				if conti <= 20 then begin write('       8        ZD         ');TextColor(Green);writeln('                             88,          O8O');TextColor(White); end;
				if conti <= 21 then begin write('      M            D        ');TextColor(Green);writeln('                            8,            $$');TextColor(White); end;
				if conti <= 22 then begin write('                    D~      ');TextColor(Green);writeln('                            8             OO');TextColor(White); end;
				if conti <= 23 then begin write('    ??????????????MM?+,     ');TextColor(Green);writeln('                          +???????????????I?O??');TextColor(White); end;
				if conti <= 24 then begin write('         +??????????         ');TextColor(Green);writeln('                               ??????????????');TextColor(White); end;

				Delay (Velocidad - k);
				ClrScr;
				conti := conti + 1;

				if conti <= 1 then begin write('             OOO8                                                          8    ');TextColor(White); end;
				if conti <= 2 then begin write('            O888D8         ');TextColor(Green);writeln('                                            ');TextColor(White); end;
				if conti <= 3 then begin write('            +::~OD~         ');TextColor(Green);writeln('                                ZO$O8      ');TextColor(White); end;
				if conti <= 4 then begin write('            Z:O~DD        ');TextColor(Green);writeln('                                  Z?8ZO8     ');TextColor(White); end;
				if conti <= 5 then begin write('            +::~~=        ');TextColor(Green);writeln('                                  8=8?$8    ');TextColor(White); end;
				if conti <= 6 then begin write('            +:Z$~=         ');TextColor(Green);writeln('                                 ??=?78    ');TextColor(White); end;
				if conti <= 7 then begin write('              7777         ');TextColor(Green);writeln('                      +Z         I??7O8    ');TextColor(White); end;
				if conti <= 8 then begin write('             77?Z?Z+       ');TextColor(Green);writeln('                       ?O$OZ$OO:::77$8Z$:   ');TextColor(White); end;
				if conti <= 9 then begin write('            I?7Z?7Z+         ');TextColor(Green);writeln('                             =,, ~~::,I:  ');TextColor(White); end;
				if conti <= 10 then begin write('      ===   7Z??77ZZZ        ');TextColor(Green);writeln('                           ~Z$  ~  I::I:  ');TextColor(White); end;
				if conti <= 11 then begin write('      ===   IO?7ZOZZ$         ');TextColor(Green);writeln('                          +D   :  II:$~  ');TextColor(White); end;
				if conti <= 12 then begin write('         == IZ7787Z$I         ');TextColor(Green);writeln('                                $~ ::$=  ');TextColor(White); end;
				if conti <= 13 then begin write('            7Z7787Z$I          ');TextColor(Green);writeln('                               O~ ::$~ ');TextColor(White); end;
				if conti <= 14 then begin write('            IZ7787Z+           ');TextColor(Green);writeln('                              77, ::$~ ');TextColor(White); end;
				if conti <= 15 then begin write('            $ZZZZZD7           ');TextColor(Green);writeln('                              88$7888+  ');TextColor(White); end;
				if conti <= 16 then begin write('            ZIIIIZDI           ');TextColor(Green);writeln('                             ZZZZZZ88?   ');TextColor(White); end;
				if conti <= 17 then begin write('            ZZZZIZD7    M      ');TextColor(Green);writeln('                           7Z888   OZOO  ');TextColor(White); end;
				if conti <= 18 then begin write('           ZZZZ8II8DD  88M     ');TextColor(Green);writeln('                         =ZZ8       $O88 ');TextColor(White); end;
				if conti <= 19 then begin write('          $$ZD   Z7778        ');TextColor(Green);writeln('                         I$88         ?Z88 ');TextColor(White); end;
				if conti <= 20 then begin write('          $$      $Z$         ');TextColor(Green);writeln('                         7ZD            Z8 ');TextColor(White); end;
				if conti <= 21 then begin write('         $                     ');TextColor(Green);writeln('                        OOO            :Z ');TextColor(White); end;
				if conti <= 22 then begin write('       ,$                      ');TextColor(Green);writeln('                        7ZO             8 ');TextColor(White); end;
				if conti <= 23 then begin write('      OZ   ????????????        ');TextColor(Green);writeln('                        OI  ?????????????$');TextColor(White); end;
				if conti <= 24 then begin write('          ??????????+          ');TextColor(Green);writeln('                            ??????????????');TextColor(White); end;

				Delay (Velocidad - k);
				ClrScr;

				if conti = 1 then begin write('           ODDDDZ                       ');TextColor(Green);writeln('                                 O');TextColor(White); end;
				if conti <=2 then begin write('           =::~OD,             ');TextColor(Green);writeln('                                         ');TextColor(White); end;
				if conti <=3 then begin write('           +:~~8D~             ');TextColor(Green);writeln('                               ZZZOOO   ');TextColor(White); end;
				if conti <=4 then begin write('           $:Z~~D            ');TextColor(Green);writeln('                                 $=??$ZO  ');TextColor(White); end;
				if conti <=5 then begin write('           +::~~=             ');TextColor(Green);writeln('                                8=8?$ZO  ');TextColor(White); end;
				if conti <=6 then begin write('            =7Z~=            ');TextColor(Green);writeln('                                 78O?$ZO  ');TextColor(White); end;
				if conti <=7 then begin write('             $$$$             ');TextColor(Green);writeln('                     ?O,        I??7OOO  ');TextColor(White); end;
				if conti <=8 then begin write('           ,7I?IZ$$$7,        ');TextColor(Green);writeln('                      +Z7I$77O:::II$ZO$$ ');TextColor(White); end;
				if conti <=9 then begin write('           7Z?I8?7ZZIZ        ');TextColor(Green);writeln('                             ??77Z$87II:I');TextColor(White); end;
				if conti <=10 then begin write('           7Z?I87Z=~ZI        ');TextColor(Green);writeln('                             Z$  =  ?I::I');TextColor(White); end;
				if conti <=11 then begin write('           7Z?787Z=~~=        ');TextColor(Green);writeln('                                 O:   ::Z');TextColor(White); end;
				if conti <=12 then begin write('          I7Z?787Z=~+=        ');TextColor(Green);writeln('                                  $=  ::Z');TextColor(White); end;
				if conti <=13 then begin write('        =  7Z7787Z?+=         ');TextColor(Green);writeln('                                  DI  ::Z');TextColor(White); end;
				if conti <=14 then begin write('           7Z7787Z,            ');TextColor(Green);writeln('                                OI   ::Z');TextColor(White); end;
				if conti <=15 then begin write('           $Z$$ZZD,            ');TextColor(Green);writeln('                                88777888');TextColor(White); end;
				if conti <=16 then begin write('           ZIIIZZD+            ');TextColor(Green);writeln('                               7Z88888Z8');TextColor(White); end;
				if conti <=17 then begin write('           ZZIIZD=             ');TextColor(Green);writeln('                               7Z8    Z8');TextColor(White); end;
				if conti <=18 then begin write('            8ZIZZ88O M         ');TextColor(Green);writeln('                             7Z8     Z8');TextColor(White); end;
				if conti <=19 then begin write('            88ZZ88=   M         ');TextColor(Green);writeln('                            788     Z8');TextColor(White); end;
				if conti <=20 then begin write('            DD~~~               ');TextColor(Green);writeln('                            ZO      Z');TextColor(White); end;
				if conti <=21 then begin write('             D                  ');TextColor(Green);writeln('                            88      O');TextColor(White); end;
				if conti <=22 then begin write('             D                  ');TextColor(Green);writeln('                            $O           ');TextColor(White); end;
				if conti <=23 then begin write('      +????MMM????????????      ');TextColor(Green);writeln('                        ????8????????????');TextColor(White); end;
				if conti <=24 then begin write('           +???????+            ');TextColor(Green);writeln('                            ????????????');TextColor(White); end;

			until conti > 24 ;

			TextColor(Red);

			conti := 0;

			repeat

				conti := conti + 1;

				writeln('   ___           ___           ___           ___                       ___');
				writeln('  /\  \         /\  \         /\__\         /\  \          ___        /\  \');
				writeln('  \:\  \       /::\  \       /::|  |       /::\  \        /\  \      /::\  \');
				writeln('   \:\  \     /:/\:\  \     /:|:|  |      /:/\:\  \       \:\  \    /:/\:\  \');
				writeln('    \:\  \   /:/  \:\  \   /:/|:|__|__   /::\~\:\__\      /::\__\  /::\~\:\  \');
				writeln('_____\:\__\ /:/__/ \:\__\ /:/ |::::\__\ /:/\:\ \:|__|  __/:/\/__/ /:/\:\ \:\__\');
				writeln(':::::::/__/ \:\  \ /:/  / \/__/~~/:/  / \:\~\:\/:/  / /\/:/  /    \:\~\:\ \/__/');
				writeln(':\~~\~~      \:\  /:/  /        /:/  /   \:\ \::/  /  \::/__/      \:\ \:\__\');
				writeln('\:\  \        \:\/:/  /        /:/  /     \:\/:/  /    \:\__\       \:\ \/__/');
				writeln(' \:\__\        \::/  /        /:/  /       \::/__/      \/__/        \:\__\');
				writeln('  \/__/         \/__/         \/__/         ~~                        \/__/');
				writeln('                 ___           ___           ___           ___     ');
				writeln('                /\__\         /\  \         /\  \         /\  \    ');
				writeln('               /:/ _/_       /::\  \       /::\  \       /::\  \   ');
				writeln('              /:/ /\__\     /:/\:\  \     /:/\:\  \     /:/\ \  \  ');
				writeln('             /:/ /:/ _/_   /::\~\:\  \   /::\~\:\  \   _\:\~\ \  \ ');
				writeln('            /:/_/:/ /\__\ /:/\:\ \:\__\ /:/\:\ \:\__\ /\ \:\ \ \__\');
				writeln('            \:\/:/ /:/  / \/__\:\/:/  / \/_|::\/:/  / \:\ \:\ \/__/');
				writeln('             \::/_/:/  /       \::/  /     |:|::/  /   \:\ \:\__\  ');
				writeln('              \:\/:/  /        /:/  /      |:|\/__/     \:\/:/  /  ');
				writeln('               \::/  /        /:/  /       |:|  |        \::/  /   ');
				writeln('                \/__/         \/__/         \|__|         \/__/    ');

				Delay(1000);

				if conti <> 5 then
					ClrScr;

				Delay(900);

			until conti = 5;

			TextColor(White);
			writeln;

			write('                                   PRESS START ');

			readkey;

			TextColor(White);

		end;

	end;

end.
