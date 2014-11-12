PROGRAM Zombie;

USES 

	crt,Introduccion;
	
//VAR

	//i : integer;
	
PROCEDURE IntroZ;
	var
	
		contIntro : Integer;

	begin
		
		contIntro := 0;
		
		repeat
	
			contIntro := contIntro + 1;
			
			Intro(1);Intro(2);Intro(3);Intro(4);Intro(5);Intro(6);{Intro(5);Intro(4);Intro(3);Intro(2);Intro(1);}
	
		until contIntro = 3;
	
		Intro(7)
		
	end;
	
BEGIN

	IntroZ;

END.
