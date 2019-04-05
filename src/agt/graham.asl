{ include("fundamentalist.asl") }

/* * * * initial beliefs * * * */

/* * * * setup plans * * * */

/* * * * rules * * * */

recommend(S) :- fundamentals::preco(S,P) & 
                fundamentals::lpa(S,L) & 
                fundamentals::vpa(S,V) & 
                P < math.sqrt(22.5 * L * V).

lessthanonehour(SS,MM,HH,SSS,MMM,HHH) :- ((SS+MM*60+HH*60*60) - (SSS+MMM*60+HHH*60*60)) < 30*60.

/* * * * perceptions from artifact * * * */

+setPreco(S,V)  : .time(HH,MM,SS) <- -+fundamentals::preco(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setLPA(S,V)    : .time(HH,MM,SS) <- -+fundamentals::lpa(S,V)[date(DD,OO,YY),time(HH,MM,SS)].
+setVPA(S,V)    : .time(HH,MM,SS) <- -+fundamentals::vpa(S,V)[date(DD,OO,YY),time(HH,MM,SS)].

/* * * * plans * * * */

//TODO: It was not easy to realize that the artifact is sending a string back and it is not being treated as a term

// get cached Fundamentals if earlier data are younger than 30 minutes
+!opinion(S)[source(Q)] 
    : 
    .date(YY,OO,DD) & .time(HH,MM,SS) & 
    fundamentals::preco(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::lpa(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH) & 
    fundamentals::vpa(S,_)[date(DDD,OOO,YYY),time(HHH,MMM,SSS)] &  YY == YYY & OO == OOO & DD == DDD & lessthanonehour(SS,MM,HH,SSS,MMM,HHH)
    <- 
    .print("Getting cached fundamentals from ",S); 
    !reply(S,Q);
    .

// get Fundamentals again
+!opinion(S)[source(Q)] : .date(YY,OO,DD) <- 
    .print("Getting fundamentals from ",S); 
    getFundamentals(S);
    .wait(500);
    -+lastDate(YY,OO,DD);
    !reply(S,Q);
    .

+!reply(S,Q)[source(self)] 
    : 
    recommend(S) 
    <-
    .concat("Baseado no metodo de Grahan, ", S," tem Preco (",P,") menor que raiz quadrada de 22.5*",L,"*", V," (",math.round(math.sqrt(22.5 * L * V)*100)/100,"): COMPRAR", CCC)
    .send(Q,tell,stocks::recommend(S,comprar,CCC));
    .

+!reply(S,Q)[source(self)] 
    : 
    fundamentals::preco(S,P) & 
    fundamentals::lpa(S,L) & 
    fundamentals::vpa(S,V) 
    <-
    .concat("Baseado no metodo de Grahan, ", S," NAO cumpre os requisitos de Preco (",P,") menor que raiz quadrada de 22.5*",L,"*", V," (",math.round(math.sqrt(22.5 * L * V)*100)/100,"): NAO COMPRAR", CCC)
    .send(Q,tell,stocks::recommend(S,neutro,CCC));
    .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
			
			
			
			
			
			
			
			
			
			
			
			
