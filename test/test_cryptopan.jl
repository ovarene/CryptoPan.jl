#=
test_cryptopan:
- Julia version: 1.2.0
- Author: ovarene
- Date: 2019-09-19
=#
using Printf
using Test
using CryptoPan

function test_anonymize_e2e()
    key="boojahyoo3vaeToong0Eijee7Ahz3yee"
    conf = CryptoPanConf(key)
    ip = "192.0.2.1"
    ip_ano = anonymize(ip,conf)
    #@printf("IP %s --(ano)--> %s",ip,ip_ano)
    @test "206.2.124.120" == ip_ano
end

test_anonymize_e2e()