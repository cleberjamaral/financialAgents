# Finantial Agents 
This project is an on-the-fly programming application of a Multi-Agent System composed by "finantial consultants". Each consultant will be encharged of a specific stock exchange. There is a manager that can gather information from all consultants summarizing the current situation of the market. The agents are able to "talk" to human by telegram application. Step by step the agents is going to be improved, in an on-the-fly programming way.

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
	Expert -> Telegram [constraint=false, label="My expertice is XYZ3\nCurrent quotation is R$ 10.00\nI recomend buy/sell/wait\nStock is now under ceiling price"];
	ChiefAnalyst -> Telegram [constraint=false, label="I am the analyst\nI recomend action ABC4"];
	Human -> Telegram [constraint=false, label="Your expertice?\nCurrent quotation?\nYour recomendation?"];
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
-right-> "expert start to monitor a stock\nexpert accepts ceiling price";
-right-> "expert recomended action";
-down-> "agents use different contexts on telegram\nanswering on group or in private";
-left-> "expert start to use data base";
-left-> "expert stores historical data";
-left-> "expert uses history to alert buy zone";
-down-> "expert apply AI to predict prices";
-right-> "expert uses prediction to advise\nopportunities";
-right-> "expert uses sensitive analysis";
-right-> "chief analyst get sentimental data\nsend to client";
-down-> "Develop natural language processing";
-right-> (*) 
@enduml 
finantialAgentsPhases
</details>

## NLP
https://codeburst.io/nlp-implementation-using-java-opennlp-guide-and-examples-80d86b02b5b5

