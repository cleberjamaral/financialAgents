{ include("common.asl") }

!start.

+!start <-
	!setDefaultParams;
	?chatIdTelegram(C); 
    startCamel(C);
	-+updatemenu;
	-+introduceyourself.

+!stopsystem <-
    sendString("Stopping system... a new launch must be done manually!");
    .wait(2000);
    .broadcast(achieve, stop).	 

// default beliefs are set here because of use of bb persistence
+!setDefaultParams <-
	-+chatIdTelegram("-274694619");
	-+menu(["IntroduceYourself","StopSystem","UpdateMenu"]).

+introduceyourself : menu(LDP) <-
	.concat("Hi! I am your analyst. You can ask: ",LDP,BB);
	sendString(BB).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
