[G, railway, TRANS, EMIS] = generate_graph(2, 0.5)

[seq, states] = hmmgenerate(10, TRANS, EMIS, 'Symbols', ['L' 'R'], 'Statenames', [1 1 2 2 3 3 4 4])

plot(digraph(railway), 'EdgeLabel', digraph(railway).Edges.Weight)