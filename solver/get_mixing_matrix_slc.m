%% returns normalized mixing matrix for given force matrix
%mixing matrix is scaled such that an input of +-1 on any
% single channel gives +- 0.5 motor input. Thus, if hex is hovering at %50
% throttle then an input of 1 would saturate at least one motor at 1 or 0
% 
% Rows of M are weights on motors
% columns correspond to control inputs in 6 axis
% u is a vertical vector of control inputs in R, P, Y, Z, X Y
% m is a vertical vector of motor inputs 1-6
% M*u = m

function M = get_mixing_matrix_slc(F)

% ignore x&y columns
F = F(:,1:4);

Finv = pinv(F);

%% solve for Roll
c = [1 0 0 0];
R = c*Finv;
R = 0.5*R/(max(abs(R)));

%% solve for Pitch
c = [0 1 0 0];
P = c*Finv;
P = 0.5*P/(max(abs(P)));

%% solve for Yaw mixing
c = [0 0 1 0];
Yaw = c*Finv;
Yaw = 0.5*Yaw/(max(abs(Yaw)));

%% solve for Upwards Thrust
% this DOES NOT get the 0.5 multiplier as we wish to allow full throttle
% for a thrust control input of 1
c = [0 0 0 1];
TZ = c*Finv;
TZ = TZ/(max(abs(TZ)));


M = [R' P' Yaw' TZ'];


end