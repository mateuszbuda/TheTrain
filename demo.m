N = 4;

symbols = {'0L' '0R' 'L0' 'R0'};


[A, G, railway, TRANS, EMIS] = generate_graph(N / 2, 0.5);
% [A, G, railway, TRANS, EMIS] = test_graph_1();

figure;
plot(graph(A));


figure;
plot(digraph(railway), 'EdgeLabel', digraph(railway).Edges.Weight);


[obs, states] = generate_obs(20, TRANS, EMIS, symbols);

S = train_position(G, obs, symbols);
