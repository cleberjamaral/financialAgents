
+updatemenu : menu(LDP) <-
    clearMenu;
    for (.member(Item,LDP)) {
		addMenuOption(Item);
	}.

+invalidoption <-
    sendString("Unsupported operation!").

+!stop <-
	.print("Stopping MAS in 3 seconds");
	.wait(1000);
	.print("Stopping MAS in 2 seconds");
	.wait(1000);
	.print("Stopping MAS in 1 seconds");
	.wait(1000);
	.stopMAS. //TODO: stop mas is not working

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
