using WebSockets
using HttpServer
include("routing_engine.jl")
using RoutingEngine

ID=1
type User
    id::Int64
    name::String
    is_external::Bool
    age::Int16
    clientHandle
end


#Chat == pair(User1, User2) 
chats = Dict()
# Array of users
registrar = Dict()

function getBestAgent(user)

    agents = get_the_recommendation(user, 5)
    println(agents)
    for i in agents

        if haskey(registrar, i[1])
            resp = registrar[i[1]]
            return resp
        end
    end 
    
end


function process(client, msg::String)

    arr = split(msg)
    println(msg)
    global ID
    if arr[1] == "REGISTER"
        println("Register Received: $msg")
        
        
        # add the user info in registrar
        if arr[3] == "agent"
            println("Is a agent")
            if ID%2 != 0
                ID+=1
            end
            user = User(ID, arr[2], false, 4, client)    
        else
            println("user")
            if ID%2 == 0
                ID+=1
            end    
            user = User(ID, arr[2], true, 4, client)                     
        end
        ID += 1
        println(user)
            
        registrar[user.id] = user
        # if message is Internal, Query the Routing Engine for the "best" possible agent
        if user.is_external
            agent = getBestAgent(user)
            chats[client] = agent
            chats[agent.clientHandle] = user 
        end

        write(client, "200OK")
        return true

    elseif arr[1] == "MESSAGE"
        println(chats)
        other = chats[client]
        try
            write(other.clientHandle, String(arr[2]))
        catch
            delete!(chats,other)
            delete!(chats,user)
            if other.is_external
                delete!(registrar, user)
            else
                delete!(registrar, other)
                delete!(registrar, user)
            end
        end            
        println("MESSAGE Received")
        return true
        # get the destination party from chats::Dict and send the message

    elseif arr[1] == "RATE"
        write(client, "Release Received")
        println("RELEASE Received")
        save_ratings(user, get_other(user), arr[2])
        return true
        # remove the user from Register
    else
        # Undefined behavior as of now
        println("Incorrect Message")
        return false
    end
         
end



# Main Server
wsh = WebSocketHandler() do req,client
    while true
        msg = read(client)
        j = takebuf_string(IOBuffer(msg))
        if !process(client, j)
            break
        end
    end
  end


server = Server(wsh)
run(server,8080)

