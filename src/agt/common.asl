
+updatemenu : menu(LDP) <-
    clearMenu;
    for (.member(Item,LDP)) {
		addMenuOption(Item);
	}.

+invalidoption <-
    sendString("Unsupported operation!").

+!stop <-
	.stopMAS. //TODO: stop mas is not working

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
