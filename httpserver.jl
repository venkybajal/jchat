include("utils/http.jl")

using MyHttp
using MyHttp.HttpServer


type User
    name::String
    age::Int32
    sex::String
    interest::String

end
function readfile(path::String)
    f = open(path, "r+")
    readstring(f)
end

http = HttpHandler() do req::Request, res::Response
       
    if ismatch(r"^/start",req.resource) && req.method == "GET"

        responseHtml(res,readfile("static/chat.html")) 
     else
        responseError(res, 404 )
    end

end    

server = Server( http )
run( server, 8000 )

