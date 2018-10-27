chatIdTelegram("-274694619").
quotation(0).
expertice(none).

+!start <- 
    ?chatIdTelegram(C);
    //joinWorkspace("finantialmarket",Wid);
    -+myWorkspace(Wid);
    .my_name(N);
    .concat("telegram",N,CC);
    makeArtifact(CC,"telegram.BotArtifact",[],AId);//[wid(WId)];
    focus(AId);//[wid(WId)];
    startCamel(C);
    sendString("Hi! I am here!").
    
+giveexpertise <-
	.print("giveExpertise");
	?expertice(E);
	.concat("My expertise is in ", E, CC);
	sendString(CC).
	
+givequotation <- 
	.print("giveQuotation", I);
	?expertice(E);
	?quotation(C);
	.concat("The current quotation of ",E," is $ ", C, CC);
	sendString(CC).

+setexpertice(E) <- 
	.print(setExpertice, E);
	-+expertice(E);
	.concat("My expertise is in ", E, CC);
	sendString(CC).

+recreateartifact <- 
	.print("recreateartifact");
    //?myWorkspace(Wid);
	.my_name(N);
    .concat("telegram",N,CC);
    lookupArtifact(CC,Aid);//[wid(WId)];
    sendString("Artifact is being disposed...");
    //focus(AId);//[wid(WId)]; //TODO: focus 2x dá pau? Pq?
	disposeArtifact(Aid); //TODO: documentar melhor isso! no cartago se chama dispose apenas!!!
	.print("Artifact recreated!");
    makeArtifact(CC,"telegram.BotArtifact",[],NewAId);
    focusWhenAvailable(CC);//[wid(WId)];
    //focus(NewAId);
    ?chatIdTelegram(C);
    startCamel(C);
    sendString("Artifact recreated!").


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
