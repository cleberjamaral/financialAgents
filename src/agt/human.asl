// beliefs and rules


// initial goals


+!sendMail(Msg) : .my_name(N) <-
	.concat(N, ": ", Msg, C);
	.send(toEmail, tell, C);
	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
