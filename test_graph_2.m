function [ A, G, railway, TRANS, EMIS ] = test_graph_2( )
%TEST_GRAPH_2 Hamiltonian graph with 8 nodes, half of switches set to R.
%   Regardless of starting position, the train makes circles passing all
%   nodes.

A = [0 1 0 1 0 0 0 1; ...
    1 0 1 0 0 0 1 0; ...
    0 1 0 1 0 1 0 0; ...
    1 0 1 0 1 0 0 0; ...
    0 0 0 1 0 1 0 1; ...
    0 0 1 0 1 0 1 0; ...
    0 1 0 0 0 1 0 1; ...
    1 0 0 0 1 0 1 0];

G = [0 2 0 1 0 0 0 3; ...
    3 0 2 0 0 0 1 0; ...
    0 3 0 2 0 1 0 0; ...
    1 0 3 0 2 0 0 0; ...
    0 0 0 3 0 2 0 1; ...
    0 0 1 0 3 0 2 0; ...
    0 1 0 0 0 3 0 2; ...
    2 0 0 0 1 0 3 0];

setting = [0; 1; 0; 1; 0; 1; 0; 1];

railway = set_switches(G, setting);

[TRANS, EMIS] = railway2hmm(railway);
