function [ S, sigma_mvnbin ] = train_position( G, obs, symbols )
%TRAIN_POSITION Estimates the probability of train stop position for each
%node in G

N = size(G, 1);

mu = ones(1, N) * 0.5;
sigma = ones(1, N) * 0.1;
initial = mvnrnd(mu, sigma);
nmax = 100;

sigma_mvnbin = mcmc(initial, nmax, obs, G, symbols);

S = zeros(1, N); % probabilities of stop positions

D = 0:2^N - 1;

B = de2bi(D);

for i = 1:size(B, 1) % for each sigma (switches setting)
    
    sigma = B(i, :)';
    
    psigma = prod(binopdf(sigma, ones(N, 1), sigma_mvnbin));
    
    pobs = likelihood(sigma, G, obs, symbols);
    
    railway = set_switches(G, sigma);
    [TRANS, EMIS] = railway2hmm(railway);
    PSTATES = hmmdecode(obs, TRANS, EMIS, 'Symbols', symbols);
    
    for s = 1:N
        
        pstateobs = PSTATES(2 * s) ...  % corresponds to arriving at node s via edge 0
            + PSTATES(2 * s + 1);       % corresponds to arriving at node s via edge L or R
        
        S(s) = S(s) + (pstateobs * psigma / pobs);
        
    end
    
    S = S / norm(S, 1);
    
end
