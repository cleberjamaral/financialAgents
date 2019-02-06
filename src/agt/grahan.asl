{ include("common.asl") }

!createFundamentusArtifact.

+!createFundamentusArtifact[source(self)] : .my_name(N) <- 
	.concat("fundamentals",N,CC);
	makeArtifact(CC,"dynamic.stock.FundamentusArtifact",[],Aid);
	focus(Aid).

/* * * * perceptions from stock artifact * * * */

+setPreco(V) <- -+fundamentals::preco(V).
+setLPA(V) <- -+fundamentals::lpa(V).
+setVPA(V) <- -+fundamentals::vpa(V).

/* * * * plans allowed to be performed by achieve command from telegram messages * * * */

+!saveYourself : .my_name(N) & .concat("/tmp/",N,".asl",CC) <-
	.save_agent(CC).

+!opinion(S)[source(Questioner)] <- 
	getFundamentals(S);
	.wait(1000);
	!reply(S);
	.

+!reply(S) : fundamentals::preco(P) & fundamentals::lpa(L) & fundamentals::vpa(V) & P < math.sqrt(22.5 * L * V) <-
	.concat("Baseado no metodo de Grahan, ", S," tem Preco (",P,") menor que raiz quadrada de 22.5*",L,"*", V," (",math.sqrt(22.5 * L * V),"): COMPRAR", CCC)
	.send(toTelegram,tell,CCC);
	.

+!reply(S) : fundamentals::preco(P) & fundamentals::lpa(L) & fundamentals::vpa(V) <-
	.concat("Baseado no metodo de Grahan, ", S," NAO tem Preco (",P,") menor que raiz quadrada de 22.5*",L,"*", V," (",math.sqrt(22.5 * L * V),"): NAO COMPRAR", CCC)
	.send(toTelegram,tell,CCC);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
