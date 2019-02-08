!joinFinancialGroup.

+!opinion(S) <-
	.send(bazin,achieve,opinion(S));
	.send(grahan,achieve,opinion(S));
	.send(greenblatt,achieve,opinion(S));
	.wait(2000);
	!reply(S);
	.

+!reply(S) : 
	recommend(X1,Y1,Z1)[source(bazin)] & recommend(X2,Y2,Z2)[source(grahan)] & 
	recommend(X3,Y3,Z3)[source(greenblatt)] & .count(recommend(S,comprar,_),N) & N >= 2 
	<-
	.concat(Z1,"\n\n",Z2,"\n\n",Z3,"\n\nResumo: COMPRAR", CCC);
	.send(toTelegram,tell,CCC);
	.

+!reply(S) : 
	recommend(X1,Y1,Z1)[source(bazin)] & recommend(X2,Y2,Z2)[source(grahan)] & 
	recommend(X3,Y3,Z3)[source(greenblatt)] 
	<-
	.concat(Z1,"\n\n",Z2,"\n\n",Z3,"\n\nResumo: NAO COMPRAR", CCC);
	.send(toTelegram,tell,CCC);
	.
	
+!joinFinancialGroup <-
	joinWorkspace(financialagents,Ofa);
	.print("DEBUG: Joining group...");
	g::lookupArtifact(financial_team, GrArtId);
	g::focus(GrArtId);
	g::adoptRole(assistant);
	.


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
//{ include("$jacamoJar/templates/org-obedient.asl") }
