%% returns normalized mixing matrix for given force matrix
%mixing matrix is scaled such that an input of +-1 on any
% single channel gives +- 0.5 motor input. Thus, if hex is hovering at %50
% throttle then an input of 1 would saturate at least one motor at 1 or 0
% 
% Rows of M are weights on motors
% columns correspond to control inputs in 6 axis
% u is a vertical vector of control inputs in Z thrust, Roll, Pitch, Yaw, X Y
% m is a vertical vector of motor inputs 1-6
% M*u = m

% also returns the maximum and minimum forces that can be applied in 
% all directions

function [M, u_min, u_max, f_min, f_max, t_loss, hover_u] = get_mixing_matrix(F)

[weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation] = parameters();

% for upwards thrust in -Z, u_min is obviously 1, and the minimum u
% is obviously 0 as we can either turn on all motors full or turn them off.
% for the rest, these are the minmum and maximum control inputs that can be
% given while at hover
u_min = zeros(1,6);
u_max = zeros(1,6);

% f_min corresponds to the forces created by inputs of u_min
% f_max corresponds to the forces created by inputs of u_max
% this in unintuitive for Z as a u_max of 1 creates thrust in the negative
% Z direction, therefore f_max(3) is negative and f_min(3) is 0
f_min = zeros(1,6); 
f_max = zeros(1,6);

% pseudoinverse isn't necessary unless we wish to do underconstrained
% systems such as an octocopter
Finv = inv(F);

%% First solve for hover vector u
% this must be done first to know what hover throttle is
c = [0 0 -9.81*mass 0 0 0];
hover_vec = F'\c';
u_min(3) = -1;
u_max(3) = 0;
c = [0 0 1 0 0 0];

% TZ is the column of M for thrust Z
TZ = c*Finv;
TZ = TZ/(max(abs(TZ))); % scale so max entry is -1
%
hover_u=hover_vec(1)/TZ(1);


%% solve for Roll
c = [0 0 0 1 0 0];
R = c*Finv;
[R, u_min(4), u_max(4)] = check_saturation(R, hover_vec);

%% solve for Pitch
c = [0 0 0 0 1 0];
P = c*Finv; %unscaled P mix vector
[P, u_min(5), u_max(5)] = check_saturation(P, hover_vec);

%% solve for Yaw mixing
c = [0 0 0 0 0 1];
Yaw = c*Finv;
[Yaw, u_min(6), u_max(6)] = check_saturation(Yaw, hover_vec);


%% solve for X (forward) Thrust
c = [1 0 0 0 0 0];
TX = c*Finv;
[TX, u_min(1), u_max(1)] = check_saturation(TX, hover_vec);

%% solve for Y (right) Thrust
c = [0 1 0 0 0 0];
TY = c*Finv;
[TY, u_min(2), u_max(2)] = check_saturation(TY, hover_vec);

% final mixing matrix
M = [TX' TY' TZ' R' P' Yaw'];

% output forces
f_max=(M*u_max')'*F;
f_min=(M*u_min')'*F;

 % thrust loss is the ratio of thrust no longer available due to 
% the rotors no longer being in a plane
t_loss = 1 - (f_min(3)/(-thrust_max*6));
end