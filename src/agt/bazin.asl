{ include("common.asl") }

!createFundamentusArtifact.

+!createFundamentusArtifact[source(self)] : .my_name(N) <- 
	.concat("fundamentals",N,CC);
	makeArtifact(CC,"dynamic.stock.FundamentusArtifact",[],Aid);
	focus(Aid).

/* * * * perceptions from stock artifact * * * */

+setDivYield(V) <- -+fundamentals::divYield(V).
+setDivBrutaPatr(V) <- -+fundamentals::divBrutaPatr(V).

/* * * * plans allowed to be performed by achieve command from telegram messages * * * */

+!saveYourself : .my_name(N) & .concat("/tmp/",N,".asl",CC) <-
	.save_agent(CC).

+!opinion(S)[source(Questioner)] <- 
	getFundamentals(S);
	.wait(1000);
	!reply(S);
	.

+!reply(S) : fundamentals::divYield(P) & fundamentals::divBrutaSobrePatrimonio(D) & P >= 6 & D < 1 <-
	.concat("Baseado no metodo de Bazin, ", S," tem Yield >=6% (",P,"%) e Div./ Patr <=1 (",D,"): COMPRAR", CCC)
	.send(toTelegram,tell,CCC);
	.

+!reply(S) : fundamentals::divYield(P) & fundamentals::divBrutaSobrePatrimonio(D) <-
	.concat("Baseado no metodo de Bazin, ", S," NAO cumpre os requisitos de Yield >=6% (",P,"%) e Div./ Patr <=1 (",D,"): NAO COMPRAR", CCC)
	.send(toTelegram,tell,CCC);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
