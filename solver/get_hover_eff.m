function eff = get_hover_eff(p)

[weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation] = parameters();
[tuv_x, tuv_y, tuv_z] = p_to_components(p);

F=get_force_matrix(p);
M=get_mixing_matrix(F);

Mz=M(:,3);
Fz=F(:,3);


eff=tuv_z'*Mz/6;

end

