# README for Julia Graph Generator

This will generate a graph from any CSV with a header. The graph has three
parameters, X-Axis, Y-Axis, and Color. It uses Gadfly, DataFrames, and
HttpServer. 


### Clone the git repository:
```
$ git clone http://github.com/rickpr/moocjulia.git
$ cd moocjulia
```

### Install Julia and the required packages:
```
julia> Pkg.add("Gadfly")
julia> Pkg.add("DataFrames")
julia> Pkg.add("HttpServer")
```

### Then run it:
```
$ julia server.jl yourfile.csv
```
### Visit your creation:
[http://localhost:8000](http://localhost:8000)

Report any bugs with Issue tracker.
