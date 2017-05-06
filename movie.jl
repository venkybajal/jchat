# chat server for julia

using HttpServer
using WebSockets

wsh = WebSocketHandler() do req,client
    while true
        msg = read(client)
        write(client, msg)
    end
  end

server = Server(wsh)
run(server,8080)
