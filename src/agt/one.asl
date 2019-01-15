// Agent one in project finantialAgents

!create_group.

+!createAgent(A, File) <-
	.create_agent(A, File, [beliefBaseClass("jason.bb.TextPersistentBB")]). 

+!killAgent(A) <-
	.concat("telegram",A,TA);
	!!disposeArtifact(TA);
	.concat("stock",A,SA);
	!!disposeArtifact(SA);
	.send(A,achieve,saveYourself);
	.wait(1000);
	.kill_agent(A).

+!disposeArtifact(Art) <-
	lookupArtifact(Art,AidD);
	disposeArtifact(AidD).

// workspace already exists?
+!create_group <- 
	createWorkspace(finantialagents);
	joinWorkspace(finantialagents,Ofa);
	.print("DEBUG: Creating group...");
	o::makeArtifact(finantialagents, "ora4mas.nopl.OrgBoard", ["src/org/finantial_agents.xml"], OrgArtId)[wid(Ofa)];
	o::focus(OrgArtId);
	g::createGroup(finantial_team, finantial_group, GrArtId);
	!createagents;
	g::focus(GrArtId);
	g::adoptRole(generalcontroller);
	.

-!create_group[error(E), error_msg(M), reason(R)] <-
    .print("** Error ",E," creating group: ",M, ". Reason: ", R).

// when I start playing the role
+g::play(Me,generalcontroller,GId) : .my_name(Me) <- 
	.print("DEBUG: Playing role...");
	!create_scheme;
	.

+!create_scheme <- 
	.print("DEBUG: Creating scheme...");
    o::createScheme("scheme", finantial_sch, SchArtId);
    s::focus(SchArtId);
    g::addScheme("scheme");
	s::commitMission(mlaunchsystem);
	.
	  
+!createagents <-
	!!createAgent(bot1,"expert.asl");
	!!createAgent(bot2,"expert.asl");
	!!createAgent(bot3,"expert.asl");
	!!createAgent(bot4,"expert-jasoncamel.asl");
	!!createAgent(ca,"chiefanalyst.asl");
	!!createAgent(jomi,"human.asl");
	!!createAgent(rafael,"human.asl");
	!!createAgent(cleber,"human.asl");
	!!createAgent(sergio,"human.asl");
	!!createAgent(olivier,"human.asl");
	.

+!destroySystem <-
	!!killAgent(bot1);
	!!killAgent(bot2);
	!!killAgent(bot3);
	!!killAgent(bot4);
	!!killAgent(ca);
	!!killAgent(jomi);
	!!killAgent(rafael);
	!!killAgent(cleber);
	!!killAgent(olivier);
	!!killAgent(sergio);
	!!disposeArtifact("telegrambot1");
	!!disposeArtifact("telegrambot2");
	!!disposeArtifact("telegrambot3");
	!!disposeArtifact("telegramca");
	!!disposeArtifact("stockbot1");
	!!disposeArtifact("stockbot2");
	!!disposeArtifact("stockbot3");
	!!disposeArtifact("finantial_agents");
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
