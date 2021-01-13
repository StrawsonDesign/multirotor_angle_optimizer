function p = get_random_p(degree, mode)

    if(mode~='n' && mode~='w')
        disp('error, get_random_p expects mode of w for wide or n for narrow');
        p=0;
        exit
    end

    if(mode=='n')
        % p_center is a known good solution. optionally center random start
        % points near here .. 1x 1y 2x 2y 3y
          p_center =  [ -0.1726    0.2329    0.3907    0.0306   -0.1945];
          p = p_center + (rand(1,5)-0.5) * 0.2;
    else
        % uncentered random starting points
        % used almost exclusively now since multithreading speedup
        p = (rand(1,degree)-0.5) *1.8;
    end
    
    %% check for p that would give vector length > 1
    [tuv_x, tuv_y, tuv_z] =  p_to_components(p);
    % for the right 3 rotors, check if the proposed x,y components
    % are valid to form a unit vector with z
    for i = 1:3
        if imag(tuv_z(i)) ~= 0
            p = get_random_p(degree, mode);
            %disp('out of bounds')
        end   
    end
end