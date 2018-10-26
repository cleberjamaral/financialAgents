# finantialAgents 
This project is an on-the-fly programming application of a Multi-Agent System composed by "finantial consultants". Each consultant will be encharged of a specific stock exchange. There is a manager that can gather information from all consultants summarizing the current situation of the market. The agents are able to "talk" to human by telegram application. Step by step the agents is going to be improved, in an on-the-fly programming way.

![Alt text](https://g.gravizo.com/svg?
  digraph G {
    size ="4,4";
    StockData [shape=box];
    Telegram [shape=diamond];
    Manager;
    Consultant ["n Consultants"];
    Manager -> Consultant;
    Consultant -> StockData;
    Consultant -> Telegram;
    Manager -> Telegram;
    Human -> Telegram;
  }
)
