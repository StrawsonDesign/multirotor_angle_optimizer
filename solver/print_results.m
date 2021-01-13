%% print the vectors and max forces for a given p
function print_results(p)
    [weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation] = parameters();
    
    [tuv_x, tuv_y, tuv_z] = p_to_components(p);
    x_components = tuv_x'
    y_components = tuv_y'
    F = get_force_matrix(p)
    [M, u_min, u_max, f_min, f_max, t_loss, hover_u] = get_mixing_matrix(F)
    
    O=objective(p);
    
    eff = get_hover_eff(p);

    % draw basic layout
    plot_layout(p)
    
    %plot results on figure
    f_max(3)=0; % zero out f_max to make printout cleaner
    s_1 = sprintf('J: %5.1f', O);
    s_2 = sprintf(['p: ' mat2str(p,3)]);
    s_3 = sprintf(['fmax: ' mat2str(f_max,3) ' N,Nm']);
    s_4 = sprintf(['fmin: ' mat2str(f_min,3) ' N,Nm']);
    s_5 = sprintf(['rotation: '  mat2str(rotation')]);
    s_6 = sprintf(['radius: ' mat2str(radius') ' (m)']);
    s_7 = sprintf('Vertical Thrust Effectiveness: %0.1f%%', eff*100);
    s_8 = sprintf('Hover Throttle: %0.3f', hover_u);
    s_9 = sprintf(['Positive Weighting: ' mat2str(weight_plus)]);
    s_10 = sprintf(['Negative Weighting: ' mat2str(weight_minus)]);
    
    t=text(zeros(1,10), linspace(0.14,-0.14,10),{s_1,s_2,s_3,s_4,s_5,s_6,s_7,s_8,s_9,s_10});
    set(t,'HorizontalAlignment', 'center');
    set(t,'FontSize', 18);
    set(t,'BackgroundColor', 'white');
end