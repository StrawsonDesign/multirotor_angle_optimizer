%% p is a vector of length 5 to optimize over
%% function returns unit vector components for all 6 rotors
%% hex X   top view
%  6  1       cw ccw      X
% 5    2    ccw     cw    ^
%  4  3       cw ccw      |__> Y    Z down
function [tuv_x, tuv_y, tuv_z] = p_to_components(p)
    
    [r,c] = size(p);
    %% Components of thrust vector for right 3 rotors
    % y components are mirrored to the left props
    % sum of x components must be zero
    p1x = p(1);
    p1y = p(2);
    p2x = p(3);
    p2y = p(4);
    
    
    if c==5
    p3y = p(5);
    p3x = -(p1x+p2x);
    elseif c==6
    p3x = p(5);
    p3y = p(6);
    else
        disp('invalid length of p')
    end


    %% Normalized thrust vectors & yaw moment vector
    % mirror right rotors into vectors for all 6
    tuv_x = [ p1x p2x p3x p3x p2x p1x]';
    tuv_y = [ p1y p2y p3y -p3y -p2y -p1y]';

    % find component of thrust in z direction for unit thrust
    tuv_z = -sqrt(1-(tuv_x.^2 + tuv_y.^2));


end