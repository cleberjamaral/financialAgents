{ include("fundamentalist.asl") }

/* * * * initial beliefs * * * */

/* * * * setup plans * * * */

/* * * * rules * * * */

recommend(S) :- fundamentals::ebit(S,E) & 
                fundamentals::valorMercado(S,V) & 
                fundamentals::dividaLiq(S,D) & 
                E/(V+D) >= 0.1 & 
                fundamentals::roic(S,R) & 
                R >= 0.1.

lessthanonehour(SS,MM,HH,SSS,MMM,HHH) :- ((SS+MM*60+HH*60*60) - (SSS+MMM*60+HHH*60*60)) < 30*60.

/* * * * perceptions from artifact * * * */

+setValorMercado(S,V)   : .time(HH,MM,SS) <- -+fundamentals::valorMercado(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setDivYield(S,V)       : .time(HH,MM,SS) <- -+fundamentals::divYield(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setLPA(S,V)            : .time(HH,MM,SS) <- -+fundamentals::lpa(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setVPA(S,V)            : .time(HH,MM,SS) <- -+fundamentals::vpa(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setDividaLiq(S,V)      : .time(HH,MM,SS) <- -+fundamentals::dividaLiq(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setEBIT(S,V)           : .time(HH,MM,SS) <- -+fundamentals::ebit(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setROIC(S,V)           : .time(HH,MM,SS) <- -+fundamentals::roic(S,V)[date(DD,OO,YY),time(HH,MM,SS)].

/* * * * plans * * * */

// get cached Fundamentals if the earlier data is younger than 5 minutes 
+!opinion(S)[source(Q)] 
    :
    .date(YY,OO,DD) & .time(HH,MM,SS) & 
    fundamentals::valorMercado(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::divYield(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::lpa(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::vpa(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::dividaLiq(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::ebit(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::roic(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH)
    <- 
    .print("Getting cached fundamentals from ",S); 
    !reply(S,Q);
    .

// get Fundamentals again
+!opinion(S)[source(Q)] 
    : 
    .date(YY,OO,DD) 
    <- 
    .print("Getting fundamentals from ",S); 
    getFundamentals(S);
    -+lastDate(YY,OO,DD);
    !reply(S,Q);
    .

+!reply(S,Q)[source(self)] 
    : 
    recommend(S) 
    <-
    .concat("Baseado no metodo de Greenblatt, ", S," tem EBIT (",math.round(E/1000000),"mi) sobre valor de mercado + divida liquida (",math.round(V/1000000),"mi+",math.round(D/1000000),"mi) e ROIC (",R,"%) superiores a 10%: COMPRAR", CCC)
    .send(Q,tell,stocks::recommend(S,comprar,CCC));
    .

+!reply(S,Q)[source(self)] 
    : 
    fundamentals::ebit(S,E) & 
    fundamentals::valorMercado(S,V) & 
    fundamentals::dividaLiq(S,D) & 
    fundamentals::roic(S,R) 
    <-
    .concat("Baseado no metodo de Greenblatt, ", S," NAO cumpre os requisitos de EBIT (",math.round(E/1000000),"mi) sobre valor de mercado + divida liquida (",math.round(V/1000000),"mi+",math.round(D/1000000),"mi) e ROIC (",R,"%) superiores a 10%: NAO COMPRAR", CCC)
    .send(Q,tell,stocks::recommend(S,neutro,CCC));
    .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
			
			
