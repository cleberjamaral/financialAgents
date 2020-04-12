stocks::radar(['ABCB4','ABEV3','ALUP11','B3SA3','BBAS3','BBDC4','BBSE3','BRFS3','BIDI11','BRAP4','BRDT3','BRFS3','BRKM5','BRML3','BTOW3','CARD3','CCRO3','CGRA4','CIEL3','CMIG4','COCE5','CSAN3','CSNA3','CVCB3','CYRE3','ECOR3','EGIE3','ELET6','EMBR3','ENBR3','EQTL3','FLRY3','GEPA4','GGBR4','GRND3','GOAU4','GOLL4','HAPV3','HYPE3','IGTA3','ITSA4','ITUB4','JBSS3','KLBN11','COGN3','LAME4','LOGG3','LREN3','MGLU3','MRFG3','MRVE3','MULT3','NATU3','PCAR4','PETR4','QUAL3','RADL3','RAIL3','RENT3','SANB11','SAPR11','SBSP3','SMLS3','SQIA3','SULA11','SUZB3','TAEE11','TIET11','TIMP3','TUPY3','UGPA3','UNIP6','USIM5','VALE3','VIVT4','VVAR3','WEGE3','WIZS3']).
//stocks::radar(['ABEV3','B3SA3','BBAS3','CYRE3','ECOR3','EGIE3','ELET3','VIVT4']).

+!joinFinancialGroup <-
    joinWorkspace(financialorg,Ofa);
    .print("DEBUG: Joining group...");
    g::lookupArtifact(financialteam, GrArtId)[wid(Ofa)];
    g::focus(GrArtId)[wid(Ofa)];
    g::adoptRole(assistant)[wid(Ofa)];
    s::lookupArtifact(financialsch, ScArtId)[wid(Ofa)];
    s::focus(ScArtId)[wid(Ofa)];
    s::commitMission("mAssistant")[artifact_id(ScArtId),wid(Ofa)];
    .

+!lookForOpportunities : stocks::radar(L) <-

    .at("now +24 h", {+!lookForOpportunities});
    
    //TODO: I've tried to make a sequence on org, firstly making sure 3 mConsultant where committed to than do this plan, but unfortunatelly a .wait is still necessary
    .wait(3000); 

    .print("Looking for opportunities on the stocks of my radar...");
    .abolish(stocks::recommend(_,_,_));
    for (.member(I,L)) {
        .lower_case(I,Item); //Internally allway lower which is easier to be treated as a string
        .send(bazin,achieve,opinion(Item));
        .send(graham,achieve,opinion(Item));
        .send(greenblatt,achieve,opinion(Item));
        .print("Asking for: '",Item,"'.");
        
        //Why this wait is necessary?
        .wait(2000);
    };
    .

+!checkOpportunities : stocks::radar(L) <-

    //TODO: I've tried to make a sequence on org, firstly making sure 3 mConsultant where committed to than do this plan, but unfortunatelly a .wait is still necessary
    .wait(30000); 

    .print("Checking if there are good opportunities...");
    -+n33([]);
    for (.member(T,L)) {
        .lower_case(T,Item); //Internally allways lower which is easier to be treated as a string
        .count(stocks::recommend(Item,comprar,_),N);
        if (N == 3) {
	    ?n33(N33);
	    -+n33([Item|N33]);
        }
    };
    ?n33(N333);
    .concat("Recomendado COMPRAR por todos os consultores: ",N333, CCC);
    .send(toTelegram,tell,CCC);

    -+n23([]);
    for (.member(T,L)) {
        .lower_case(T,Item); //Internally allways lower which is easier to be treated as a string
        .count(stocks::recommend(Item,comprar,_),N);
        if (N == 2) {
            ?n23(N23);
            -+n23([Item|N23]);
        }
    };
    ?n23(N233);
    .concat("Recomendado COMPRAR por 2/3 dos consultores: ",N233, CC2);
    .send(toTelegram,tell,CC2);
    .
    
+!getOpportunities <- 
    println("*** Finished ***");
    .

+!opinion(T) <-
    .lower_case(T,S); //Internally allway lower which is easier to be treated as a string
    .abolish(stocks::recommend(S,_,_));
    .send(bazin,achieve,opinion(S));
    .send(graham,achieve,opinion(S));
    .send(greenblatt,achieve,opinion(S));
    .wait(2500); // back to .wait model to make 'look for opportunities' similarly
    !!reply(S);
    .
/*
+stocks::recommend(S,_,_) : .count(stocks::recommend(S,_,_),N) & N >= 3 <-
    !reply(S);
    .

+stocks::recommend(_,_,_).
*/

+!reply(S) :
    //.term2string(T,S) &
    stocks::recommend(S,Y1,Z1)[source(bazin)] & stocks::recommend(S,Y2,Z2)[source(grahan)] &
    stocks::recommend(S,Y3,Z3)[source(greenblatt)] & .count(stocks::recommend(S,comprar,_),N) & N >= 2 
    <-
    .concat(Z1,"\n\n",Z2,"\n\n",Z3,"\n\nResumo: COMPRAR", CCC);
    .send(toTelegram,tell,CCC);
    .

+!reply(S) : 
    //.term2string(T,S) &
    stocks::recommend(S,Y1,Z1)[source(bazin)] & stocks::recommend(S,Y2,Z2)[source(grahan)] &
    stocks::recommend(S,Y3,Z3)[source(greenblatt)] 
    <-
    .concat(Z1,"\n\n",Z2,"\n\n",Z3,"\n\nResumo: NAO COMPRAR", CCC);
    .send(toTelegram,tell,CCC);
    .

+!reply(T) : true 
    //.term2string(T,S) 
    <-
    .concat("Ocorreu um erro ao tentar obter as opinioes dos consultores em ",T, CCC);
    .send(toTelegram,tell,CCC);
    .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
			
			
