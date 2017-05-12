-------
Design:
-------

1) Julia Chat is customer engagement platform written in Julia
2) Julia has a intelligent Routing Engine
3) Julia is a cloud based application hosted on Azure


------------
Requirements
------------
1) Browser


------------
Architecture
------------
1) WebServer
2) Julia SSIP Server
3) Routing Engine


----------
Web Server
----------
1) Web server provides the chat client
2) Chat client will communicate with Julia SSIP to initialize connection
3) Julia SSIP establishes between Customer and Agent
4) Customer and Agent are connected

API:

POST /user 
body:
    name: , age:, gender: , language:, reason:, place:
response:
    ws port:


------------
Julia client
------------
1) initiate request
2) change port
3) send/ receive message
4) close chat


--------------
Routing Engine
--------------
1) Decides which is the "right" Agent for the customer

