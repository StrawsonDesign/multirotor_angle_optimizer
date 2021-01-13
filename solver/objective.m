%% returns objective function evaluated with weighting
function [ O ] = objective(p)

   [weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation] = parameters();


    % evaluate resulting force matrix
    F_new = get_force_matrix(p);

    % get the scaled mixing matrix
   [M, u_min, u_max, f_min, f_max, t_loss] = get_mixing_matrix(F_new);
    

   % Asymmetric cost function
    O = f_max*weight_plus' - f_min*weight_minus';
    
   

    % optional constraints
    % if(p(3)>0)
    %     O = O + 10000;
    % end
    % if(p3y<0)
    %     O = O + 10000;
    % end

    % make negative since fminsearch tries to minimize
    O = -O;
    
    %% sanity checks
    % if thrust loss is impossible return 0
    
    if(t_loss<0)
        %disp('thrust_loss < 0')
        O = 0;
    end
    if(t_loss>0.35)
        %disp('thrust_loss > 0.35')
        O = 0;
    end
    % if available control input in all direction except z are unusually 
    % small, set objective function to 0 to indicate bad things.
    for i=1:6
        if i ~= 3
            if(f_min(i)>0.01)
                %disp('f_min > 0');
                O = 0;
            end
            if(f_max(i)<0.01)
                %disp('f_min < 0');
                O = 0;
            end
        end
    end
end

