{ include("fundamentalist.asl") }

/* * * * initial beliefs * * * */

/* * * * setup plans * * * */

/* * * * rules * * * */
recommend(S) :- fundamentals::divYield(S,P) & 
                fundamentals::divBrutaPatr(S,D) & 
                P >= 6 & 
                D < 1.
                
lessthanonehour(SS,MM,HH,SSS,MMM,HHH) :- ((SS+MM*60+HH*60*60) - (SSS+MMM*60+HHH*60*60)) < 30*60.

/* * * * perceptions from artifact * * * */

+setDivYield(S,V)       : .time(HH,MM,SS) & .date(YY,OO,DD) <- -+fundamentals::divYield(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setDivBrutaPatr(S,V)   : .time(HH,MM,SS) & .date(YY,OO,DD) <- -+fundamentals::divBrutaPatr(S,V)[date(DD,OO,YY),time(HH,MM,SS)].

/* * * * plans * * * */

// get cached Fundamentals if the earlier data is younger than 5 minutes 
+!opinion(S)[source(Q)] 
    : 
    .date(YY,OO,DD) & .time(HH,MM,SS) & 
    fundamentals::divYield(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::divBrutaPatr(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH)
    <- 
    .print("Getting cached xsjbxsxbsj fundamentals from ",S); 
    !reply(S,Q);
    .

// get Fundamentals again
+!opinion(S)[source(Q)] : .date(YY,OO,DD) <- 
    .print("Getting fundamentals from ",S); 
    getFundamentals(S);
    -+lastDate(YY,OO,DD);
    !reply(S,Q);
    .

+!reply(S,Q)[source(self)] : recommend(S) <- //fundamentals::divYield(S,P) & fundamentals::divBrutaPatr(S,D) & P >= 6 & D < 1 <-
    .concat("Baseado no metodo de Bazin, ", S," tem Yield >=6% (",P,"%) e Div./ Patr <=1 (",D,"): COMPRAR", CCC)
    .send(Q,tell,stocks::recommend(S,comprar,CCC));
    .

+!reply(S,Q)[source(self)] : fundamentals::divYield(S,P) & fundamentals::divBrutaPatr(S,D) <-
    .concat("Baseado no metodo de Bazin, ", S," NAO cumpre os requisitos de Yield >=6% (",P,"%) e Div./ Patr <=1 (",D,"): NAO COMPRAR", CCC)
    .send(Q,tell,stocks::recommend(S,neutro,CCC));
    .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
			
			
			
			
			
			
			
			
