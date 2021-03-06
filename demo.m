rng(42)

N = 6;

symbols = {'0L' '0R' 'L0' 'R0'};

[A, G, railway, TRANS, EMIS] = generate_graph(N / 2, 0.5);
% [A, G, railway, TRANS, EMIS] = test_graph_1();
% [A, G, railway, TRANS, EMIS] = test_graph_2();


figure;
subplot(1, 2, 1);
plot(graph(A), 'Layout', 'circle');

set(gca, 'XTickLabel', '');
set(gca, 'YTickLabel', '');


subplot(1, 2, 2);
plot(digraph(railway), 'EdgeLabel', digraph(railway).Edges.Weight);

set(gca, 'XTickLabel', '');
set(gca, 'YTickLabel', '');


[obs, states] = generate_obs(20, TRANS, EMIS, symbols)

[S, sigma_mvnbin] = train_position(G, obs, symbols)
