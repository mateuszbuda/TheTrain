function [ railway ] = generate_graph( size, ratio )
%GENERATE_GRAPH Generates railway graph of given size and L to R ratio
%   size - the number of switches will be 2*size as there must be even
%   number of them
%   ratio - the probability of setting swich to R
%   returns railway graph with wieghts corresponding to deirections as
%   follows: 1 - 0; 2 - L; 3 - R.

if nargin < 1
    size = 6;
    type = 'random';
elseif nargin < 2
    type = 'random';
end

if size < 2
    size = 2;
end

N = 2 * size;

%% generate 3-regular graph 

A = zeros(N);

j = 1;
for i = 1:N
    
    for k = 1:(3 - sum(A(i, :)))
        
        j = j + 1;
        if j > N
            j = i + 1;
        end
        
        A(i, j) = 1;
        A(j, i) = 1;
        
    end
    
end

%% set L, R and 0 directions

for i = 1:N
    
    for j = 1:N
        
        if A(i, j) ~= 0
            A(i, j) = sum(A(i, :)) - A(i, j);
        end
        
        if sum(A(i, :)) == 6
            break;
        end
        
    end
    
end

%% set switches

for i = 1:N
    
    if rand(1) < ratio
        s = 2;
    else
        s = 3;
    end
    
    A(i, A(i, :) == s) = 0;
    
end

railway = digraph(A);
plot(railway, 'EdgeLabel', railway.Edges.Weight);

