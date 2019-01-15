{ include("common.asl") }

insert_commas([],[]).
insert_commas([H|T],[H,", "|TC]) :- insert_commas(T,TC).

!start.

// First run
+!start[source(self)] : not alreadyRunning <-
	+alreadyRunning;
	+stock::threshold(0);
	+stock::expertise(none);
	!createstockartifact;
	!introduceyourself.

+!start[source(self)] : .my_name(N) <-
	!createstockartifact;
	!introduceyourself;
	!!updateQuotationLoop.

+!createstockartifact[source(self)] : .my_name(N) <- 
	.concat("stock",N,CC);
	makeArtifact(CC,"dynamic.stock.StockArtifact",[],Aid);
	focus(Aid).

+!updateQuotation[source(self)] : stock::expertise(E) <-
	getLastPrice(E).

+!updateQuotationLoop[source(self)] <-
	!!updateQuotation;
	.wait(5*60*1000); //Wait for five minutes
	!updateQuotationLoop.

/* * * * perceptions from stock artifact * * * */

+setlastquotation(P) <- -+stock::lastquotation(P).

+setdatequotation(D) <- -+stock::datequotation(D).

+setsourcequotation(S) <- -+stock::sourcequotation(S).

/* * * * plans allowed to be performed by achieve command from telegram messages * * * */

+!saveYourself : .my_name(N) & .concat("/tmp/",N,".asl",CC) <-
	.save_agent(CC).

+!quotation : stock::expertise(E) & stock::threshold(T) <- 
	!updateQuotation;
	.wait(500);
	?stock::lastquotation(P);
	?stock::datequotation(D);
	?stock::sourcequotation(S);
	.concat("Last quotation of ",E," is $", P, ", threshold is $", T, " (", D," by ", S, ")", CC);
	.send(toTelegram,tell,CC).

+!setthreshold(T) : stock::expertise(E) & .concat("The threshold price for ",E ," is $", T, CC) <- 
	-+stock::threshold(T);
	.send(toTelegram,tell,CC).

+!setexpertise(E)[source(S)] : .concat("My expertise is in ", E, CC) <- 
	-+stock::expertise(E);
	.send(toTelegram,tell,CC);
	!updateQuotationLoop.

+!introduceyourself : stock::expertise(E) & .concat("Hi! I can help you with ", E, ". You can ask: Quotation, SetThreshold and SetExpertise",CC) <-
	.send(toTelegram,tell,CC).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
