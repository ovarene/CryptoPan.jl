# CryptoPan.jl

[CryptoPan](https://en.wikipedia.org/wiki/Crypto-PAn) algo in native julia

Cryptographic algorithm for anonymizing IP addresses while preserving their subnet structure


# Install

Via Pkg repo
```julia-repl
pkg> add CryptoPan
...
```

or via github directly
```julia-repl
pkg> add https://github.com/ovarene/CryptoPan.jl
...
```


# Usage
```julia-repl

julia> use CryptoPan
julia> key="boojahyoo3vaeToong0Eijee7Ahz3yee"
julia> conf = CryptoPanConf(key)
...
julia> ip = "192.0.2.1"
julia> ip_ano = anonymize(ip,conf)
"206.2.124.120"
julia> @assert "206.2.124.120" == ip_ano
true
```