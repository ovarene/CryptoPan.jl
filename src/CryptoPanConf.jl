#=
CryptoPanConf:
- Julia version: 1.2.0
- Author: ovarene
- Date: 2019-09-19
=#
using AES
include("utils.jl")

# Oject constructor
function init_cryptopanconf(obj,key::String)
  obj.key = key
  @assert length(key) == 32
  obj.b_key = Vector{UInt8}(key)
  obj.pad = AESECB(obj.b_key[17:32],obj.b_key[1:16],true)
  _f4 = obj.pad[1:4]
  _f4bp = to_int(map(x->Int(x),_f4))
  obj.masks = generate_masks(_f4bp)
  # return completed object
  obj
end

# Conf Object
"""
    CryptoPanConf object

initialises all the needed internal values to

# Arguments
- `key::String`: 32 bytes long string representing the encoding key

# Example
```julia-repl
julia> conf = CryptoPanConf("boojahyoo3vaeToong0Eijee7Ahz3yee")
```
"""
mutable struct CryptoPanConf
  key::String
  b_key::Vector{UInt8}
  pad::Vector{UInt8}
  masks::Array{Tuple{Int, Int},1}
  CryptoPanConf(key::String) = init_cryptopanconf(new(),key)
end

println("CryptoPanConf loaded")
