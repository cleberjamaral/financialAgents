# finantialAgents 
This project is an on-the-fly programming application of a Multi-Agent System composed by "finantial consultants". Each consultant will be encharged of a specific stock exchange. There is a manager that can gather information from all consultants summarizing the current situation of the market. The agents are able to "talk" to human by telegram application. Step by step the agents is going to be improved, in an on-the-fly programming way.

![Alt text](https://g.gravizo.com/source/custom_mark10?https%3A%2F%2Fraw.githubusercontent.com%2Fcleberjamaral%2Fcleberjamaral.github.io%2Fmaster%2FREADME.md)

<details> 
<summary></summary>
custom_mark10
digraph {
    subgraph cluster_0 {
        label="Multi-Agent System";
        StockData [shape=box];
        Manager;
        Consultant ["n Consultants"];
        Manager -> Consultant;
        Consultant -> StockData;
        Consultant -> Telegram;
        Manager -> Telegram;
    }
    subgraph cluster_1 {
        label="Humans";
        Telegram [shape=diamond];
        Human -> Telegram;
    }
}
custom_mark10
</details>

