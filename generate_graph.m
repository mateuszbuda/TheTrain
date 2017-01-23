function [ A, G, railway, TRANS, EMIS ] = generate_graph( nodes, ratio )
%GENERATE_GRAPH Generates railway graph of given size and L to R ratio
%   parameters:
%   nodes - the number of switches will be 2*nodes as there must be even
%   number of them
%   ratio - the probability of setting swich to L
%   returns:
%   A - graph matrix
%   G - graph matrix with wieghts corresponding to deirections: 
%       1 - 0; 2 - L; 3 - R.
%   railway - grapth with switches set
%   TRANS, EMIS - HMM for observations generation

if nodes < 2
    nodes = 2;
end

N = 2 * nodes;

%% generate random 3-regular graph 

A = random_graph(N, 0, 0, 'sequence', ones(1, N) * 3);

%% set L, R and 0 directions

G = A;

for i = 1:N
    
    s = randperm(3);
    k = 1;
    
    for j = 1:N
        
        if G(i, j) ~= 0
            G(i, j) = s(k);
            k = k + 1;
        end
        
        if sum(G(i, :)) == 6
            break;
        end
        
    end
    
end

% figure;
% plot(G);

%% set switches

setting = binornd(ones(N, 1), ones(N, 1) * ratio);
railway = set_switches(G, setting);

% figure;
% plot(railway, 'EdgeLabel', railway.Edges.Weight);

%% create HMM for observations generation

[TRANS, EMIS] = railway2hmm(railway);


