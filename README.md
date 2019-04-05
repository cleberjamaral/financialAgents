# Financial Agents 
This project is an on-the-fly programming application of a Multi-Agent System composed by "financial consultants". Each consultant has some assumptions and forecasting technique to give bets about specific stocks. There is chiefs analysts that can gather information from consultants and from a client summarizing the current situation of the market and giving specific suggestions. The agents are able to "talk" to human by telegram application and email. Step by step the agents is going to be improved, in an on-the-fly programming way.

![Alt text](https://g.gravizo.com/source/financialAgentsOverview?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2FfinantialAgents%2Fmaster%2FREADME.md)
<details> 
<summary>Financial Agents Overview</summary>
financialAgentsOverview
digraph G {
	subgraph cluster_0 {
		label="Multi-Agent System\nFinancial Agents";
		Assistant [label="Personal Assistant"];
		Expert1 [label="Expert 1"];
		ExpertN [label="Expert N"];
	}
	subgraph cluster_1 {
		label="Humans";
		Human [shape=circle];
	}
	subgraph cluster_2 {
		label="Legend";
		node[ shape = plaintext ];
		leg2[ label = "Through\nTelegram" ];
		leg4[ label = "ACL\nMessage" ];
		node [ shape = point height = 0 width = 0 margin = 0 ];
		leg1 leg3
		{ rank = same; leg1 leg2 }
		{ rank = same; leg3 leg4 }
		edge[ minlen = 1 ];
		leg1 -> leg2[ style = dotted ];
		leg3 -> leg4;
	}
	Human -> Assistant [color = gray20, fontcolor = gray20, style = dotted, label="Recomendation?"];
	Assistant -> Expert1 [color = gray20, fontcolor = gray20, label="ABCD?"];
	Expert1 -> Assistant [color = black, fontcolor = black, label="ABCD\nwill rise"];
	Assistant -> ExpertN [color = gray20, fontcolor = gray20, label="ABCD?"];
	ExpertN -> Assistant [color = black, fontcolor = black, label="ABCD\nis cheap"];
	Assistant -> Human [color = black, fontcolor = black, style = dotted, label="Buy\nABCD"];
}
financialAgentsOverview
</details>

# Project Phases

![Alt text](https://g.gravizo.com/source/financialAgentsPhases?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2FfinantialAgents%2Fmaster%2FREADME.md?1)
<details> 
<summary>Project phases - deliveries every week</summary>
financialAgentsPhases
@startuml;
(*) -right-> "adapt camel-artifact to be generic\nrun auction demo app";
-right-> "expert are able to get stock quotation";
-right-> "expert gives quotation by telegram";
-down-> "agents use different contexts on telegram\nanswering on group or in private";
-left-> "expert start to use data base";
-left-> "expert stores historical data";
-left-> "expert apply AI to predict prices";
-down-> "chief uses prediction to advise\nopportunities";
-right-> "agent uses sensitive analysis";
-right-> "chief analyst get sentimental data\nsend to client";
-down-> "Develop natural language processing";
-right-> (*) 
@enduml 
financialAgentsPhases
</details>

## NLP
https://codeburst.io/nlp-implementation-using-java-opennlp-guide-and-examples-80d86b02b5b5

