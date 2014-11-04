#For drawing graphs
using Gadfly
#To import the table
using DataFrames
#To serve HTTP
using HttpServer

function illume(underscored)
  replace(replace(underscored,"_"," "),r"(\w+)",ucfirst)
end

alldata=readtable(ARGS[1])

css=String[]
for assets=readdir("./css")
  push!(css,string("<style type=\"text/css\">",readall(string("./css/",assets)),"</style>"))
end

params="xparam","yparam","cparam"
body=""
for param=params
  body=string(body,"<td>\n<select id=\"$param\">")
  for helo=alldata
    body=string(body,"<option value=\"$(helo[1])\">$(illume(helo[1]))</option>\n")
  end
  body=string(body,"</select>\n</td>")
end

webpage=string(readall("top"),css,readall("template/header.html"),body,readall("template/footer.html"))

http = HttpHandler() do req::Request, res::Response
    m = match(r"^/(\w+)/(\w+)/(\w+)",req.resource)
    if m == nothing return Response(webpage) end
    draw(SVGJS("file.js.svg", 248, 186),plot(alldata, x=m.captures[1], y=m.captures[2], color=m.captures[3], Geom.point, Theme(default_point_size=1px, highlight_width=0px)))
    return Response(readall("file.js.svg"))
end

http.events["error"]  = (client, err) -> println(err)
http.events["listen"] = (port)        -> println("Listening on $port...")

server = Server(http)
run(server, 8000)
