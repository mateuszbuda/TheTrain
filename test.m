[G, railway, TRANS, EMIS] = generate_graph(3, 0.5);

plot(digraph(railway), 'EdgeLabel', digraph(railway).Edges.Weight);

[obs, states] = generate_obs(10, TRANS, EMIS)
