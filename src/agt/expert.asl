{ include("common.asl") }

insert_commas([],[]).
insert_commas([H|T],[H,", "|TC]) :- insert_commas(T,TC).

!start.

//TODO: permitir escolher uma primeira porta para o mindinspectorweb (ex 8080), se nao der dai vai da 3272 em diante
//TODO: tem como mandar comando pro mas via java.util.logging.ConsoleHandler? como finalizar gentilmente?
//TODO: sistema esta aumentando o uso de processador!!!
//TODO: no jacamo o start nao pode ficar no jcm pois ele da start antes de subir os beliefs do arquivo
//TODO: ao executar aparece no console: [ca] as2j: parsing error:[null:5] ArithExpr: first operand 'ca' is not numeric or variable. [bot1] as2j: parsing error:[null:7] ArithExpr: first operand 'bot1' is not numeric or variable. [bot2] as2j: parsing error:[null:7] ArithExpr: first operand 'bot2' is not numeric or variable. [bot3] as2j: parsing error:[null:7] ArithExpr: first operand 'bot3' is not numeric or variable.

// First run
+!start : not expertise(_) <-
	+lastquotation(0);
	+threshold(0);
	+expertise(none);
	!setDefaultParams;
	!createtelegramartifact;
	!createstockartifact;
	sendString("First execution!");
	-+updatemenu;
	-+introduceyourself.

+!start : .my_name(N) & expertise(E) <-
	!setDefaultParams; 
    !createtelegramartifact;
	!createstockartifact;
	-+updatemenu;
	-+introduceyourself;
	.abolish(lastquotation(_));
	.abolish(datequotation(_));
	.abolish(sourcequotation(_));
	getLastPrice(E).
	
// default beliefs are set here because of use of bb persistence
+!setDefaultParams <-
	-+chatIdTelegram("-274694619");
	-+menu(["IntroduceYourself","Quotation","SetExpertise","SetThreshold","RecreateArtifact","UpdateMenu"]).
	
+quotation : expertise(E) & threshold(T) <- 
	.abolish(lastquotation(_));
	.abolish(datequotation(_));
	.abolish(sourcequotation(_));
	getLastPrice(E);
	.wait(500);
	?lastquotation(P);
	?datequotation(D);
	?sourcequotation(S);
	.concat("Last quotation of ",E," is $", P, ", threshold is $", T, " (", D," by ", S, ")", CC);
	sendString(CC).

+setthreshold(T) : expertise(E)<- 
	.print(setthreshold, T);
	.abolish(threshold(_));
	+threshold(T);
	.concat("The threshold price for ",E ," is $", T, CC);
	sendString(CC).

+setexpertise(E) <- 
	.print(setExpertise, E);
	.abolish(expertise(_));
	+expertise(E);
	.concat("My expertise is in ", E, CC);
	sendString(CC).

+!createtelegramartifact : .my_name(N) & chatIdTelegram(C) <- 
    .concat("telegram",N,CC);
    makeArtifact(CC,"telegram.BotArtifact",[],AId);
    focusWhenAvailable(CC);//[wid(WId)];
    startCamel(C).

+!createstockartifact : .my_name(N) <- 
    .concat("stock",N,CC);
    makeArtifact(CC,"stock.StockArtifact",[],AId);
    focusWhenAvailable(CC).

+recreateartifact : .my_name(N) & chatIdTelegram(C) <- 
	.print("recreateartifact");
    //?myWorkspace(Wid);
    //joinWorkspace("finantialmarket",Wid);
    //-+myWorkspace(Wid);
    .concat("telegram",N,CC);
    lookupArtifact(CC,Aid);//[wid(WId)];
    sendString("Artifact is being disposed...");
    //focus(AId);//[wid(WId)]; //TODO: focus 2x dá pau? Pq?
	disposeArtifact(Aid); //TODO: documentar melhor isso! no cartago se chama dispose apenas!!!
	!createtelegramartifact;
    sendString("Artifact recreated!").

+introduceyourself : expertise(E) & menu(LDP) <-
	.concat("Hi! I can help you with ", E, ". You can ask: ",AA);
	.concat(AA,LDP,BB);
	sendString(BB).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
