function [ obs, states ] = generate_obs( length, TRANS, EMIS, symbols )
%GENERATE_OBS Generates observations sequence of given length

statenames = floor(1:0.5:(size(TRANS, 1) / 2));

[obs, states] = hmmgenerate(length, TRANS, EMIS, ...
    'Symbols', symbols, 'Statenames', [0 statenames]);
