function [ sigma ] = mcmc( initial, nmax, obs, G, symbols )
%MCMC Estimates the probability of multivariate Bernoulli model given
%observations sequence and railway graph using Metropolis-Hastings
%algorithm with specified nmax number of iterations.
%   initial - starting switches setting
%   nmax - number of iterations
%   obs - observations sequence for likelihood computation
%   G - railway graph
%   symbols - emissions symbols used in observations sequence generation

d = numel(initial);

alpha = 0.1;                        % step size

sigma = initial;
best_sigma = sigma;

lik = likelihood(sigma, G, obs, symbols);
best_lik = lik;

for i = 1:nmax
    
    k = mod(i, d) + 1;
    new_sigma = sigma;
    new_sigma(k) = normrnd(sigma(k), alpha);        % change one param
%     new_theta = normrnd(theta, ones(d, 1) * alpha); % change all params

    new_sigma = max(zeros(d, 1), min(ones(d, 1), new_sigma));
    
    new_lik = likelihood(new_sigma, G, obs, symbols);
    
    acceptance_prob = new_lik / lik;
    accept = rand() < acceptance_prob;
    
    if accept
        sigma = new_sigma;
        lik = new_lik;
        if lik > best_lik
            best_lik = lik;
            best_sigma = sigma;
        end
    end
    
end

sigma = best_sigma;
