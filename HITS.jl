""" HITS algorithm

Hyperlink-Induced Topic Search (HITS; also known as hubs and authorities) is a link analysis algorithm that rates Web pages, developed by Jon Kleinberg

https://en.wikipedia.org/wiki/HITS_algorithm """

function HITS(g::AbstractGraph, mx=100, tol=1e-6, h0=nothing)
    N = Int(nv(g))
    if (h0 == nothing)
        h0 = fill(1. / N, N)
    else
        h0 = normalize(h0)
    end
    ag = adjacency_matrix(g)
    agT = is_directed(g) ? ag' : ag
    for _ in 1:mx
        auth = normalize(agT * h0)
        hubs = normalize(ag * auth)
        sum(abs.(hubs - h0)) <= tol && return (hubs, auth)
        h0 = hubs
    end
    warn("Did not converge")
    return (hubs, auth)
end