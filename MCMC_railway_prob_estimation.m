function [ P ] = MCMC_railway_prob_estimation( TRANS, EMIS, obs, nmax )
%MCMC_RAILWAY_PROB_ESTIMATION Estimates the probability of obesrvation

N = size(obs, 2) / 3;

match = 0;

for i = 1:nmax
    
    if strcmp(obs, generate_obs(N, TRANS, EMIS))
        match = match + 1;
    end
    
end

P = match / nmax;
