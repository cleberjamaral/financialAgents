{ include("common.asl") }

!start.

+!start <-
	!setDefaultParams;
	?chatIdTelegram(C); 
    startCamel(C);
	-+updatemenu;
	-+introduceyourself.

+stopsystem <-
	.drop_all_intentions;
	.print("Stopping system... a new launch must be done manually!");
    sendString("Stopping system... a new launch must be done manually!");
    .broadcast(achieve, stop);
    !!stop.	 

// default beliefs are set here because of use of bb persistence
+!setDefaultParams <-
	.abolish(chatIdTelegram(_));
	.abolish(menu(_));
	-+chatIdTelegram("-274694619");
	-+menu(["IntroduceYourself","StopSystem","UpdateMenu"]).

+introduceyourself : menu(LDP) <-
	.concat("Hi! I am your analyst. You can ask: ",LDP,BB);
	sendString(BB).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
