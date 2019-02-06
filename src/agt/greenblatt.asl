{ include("common.asl") }

!createFundamentusArtifact.

+!createFundamentusArtifact[source(self)] : .my_name(N) <- 
	.concat("fundamentals",N,CC);
	makeArtifact(CC,"dynamic.stock.FundamentusArtifact",[],Aid);
	focus(Aid).

/* * * * perceptions from stock artifact * * * */

+setValorMercado(V) <- -+fundamentals::valorMercado(V).
+setDivYield(V) <- -+fundamentals::divYield(V).
+setLPA(V) <- -+fundamentals::lpa(V).
+setVPA(V) <- -+fundamentals::vpa(V).
+setDividaLiq(V) <- -+fundamentals::dividaLiq(V).
+setEBIT(V) <- -+fundamentals::ebit(V).
+setROIC(V) <- -+fundamentals::roic(V).

/* * * * plans allowed to be performed by achieve command from telegram messages * * * */

+!saveYourself : .my_name(N) & .concat("/tmp/",N,".asl",CC) <-
	.save_agent(CC).

+!opinion(S)[source(Questioner)] <- 
	getFundamentals(S);
	.wait(1000);
	!reply(S);
	.

+!reply(S) : 
	fundamentals::ebit(E) & fundamentals::valorMercado(V) & fundamentals::dividaLiq(D) & E/(V+D) >= 0.1 & 
	fundamentals::roic(R) & R >= 0.1
	<-
	.concat("Baseado no metodo de Greenblatt, ", S," tem EBIT (",E,") sobre valor de mercado + divida liquida (",V,"+",D,") e ROIC (",R,") superiores a 10%: COMPRAR", CCC)
	.send(toTelegram,tell,CCC);
	.

+!reply(S) : fundamentals::ebit(E) & fundamentals::valorMercado(V) & fundamentals::dividaLiq(D) & fundamentals::roic(R) <-
	.concat("Baseado no metodo de Greenblatt, ", S," NAO tem EBIT (",E,") sobre valor de mercado + divida liquida (",V,"+",D,") e ROIC (",R,") superiores a 10%: NAO COMPRAR", CCC)
	.send(toTelegram,tell,CCC);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
