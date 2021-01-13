function [x, y ] = get_rotor_positions( angle_rad, radius )
%GET_ROTOR_POSITIONS Summary of this function goes here
%   Detailed explanation goes here

%% rotor locations in cartesian coordinates
y = (cos(angle_rad).*radius);
x = (sin(angle_rad).*radius);



end

