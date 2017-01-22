function [ l ] = likelihood( theta, G, obs, symbols )
%LIKELIHOOD Likelihood of multivariate model with parameters theta for
%switch setting generation given railway graph and observations sequence.
%   Samples switches setting from theta and computes probability of
%   generating observation sequence for all generated railways and then
%   averages the results.

d = numel(theta);

nmax = 22;

loglikelihood = zeros(1, nmax);

for i = 1:nmax

    setting = binornd(ones(d, 1), theta);
    railway = set_switches(G, setting);
    [TRANS, EMIS] = railway2hmm(railway);

    [~, logpseq] = hmmdecode(obs, TRANS, EMIS, 'Symbols', symbols);
    
    loglikelihood(i) = logpseq;

end

% discard highest and lowest samples
loglikelihood = sort(loglikelihood);
loglikelihood = loglikelihood(1:end - 1);

% average
l = exp(mean(loglikelihood));
