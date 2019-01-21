# Finantial Agents 
This project is an on-the-fly programming application of a Multi-Agent System composed by "finantial consultants". Each consultant has some assumptions and forecasting technique to give bets about specific stocks. There is chiefs analysts that can gather information from consultants and from a client summarizing the current situation of the market and giving specific suggestions. The agents are able to "talk" to human by telegram application and email. Step by step the agents is going to be improved, in an on-the-fly programming way.

![Alt text](https://g.gravizo.com/source/finantialAgentsOverview?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2FfinantialAgents%2Fmaster%2FREADME.md)
<details> 
<summary>Finantial Agents Overview</summary>
finantialAgentsOverview
digraph G {
	subgraph cluster_0 {
		label="Multi-Agent System\nFinantial Agents";
		StockData [label="Stock Data", shape=cylinder];
		ChiefAnalyst [label="Chief Analyst"];
		Expert [label="n Experts"];
	}
	subgraph cluster_1 {
		label="Telegram";		
		Telegram [shape=note];
	}
	subgraph cluster_2 {
		label="Humans";
		Human [shape=circle];
	}
        ChiefAnalyst -> Expert;
        Expert -> StockData;
	Expert -> ChiefAnalyst [constraint=false, label="I use Neural Networks\nThe stock ABCD will rise X%\nThe stock GHIJ will fall Y%"];
	Human -> Telegram [constraint=false, label="Your recomendation?\nWrite there I bought n ABCD for $ Z.00"];
	ChiefAnalyst -> Telegram [constraint=false, label="Recommendation: buy ABCD and sell GHIJ"];
}
finantialAgentsOverview
</details>

# Project Phases

![Alt text](https://g.gravizo.com/source/finantialAgentsPhases?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2FfinantialAgents%2Fmaster%2FREADME.md?1)
<details> 
<summary>Project phases - deliveries every week</summary>
finantialAgentsPhases
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
finantialAgentsPhases
</details>

## NLP
https://codeburst.io/nlp-implementation-using-java-opennlp-guide-and-examples-80d86b02b5b5

