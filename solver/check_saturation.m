%% for an unscaled mixing vector for one channel, returns a new mixing
% vector which saturates rotors when ch_min and ch_max are applied.
% for symetric directions like roll, ch_min, ch_max will be =1;
% for pitch and Y thrust one of ch_min and ch_max will be one, the other
% will be <=1. mins & maxes are the limits that can be applied to each
% rotor when in hover. 

% clear all
% clc
% 
% mix = [-.7 .9 -.7 -.7 .9 -.7];
% % maxes = [0.6 0.6 0.6 0.6 0.6 0.6]
% % mins = [-0.3 -0.3 -0.3 -0.3 -0.3 -0.3]
% hover_vec = [.3 .3 .3 .3 .3 .3];


function [new_mix, u_min, u_max] = check_saturation(mix, hover_vec)

    maxes = ones(1,6) - hover_vec;
    mins = -hover_vec;

    
    % for positive control input, find the max input before saturating
    % given the current (unscaled) mix vector, we will scale that later
    [ratioU, chU] = max(mix./maxes); % check upper limits
    [ratioL, chL] = max(mix./mins);  % and lower limits

    % whichover ratio is higher will be the channel that saturates under
    % positive control input
    ratioP = max([ratioU, ratioL]);
    
    
    % for negative control input, find the max input before saturating
    % given the current (unscaled) mix vector, we will scale that later
    [ratioU, chU] = max((-mix)./maxes); % check upper limits
    [ratioL, chL] = max((-mix)./mins);  % and lower limits

    % whichover ratio is higher will be the channel that saturates under
    % positive control input
    ratioN = max([ratioU, ratioL]);
    
    
    % whichever direction (positive or negative) will saturate last is
    % what we will use to scale the mix vector. Thus, the stronger direction
    % will still saturate at 1 and the weaker direction will saturate
    % less than 1 or higher than -1.
    
    ratio = min(ratioP, ratioN);
    new_mix = mix/ratio;
    
    % these are now the min and max control inputs which will saturate in
    % either direction
    u_max = ratio / ratioP;
    u_min = -ratio / ratioN;
end


% %% test
% motorsmax = u_max * new_mix + hover_vec
% motorsmin = u_min * new_mix + hover_vec