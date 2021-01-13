%% James Strawson 2015
%% This uses the fminsearch matlab function to find the rotor layout
%% that minimizes the multirotor performance objective function
%% define in objective.m


clear all
close all
clc

%% basic settings
iterations = 10000; % recommend 1000 for quick search, 10,000 for thorough
rand_mode = 'w'; % can be w for wide or n for narrow, defines the search space of p


%% local variables
degree=5;
solutions = zeros(iterations,degree);
failures = zeros(iterations,1);
O_mins = zeros(iterations,1);
[weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation] = parameters();
 
%% Main itteration loop
parfor i = 1:iterations
    %run('parameters');
    fprintf('i: %d  ', i)
    p0 = get_random_p(degree, rand_mode);
    [p, O, exitflag] = fminsearch(@objective, p0);
    if exitflag == 0
        failures(i)=1;
    end
    
    %log data
    solutions(i,:) = p;
    O_mins(i) = O;

     %fprintf('O_min: %f  ', O_min)
     fprintf('O_i: %f \n', O);    
end

%% search for global minimum
O_min_global = 0;
p_min_global = zeros(degree,1);
num_fails = 0;
for i = 1:iterations
    if O_mins(i) < O_min_global
        p_min_global = solutions(i,:);
        O_min_global = O_mins(i);
    end
    if(failures(i)) 
        num_fails=num_fails+1;
    end
end

%% check for repeated occurances of minimum
repeats = -1;
for i = 1:iterations
    if close_enough(solutions(i,:), p_min_global, 0.002)==1
        repeats = repeats +1;
    end  
end
fprintf('repeats: %d\n',repeats);
fprintf('failures: %d\n',num_fails);



%% Print the fruits of our cpu's labour
print_results(p_min_global);

%% print local angles for modular hex
print_local_mount_angles(p_min_global)





% %% compare against old values
% p=[-0.1679 -.1138 .1013 0.2379 -0.1447];
%  [tuv_x, tuv_y, tuv_z] = vec_to_components(p);
% F = get_force_matrix(tuv_x, tuv_y, tuv_z);
% M = get_mixing_matrix(F);
% disp('old values');
% f = get_max_forces(F, M)
