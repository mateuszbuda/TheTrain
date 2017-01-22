function [ G, railway, TRANS, EMIS ] = generate_graph( nodes, ratio )
%GENERATE_GRAPH Generates railway graph of given size and L to R ratio
%   parameters:
%   nodes - the number of switches will be 2*nodes as there must be even
%   number of them
%   ratio - the probability of setting swich to R
%   returns:
%   G - graph matrix
%   railway - graph matrix with wieghts corresponding to deirections: 
%       1 - 0; 2 - L; 3 - R.
%   TRANS, EMIS - HMM for observations generation

if nargin < 1
    nodes = 6;
    type = 'random';
elseif nargin < 2
    type = 'random';
end

if nodes < 2
    nodes = 2;
end

N = 2 * nodes;

%% generate random 3-regular graph 

A = random_graph(N, 0, 0, 'sequence', ones(1, N) * 3);

%% set L, R and 0 directions

for i = 1:N
    
    s = randperm(3);
    k = 1;
    
    for j = 1:N
        
        if A(i, j) ~= 0
            A(i, j) = s(k);
            k = k + 1;
        end
        
        if sum(A(i, :)) == 6
            break;
        end
        
    end
    
end

G = A;
% figure;
% plot(G);

%% set switches

setting = binornd(ones(N, 1), ones(N, 1) * 0.5);    % random
% setting = binornd(ones(N, 1), ones(N, 1));        % all right
% setting = binornd(ones(N, 1), zeros(N, 1));       % all left
railway = set_switches(G, setting);

% figure;
% plot(railway, 'EdgeLabel', railway.Edges.Weight);

%% create HMM for observations generation

[TRANS, EMIS] = railway2hmm(railway);


