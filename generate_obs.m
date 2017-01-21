function [ obs ] = generate_obs( length, TRANS, EMIS )
%GENERATE_OBS Generates observations sequence of given length

start = 1 + round(rand(1) * length);

statenames = floor(1:0.5:(0.5 + size(TRANS, 1) / 2));
symbols ={'0L' '0R' 'L0' 'R0'};

[seq, ~] = hmmgenerate(start + length - 1, TRANS, EMIS, ...
    'Symbols', symbols, 'Statenames', statenames);

obs = strjoin(seq(start:end));
