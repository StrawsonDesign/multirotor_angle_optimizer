%% print out all figures for the paper
close all

%% main solution
p = [-0.1726    0.2329    0.3906    0.0307   -0.1945];
print_results(p);
title('Optimum Solution Angles & Performance')



%% cyphy
p = get_cyphy_p();
print_results(p);
title('CyPhy Lvl1 Angles & Performance')

% use other parameters for these
%% 1m under
p = [0.1830   -0.0690   -0.1181    0.1158    0.1842];
print_results(p);
title('Optimum Solution With CM 1m Under Rotors')

%% 1m over
p = [-0.0655   -0.1866   -0.1176   -0.1117    0.0757];
print_results(p);
title('Optimum Solution With CM 1m Above Rotors')






%% isomer solution
p = [    0.2176   -0.1951   -0.3907    0.0305    0.2328];
print_results(p);
title('Isomer of Original Solution')

