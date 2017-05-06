module MyHttp

using HttpServer

export responseHtml,HttpServer,responseError

function responseHtml(res::Response, content::String)
    head = Dict("Content-Type"=>"text/html")
    res.status = 200
    merge!(res.headers, head)
    res.data =  content
end

function responseError(res::Response,code::Int64)
    res(404)
end

end