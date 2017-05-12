
--------
Features
--------

1) JChat is minimalistic customer engagement platform written in Julia
2) JChat has a intelligent Routing Engine
3) JChat is a cloud based application hosted on Azure

------------
Requirements
------------
1) Browser


------------
Architecture
------------
1) WebServer
2) Chat Server
3) Routing Engine

-----------
Chat Server
-----------
manages the session between user and agent

--------------
Routing Engine
--------------
1) Decides which is the "right" Agent for the customer using Recommendation.jlrou

-----
Usage:
-----

1) Open atleast browser windows (one for user, two for agents)
2) Login the agents first
3) Login the user
4) User will be connected to one of the agent based on the recommendation
5) Close the chat window after interaction
6) Rate the interaction on the scale of 0-5


-----------
Future Work
-----------
1) Use content-based recommender system for better routing
2) Add Group Chatting capability
3) Improve the User Interfaces



