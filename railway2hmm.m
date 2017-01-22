function [ TRANS, EMIS ] = railway2hmm( railway )
%RAILWAY2HMM transforms railway graph to HMM transition and emissions
%probability matrices.

N = size(railway, 1);

p = 0.05;   % probability of noisy observation

TRANS = zeros(2 * N);   % odd states 2i-1 correspond to being in node i and
                        % arriving to it from edge 0, whereas
                        % even nodes 2i correspond to being in node i and
                        % arriving to it from edge L or R
                        
EMIS = zeros(2 * N, 4);  % 4 observations: 0L, 0R, L0, R0

for i = 1:N
    
    for j = 1:N
        
        if railway(i, j) == 1
            
            TRANS(2 * i, 2 * j - 1) = 1;
            
        elseif railway(i, j) > 1 % either 2 ('L') or 3 ('R')
            
            TRANS(2 * i - 1, 2 * j) = 1;
            
            EMIS(2 * i - 1, railway(i, j) - 1) = 1 - p;
            EMIS(2 * i - 1, 4 - railway(i, j)) = p;
            
            EMIS(2 * i, railway(i, j) + 1) = 1;
            
        end
        
    end
    
end

%% add uniform initial state probability for odd states

initial = ones(1, 2 * N) / N;
initial(2:2:N) = 0;

TRANS = [0 initial; zeros(size(TRANS, 1), 1) TRANS];

EMIS = [zeros(1, size(EMIS, 2)); EMIS];

