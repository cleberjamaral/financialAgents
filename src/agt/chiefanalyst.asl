{ include("common.asl") }

!start.

+!start <-
	!setDefaultParams;
	!createtelegramartifact;
	?telegram::chatIdTelegram(C);
	-+updatemenu;
	-+introduceyourself.

+!createtelegramartifact : .my_name(N) & telegram::chatIdTelegram(C) & .concat("telegram",N,CC) <- 
	makeArtifact(CC,"dynamic.telegram.BotArtifact",[],Aid);
	focus(Aid);
	startCamel(C).

+stopsystem <-
	-stopsystem;
	.print("Stopping system... a new launch must be done manually!");
    sendString("Stopping system... a new launch must be done manually!");
	.wait(1000);
	//.stopMAS;
	.

// default beliefs are set here because of use of bb persistence
+!setDefaultParams <-
	-+telegram::chatIdTelegram("-274694619");
	-+telegram::chiefAnalystMenu(["IntroduceYourself","StopSystem","UpdateMenu"]).

+updatemenu : telegram::chiefAnalystMenu(LDP) <-
    clearMenu;
    for (.member(Item,LDP)) {
		addMenuOption(Item);
	}.
	
+introduceyourself : telegram::chiefAnalystMenu(LDP) <-
	.concat("Hi! I am your analyst. You can ask: ",LDP,BB);
	sendString(BB).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
//{ include("$jacamoJar/templates/org-obedient.asl") }
