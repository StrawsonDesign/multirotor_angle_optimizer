%% print the vectors and max forces for a given p
function print_results(p,O)
    run('parameters'); %import physical parameters
    [tuv_x, tuv_y, tuv_z] = p_to_components(p);
    x_components = tuv_x'
    y_components = tuv_y'
    F = get_force_matrix(tuv_x, tuv_y, tuv_z)
    M = get_mixing_matrix_slc(F)
    f = get_max_forces_slc(F, M);
    %sum_check = tuv_y(1)+tuv_y(2)+tuv_y(3)
    hover_efficiency = f(4)/(thrust_max*6);

    % draw basic layout
    plot_layout(p)
    
    %plot results on figure
    s_o = sprintf('O: %5.3f    efficiency %5.3f', O,  hover_efficiency);
    s_p = strcat('p:  ', sprintf(' %5.3f', p));
    s_f = strcat('forces:  ', sprintf(' %5.3f', f));
    s_r = strcat('rotation:  ', sprintf(' %d', rotation));
    s_w = strcat('weights:  ', sprintf(' %d', weight));
    
    t=text([0 0 0 0 0], [.05 .025 0 -.025 -.05],{s_o s_p,s_f,s_r,s_w});
    set(t,'HorizontalAlignment', 'center');
    set(t,'FontSize', 12);
    set(t,'BackgroundColor', 'white');
end