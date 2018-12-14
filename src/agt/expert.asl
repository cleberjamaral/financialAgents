{ include("common.asl") }

insert_commas([],[]).
insert_commas([H|T],[H,", "|TC]) :- insert_commas(T,TC).

!start.

//TODO: ao executar aparece no console: [ca] as2j: parsing error:[null:5] ArithExpr: first operand 'ca' is not numeric or variable. [bot1] as2j: parsing error:[null:7] ArithExpr: first operand 'bot1' is not numeric or variable. [bot2] as2j: parsing error:[null:7] ArithExpr: first operand 'bot2' is not numeric or variable. [bot3] as2j: parsing error:[null:7] ArithExpr: first operand 'bot3' is not numeric or variable.

// First run
+!start : not alreadyRunning <-
	+alreadyRunning;
	+stock::threshold(0);
	+stock::expertise(none);
	!setDefaultParams;
	!createtelegramartifact;
	!createstockartifact;
	sendString("First execution!");
	!updatemenu;
	-+introduceyourself.

+!start : .my_name(N) <-
	!setDefaultParams; 
	!createtelegramartifact;
	!createstockartifact;
	!updatemenu;
	-+introduceyourself;
	!!updateQuotationLoop.
	
// default beliefs are set here because of use of bb persistence
+!setDefaultParams <-
	-+telegram::chatIdTelegram("-274694619");
	-+telegram::expertMenu(["IntroduceYourself","Quotation","SetExpertise","SetThreshold"]).
	
+!updatemenu : telegram::expertMenu(LDP) <-
	clearMenu;
	for (.member(Item,LDP)) {
		addMenuOption(Item);
	}.	

+quotation : stock::expertise(E) & stock::threshold(T) <- 
	!updateQuotation;
	.wait(500);
	?stock::lastquotation(P);
	?stock::datequotation(D);
	?stock::sourcequotation(S);
	.concat("Last quotation of ",E," is $", P, ", threshold is $", T, " (", D," by ", S, ")", CC);
	sendString(CC).

+setthreshold(T) : stock::expertise(E) & .concat("The threshold price for ",E ," is $", T, CC) <- 
	-+stock::threshold(T);
	sendString("15").

+setexpertise(E) : .concat("My expertise is in ", E, CC)<- 
	-+stock::expertise(E);
	sendString(CC);
	!updateQuotationLoop.

+setlastquotation(P) <- -+stock::lastquotation(P).

+setdatequotation(D) <- -+stock::datequotation(D).

+setsourcequotation(S) <- -+stock::sourcequotation(S).

+!createtelegramartifact : .my_name(N) & telegram::chatIdTelegram(C) & .concat("telegram",N,CC) <- 
	makeArtifact(CC,"dynamic.telegram.BotArtifact",[],Aid);
	focus(Aid);
	startCamel(C).

+!createstockartifact : .my_name(N) <- 
	.concat("stock",N,CC);
	makeArtifact(CC,"dynamic.stock.StockArtifact",[],Aid);
	focus(Aid).

+introduceyourself : stock::expertise(E) & telegram::expertMenu(LDP) & .concat("Hi! I can help you with ", E, ". You can ask: ",LDP,BB) <-
	sendString(BB).

+!updateQuotation : stock::expertise(E) <-
	getLastPrice(E).

+!updateQuotationLoop <-
	!!updateQuotation;
	.wait(5*60*1000); //Wait for five minutes
	!updateQuotationLoop.

+!saveYourself : .my_name(N) & .concat("/tmp/",N,".asl",CC) <-
	.save_agent(CC).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
//{ include("$jacamoJar/templates/org-obedient.asl") }
