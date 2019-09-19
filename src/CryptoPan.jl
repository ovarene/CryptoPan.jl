#=
CryptoPan:
- Julia version: 1.2.0
- Author: ovarene
- Date: 2019-09-19
=#
module CryptoPan

export CryptoPanConf, anonymize

# ===

using AES
using Match

include("CryptoPanConf.jl")

###
# Function

# apply
function calc(a::Int,b_key,pad)
  a_array = to_array(a)
  inp = vcat(to_bytearray(a_array) , pad[5:end])
  rin_output = AESECB(inp,b_key[1:16],true)
  out = rin_output[1]
  Int(out >> 7)
end

# anonymize ip
"""
    anonymize(ip::String, conf::CryptoPanConf)

Anonymizes the provided ip address (in string format) by replacing it with another ip address (string)
using the cryptopan algorithm.

# Example
```julia
julia> use CryptoPan
julia> conf = CryptoPanConf("boojahyoo3vaeToong0Eijee7Ahz3yee")
julia> ip_ano = anonymize("192.0.2.1",conf)
206.2.124.120
```

"""
function anonymize(ip::String,conf::CryptoPanConf)
  result = 0
  a_ints = split_to_ints(ip)
  @assert(length(a_ints) == 4)
  address = to_int(a_ints) # integer representation
  addresses = generate_addresses_from(address,conf.masks)
  calc_addresses = map(a -> calc(a,conf.b_key,conf.pad),addresses)
  result = reduce( (acc,x) -> (acc << 1 | x), calc_addresses, init=0)
  join(to_array(result ⊻ address),".")
end


###
# main
# key="boojahyoo3vaeToong0Eijee7Ahz3yee"
# conf = CryptoPanConf(key)
# ip = "192.0.2.1"
# ip_ano = anonymize(ip,conf)
# @printf("IP %s --(ano)--> %s",ip,ip_ano)
# @assert "206.2.124.120" == ip_ano

end # module