""" HITS algorithm

Hyperlink-Induced Topic Search (HITS; also known as hubs and authorities) is a link analysis algorithm that rates Web pages, developed by Jon Kleinberg

https://en.wikipedia.org/wiki/HITS_algorithm """

function HITS(g::AbstractGraph, mx=100::Integer, tol=1e-6)
	N = Int(nv(g))
	a0 = fill(0, N)
	h0 = fill(1. / N, N)
	ag = adjacency_matrix(g)
	for _ in 1:mx
		auth = *(ag', h0)
		auth = normalize(auth)
		hubs = *(ag, auth)
		hubs = normalize(hubs)
		if (sum(abs.(-(hubs, h0))) <= tol)
			return hubs, auth
		end
		