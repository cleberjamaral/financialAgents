# Finantial Agents 
This project is an on-the-fly programming application of a Multi-Agent System composed by "finantial consultants". Each consultant will be encharged of a specific stock exchange. There is a manager that can gather information from all consultants summarizing the current situation of the market. The agents are able to "talk" to human by telegram application. Step by step the agents is going to be improved, in an on-the-fly programming way.

![Alt text](https://g.gravizo.com/source/finantialAgentsOverview?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2FfinantialAgents%2Fmaster%2FREADME.md)

<details> 
<summary>Finantial Agents Overview</summary>
finantialAgentsOverview
digraph G {
	subgraph cluster_0 {
		label="Multi-Agent System";
		StockData [shape=cylinder];
		Manager;
		Consultant [label="n Consultants"];
	}
	subgraph cluster_1 {
		label="Telegram";		
		Telegram [shape=note];
	}
	subgraph cluster_2 {
		label="Humans";
		Human [shape=circle];
	}
        Manager -> Consultant;
        Consultant -> StockData;
	Consultant -> Telegram [constraint=false];
	Manager -> Telegram [constraint=false];
	Human -> Telegram [constraint=false];
}
finantialAgentsOverview
</details>

# Project Phases

![Alt text](https://g.gravizo.com/source/finantialAgentsPhases?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2FfinantialAgents%2Fmaster%2FREADME.md?1)
<details> 
<summary>Project phases - deliveries every week</summary>
finantialAgentsPhases
@startuml;
(*) -right-> "run auction demo app";
-right-> "change agent plans to store\nan stock exchange and\nrecomended price";
-right-> "change artifact to access\ncurrent stock prices\nautomatically";
-down-> "week4";
-left-> "week5";
-left-> "week6";
-left-> "week7";
-down-> "week8";
-right-> "week9";
-right-> "week10";
-right-> "week11";
@enduml 
finantialAgentsPhases
</details>
