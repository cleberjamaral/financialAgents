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
-right-> "expert start to monitor a stock\nexpert accepts ceiling price\n expert recomended action";
-right-> "expert uses history to alert buy zone";
-down-> "week4";
-left-> "week5";
-left-> "week6";
-left-> "week7";
-down-> "week8";
-right-> "week9";
-right-> "week10";
-right-> "week11";
-right-> (*) 
@enduml 
finantialAgentsPhases
</details>
