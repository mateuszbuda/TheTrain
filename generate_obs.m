function [ obs ] = generate_obs( length, TRANS, EMIS )
%GENERATE_OBS Generates observations sequence of given length

start = 1 + round(rand(1) * length);

statenames = floor(1:0.5:(0.5 + size(TRANS, 1) / 2));
symbols = ['L' 'R'];

[seq, ~] = hmmgenerate(start + length - 1, TRANS, EMIS, ...
    'Symbols', symbols, 'Statenames', statenames);

seq = seq(start:end);

if mod(start, 2) == 1 % odd
    
    obs = [repmat('0', [1, length]); seq];
    
else %even
    
    obs = [seq; repmat('0', [1, length])];
    
end

obs = [obs; repmat(' ', [1, length])];
obs = reshape(obs, [1, 3 * length]);
