function [ G ] = generate_graph( size, type )
%GENERATE_GRAPH Generates railway graph of given size and type
%   size - the number of switches will be 2*size as there must be even
%   number of them
%   type - string; one of 'random', 'ergodic', 'loop'

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

W = zeros(N);

j = 1;
for i = 1:N
    
    for k = 1:(3 - sum(W(i, :)))
        
        j = j + 1;
        if j > N
            j = i + 1;
        end
        
        W(i, j) = 1;
        W(j, i) = 1;
        
    end
    
end
