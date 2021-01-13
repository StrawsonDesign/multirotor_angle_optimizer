function [F] = get_force_matrix(p)
    % rows correspond to rotors
    % colums correspond to forces in x,y,z then moments about xyz (roll,
    % pitch,yaw)
   
    
     [tuv_x, tuv_y, tuv_z]=p_to_components(p);
    
    %global thrust_max torque_max x y rotation rp_z
    [weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation] = parameters();
    [x, y ] = get_rotor_positions( angle, radius );

    %% real max thrust vectors in Newtons
    tv_x = thrust_max.*tuv_x;  % forward
    tv_y = tuv_y .* thrust_max;  % right
    tv_z = tuv_z .* thrust_max;  % down

    % vector of moments around roll (x) axis contributed by each motor
    M_roll = y.*tv_z;
    % optionally add torque component from each motor
    M_roll = M_roll - torque_max * rotation.*tuv_x;
    % optionally add torque component due to hanging CM
    M_roll = M_roll - tv_y* rp_z;
    
    % vector of moments around pitch (y) axis contributed by each motor
    M_pitch = -x.*tv_z;
    % optionally add torque component from each motor
    M_pitch = M_pitch - torque_max * rotation.*tuv_y;
    % optionally add torque component due to hanging CM
    M_pitch = M_pitch + tv_x*rp_z;

    % Vector of max yaw torques from each rotor in N about vertical axis of uav
    % moment is cross product of rotor position and thrust vector in x&y
    M_yaw = x.*tv_y - y.*tv_x;
    % optionally add torque from motor axis
    % minus torque because reaction torque is opposite of rotations
    M_yaw = M_yaw + torque_max * rotation.*tuv_z;

    % columns of F are rotor effects in 
    % z thrust, roll, pitch, yaw, X, Y
    % F = [ tv_z, M_roll, M_pitch, M_yaw, tv_x, tv_y];
    %         x, y, z, roll, pitch, yaw
    F = [ tv_x, tv_y, tv_z, M_roll, M_pitch, M_yaw];
end