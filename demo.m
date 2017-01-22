N = 6;

symbols = {'0L' '0R' 'L0' 'R0'};


[G, railway, TRANS, EMIS] = generate_graph(N / 2, 0.5);

plot(digraph(railway), 'EdgeLabel', digraph(railway).Edges.Weight);


[obs, states] = generate_obs(20, TRANS, EMIS, symbols)


mu = ones(1, N) * 0.5;
sigma = ones(1, N) * 0.1;
initial = mvnrnd(mu, sigma)';
nmax = 1000;

theta = mcmc(initial, nmax, obs, G, symbols)
