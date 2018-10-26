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
	Consultant -> Telegram;
	Manager -> Telegram;
	Human -> Telegram;
}
finantialAgentsOverview
</details>

# Project Phases

![Alt text](https://g.gravizo.com/source/finantialAgentsPhases?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2Fcleberjamaral.github.io%2Fmaster%2FREADME.md?1)
<details> 
<summary>Project phases - deliveries every week</summary>
finantialAgentsPhases
digraph G {
	w0 [label="run auction demo app"];
  	w1 [label="change agent plans to store\nan stock exchange and\nrecomended price"];
	w2 [label="change artifact to access\ncurrent stock prices\nautomatically"];
	w0 -> w1;
	w1 -> w2;
	w2 -> w3;
	w3 -> w4;
	w4 -> w5;
}
finantialAgentsPhases
</details>
