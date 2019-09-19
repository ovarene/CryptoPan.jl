#=
utils:
- Julia version: 1.2.0
- Author: ovarene
- Date: 2019-09-19
=#


# Transforms aaa.bbb.ccc.ddd into [aaa,bbb,ccc,ddd]
function split_to_ints(ip::String)
  return map(x->tryparse(Int,x),split(ip,'.'))
end

# Transforms an [int,int,int,int] into an int
function to_int(a::Array{Int})
  a[1] << 24 | a[2] << 16 | a[3] << 8 | a[4]
end

# Transforms an int into [int,int,int,int]
function to_array(n::Int)
  a = []
  for i in range(3,stop=0,step=-1)
    append!(a,n >> (i*8) & 0xFF)
  end
  a
end

# generate addresses from address in int format
function generate_addresses_from(address,masks)
  addresses = []
  for m in masks
    append!(addresses, address & m[1] | m[2] )
  end
  addresses
end

# to_bytearray
function to_hex(num)
  @match num begin
    num::Int, if num >= 0 && num <= 9 end => string(num)
    10 => "a"
    11 => "b"
    12 => "c"
    13 => "d"
    14 => "e"
    15 => "f"
    _ => string(to_hex(div(num,16)), to_hex(mod(num,16)))
  end
end

function to_bytearray(number::Array{Any,1})
  string_representation = join( map(s->"\\x" * to_hex(s),number), "" )
  code_expr = :( hex_representation = @b_str $string_representation )
  eval(code_expr)
  hex_representation
end

# generate an array of tuple serving as masks
function generate_masks(f4bp)
  masks = Array{Tuple{Int, Int},1}() # array of tuples
  for p in 0:31
    mask = 0xFFFFFFFF >> (32-p) << (32-p)
    push!( masks, (Int(mask),f4bp & (~ mask)) )
  end
  masks
end

println("utils loaded")
