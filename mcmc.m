function [ theta ] = mcmc( initial, nmax, obs, G )
%MCMC Estimates the probability of multivariate Bernoulli model given
%observations sequence and railway graph using Metropolis?Hastings
%algorithm with specified nmax number of iterations.

d = numel(initial);

alpha = 0.1;                        % step size
alpha_decay = 0.9;                  
decay_step = 2 * numel(initial);    % multiply alpha by alpha_decay every 
                                    % decay_step iterations

theta = initial;

for i = 1:nmax
    
    k = mod(i, d) + 1;
    new_theta = theta;
    new_theta(k) = normrnd(theta(k), alpha);
    
    
    
%     if mod(i, decay_step) == 0
%         alpha = alpha * alpha_decay;
%     end
    
end
