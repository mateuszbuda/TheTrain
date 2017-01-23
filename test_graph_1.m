function [ A, G, railway, TRANS, EMIS ] = test_graph_1( )
%TEST_GRAPH_1 Hamiltonian graph with 6 nodes, all switches set to R.
%   Regardless of starting position, the train makes circles passing all
%   nodes.

A = [0 1 0 1 0 1; 1 0 1 0 0 1; 0 1 0 1 1 0; 1 0 1 0 1 0; 0 0 1 1 0 1; 1 1 0 0 1 0];

G = [0 3 0 2 0 1; 2 0 1 0 0 3; 0 1 0 3 2 0; 3 0 2 0 1 0; 0 0 2 1 0 3; 1 3 0 0 2 0];

setting = ones(6, 1);

railway = set_switches(G, setting);

[TRANS, EMIS] = railway2hmm(railway);
