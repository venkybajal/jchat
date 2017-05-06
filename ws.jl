using WebSockets
using HttpServer

type User
    name::String
    is_external::Bool
    age::Int16
    clientHandle
end


#Chat == pair(User1, User2) 
chats = Dict()

# Array of users
registrar = User[]



function getBestAgent(user)
   
    # preprocessing of matrix

    # apply user against the recomendation engine

    # Register A
end

function process(client, msg::String)

    arr = split(msg)
    println(msg)
    if arr[1] == "REGISTER"
        println("Register Received: $msg")
    
        # add the user info in registrar
        user = User(arr[2], true, 4, client)         


        push!(registrar, user)
        # if message is Internal, Query the Routing Engine for the "best" possible agent
        println("Elements of rgistrar")
        for i in registrar
            println(i)
        end

        write(client, "Register Received")
        return true

    elseif arr[1] == "MESSAGE"
        write(client, "Message Received")
        println("MESSAGE Received")
        return true
        # get the destination party from chats::Dict and send the message



    elseif arr[1] == "RELEASE"
        write(client, "Release Received")
        println("RELEASE Received")
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

