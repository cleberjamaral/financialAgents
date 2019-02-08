{ include("fundamentalist.asl") }

/* * * * initial beliefs * * * */

/* * * * setup plans * * * */

/* * * * perceptions from artifact * * * */

+setValorMercado(V) <- -+fundamentals::valorMercado(V).
+setDivYield(V) <- -+fundamentals::divYield(V).
+setLPA(V) <- -+fundamentals::lpa(V).
+setVPA(V) <- -+fundamentals::vpa(V).
+setDividaLiq(V) <- -+fundamentals::dividaLiq(V).
+setEBIT(V) <- -+fundamentals::ebit(V).
+setROIC(V) <- -+fundamentals::roic(V).

/* * * * plans * * * */

+!reply(S,Q)[source(self)] : 
	fundamentals::ebit(E) & fundamentals::valorMercado(V) & fundamentals::dividaLiq(D) & E/(V+D) >= 0.1 & 
	fundamentals::roic(R) & R >= 0.1
	<-
	.concat("Baseado no metodo de Greenblatt, ", S," tem EBIT (",E,") sobre valor de mercado + divida liquida (",V,"+",D,") e ROIC (",R,"%) superiores a 10%: COMPRAR", CCC)
	.send(Q,tell,recommend(S,comprar,CCC));
	.

+!reply(S,Q)[source(self)] : fundamentals::ebit(E) & fundamentals::valorMercado(V) & fundamentals::dividaLiq(D) & fundamentals::roic(R) <-
	.concat("Baseado no metodo de Greenblatt, ", S," NAO tem EBIT (",E,") sobre valor de mercado + divida liquida (",V,"+",D,") e ROIC (",R,"%) superiores a 10%: NAO COMPRAR", CCC)
	.send(Q,tell,recommend(S,neutro,CCC));
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }