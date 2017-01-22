function [ railway ] = set_switches( G, setting )
%SET_SWITCHES Set switches on graph G, that is assumed to be 3-regular, by
%removing edges as specified by given setting.
%   G is adjacency matrix with weights corresponding to directions as
%   follows: 1 - '0', 2 - 'L' and 3 - 'R'
%   setting is a {0, 1}^N vector with 0 corresponding to 'L' and 1 to 'R'

N = size(G, 1);

for i = 1:N
    
    s = 3 - setting(i);
    G(i, G(i, :) == s) = 0;
    
end

railway = G;
