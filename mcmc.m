function [ theta ] = mcmc( initial, nmax, obs, G, symbols )
%MCMC Estimates the probability of multivariate Bernoulli model given
%observations sequence and railway graph using Metropolis?Hastings
%algorithm with specified nmax number of iterations.
%   initial - starting switches setting
%   nmax - number of iterations
%   obs - observations sequence for likelihood computation
%   G - railway graph
%   symbols - emissions symbols used in observations sequence generation

d = numel(initial);

alpha = 0.1;                        % step size
alpha_decay = 0.9;                  
decay_step = 2 * numel(initial);    % multiply alpha by alpha_decay every 
                                    % decay_step iterations

theta = initial;

setting = binornd(ones(d, 1), theta);
railway = set_switches(G, setting);
[TRANS, EMIS] = railway2hmm(railway);

[~, logpseq] = hmmdecode(obs, TRANS, EMIS, 'Symbols', symbols);

likelihood = exp(logpseq);

for i = 1:nmax
    
    k = mod(i, d) + 1;
    new_theta = theta;
%     new_theta = normrnd(theta, ones(d, 1) * alpha); % change all params
    new_theta(k) = normrnd(theta(k), alpha);        % change one param

    new_theta = max(zeros(d, 1), min(ones(d, 1), new_theta));
    
    setting = binornd(ones(d, 1), theta);
    railway = set_switches(G, setting);
    [TRANS, EMIS] = railway2hmm(railway);
    
    [~, logpseq] = hmmdecode(obs, TRANS, EMIS, 'Symbols', symbols);
    
    new_likelihood = exp(logpseq);
    
    acceptance_prob = max(1, new_likelihood / likelihood);
    accept = rand() < acceptance_prob;
    
    if accept
        theta = new_theta;
        likelihood = new_likelihood;
    end
    
%     if mod(i, decay_step) == 0
%         alpha = alpha * alpha_decay;
%     end
    
end
