N = 6;

[G, railway, TRANS, EMIS] = generate_graph(N / 2, 0.5);

plot(digraph(railway), 'EdgeLabel', digraph(railway).Edges.Weight);

symbols = {'0L' '0R' 'L0' 'R0'};

[obs, states] = generate_obs(100, TRANS, EMIS, symbols)

theta = mcmc(rand(N, 1), 10000, obs, G, symbols)
