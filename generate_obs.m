function [ obs, states ] = generate_obs( length, TRANS, EMIS )
%GENERATE_OBS Generates observations sequence of given length

statenames = floor(1:0.5:(size(TRANS, 1) / 2));
symbols ={'0L' '0R' 'L0' 'R0'};

[obs, states] = hmmgenerate(length, TRANS, EMIS, ...
    'Symbols', symbols, 'Statenames', [0 statenames]);
