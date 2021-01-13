
%% these are parameters for the 5 inch monocoque model


function [weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation] = parameters()



%% cost function weights
%                x  y  z p r y
weight_plus  = [10 12  0 2 2 5];
weight_minus = [20 12 40 2 2 5];

%% hex X   top view
%  6  1       cw ccw      X
% 5    2    ccw     cw    ^
%  4  3       cw ccw      |__> Y    Z down

%radius of hexagon in m
r = .145;
mass = .90;

% max thrust of each prop in Newtons
thrust_max = 3.4;

% max torque of motor with propeller attached at full throttle
torque_max = 0.06;

% position of the rotor plane relative to center of mass
% negative means mass below rotors
rp_z = 0;

% rotation 1 = ccw prop when looking from above
angle_deg   = [ 60  0 300 240  180  120]';
radius  = [ r   r    r    r    r    r ]';
%rotation  =  [1   -1   1    -1   1    -1 ]'; %original
rotation  = [-1   1   -1    1   -1    1 ]'; %original reversed
%rotation  = [ 1    1   -1    1   -1   -1 ]'; % front 4 spinning in
%rotation  = [-1    1   1    -1   -1    1 ]'; % back 4 spinning in
%rotation  = [ 1    1   1     1    1    1 ]'; % all CCW
%rotation  = [-1   -1   -1    1   1    1 ]'; % left and right together
%rotation  = [1   1   1    -1   -1    -1 ]'; % left and right together

%radian version of angle
angle = angle_deg * 2*pi/360;


end