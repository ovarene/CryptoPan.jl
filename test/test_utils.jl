#=
test_utils:
- Julia version: 1.2.0
- Author: ovarene
- Date: 2019-09-19
=#

using Printf
using Test
using CryptoPan

@test "c2" == CryptoPan.to_hex(194)
@test "7" == CryptoPan.to_hex(7) #special case requiring string

@test [10,234,1,2] == CryptoPan.split_to_ints("10.234.1.2")

@test 183107842 == CryptoPan.to_int([10,234,1,2])

@test [10,234,1,2] == CryptoPan.to_array(183107842)

@test [0x0a,0xea,0x01,0x02] == CryptoPan.to_bytearray(CryptoPan.to_array(183107842))
