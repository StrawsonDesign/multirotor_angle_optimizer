function  print_local_mount_angles(p)
% load in physical parameters
[weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation]=parameters();

[tuv_x, tuv_y, tuv_z] = p_to_components(p);

fprintf('\nUnit vector coordinates for individual beam mounts\n\n');
fprintf('First number is the distance inwards along the beam\n');
fprintf('Positive indicating lean in toward center hub.\n');
fprintf('Second number is the distance perpendicular to the beam\n');
fprintf('positive indicating an anticlockwise twist from top view.\n');
fprintf('\n');

% for each rotor
for i=1:6
    a = -angle(i); % angle to rotate back to right side rotor
    R=[cos(a), -sin(a); %rotation matrix of that angle
       sin(a), cos(a)];
    vg = [tuv_y(i); tuv_x(i)]; % global angle vector
    vl = R*vg; % angle vector in local coordinate
    
    fprintf('#%d: in: %6.3f   perp: %6.3f\n', i, -vl(1), vl(2));
end


%% now in terms of rotational angle inwards and around
fprintf('\n\nRotational coordinates for individual beam mounts\n\n');
fprintf('First number is the angle inwards along the beam\n');
fprintf('Positive indicating lean in toward center hub.\n');
fprintf('Second number is the twist around the beam, positive\n');
fprintf('indicating an anticlockwise twist looking at the end of beam\n');
fprintf('\n');
for i=1:6
    a = -angle(i); % angle to rotate back to right side rotor
    R=[cos(a), -sin(a); %rotation matrix of that angle
       sin(a), cos(a)];
    vg = [tuv_y(i); tuv_x(i)]; % global angle vector
    vl = R*vg; % angle vector in local coordinate
    
    in_deg = asin(-vl(1)) * (360/(2*pi));
    twist_deg = atan(vl(2)/tuv_z(i)) * (360/(2*pi));
    
    fprintf('#%d: in_deg: %6.3f   twist_deg: %6.3f\n', i, in_deg, twist_deg);
end
    
fprintf('\n');

end