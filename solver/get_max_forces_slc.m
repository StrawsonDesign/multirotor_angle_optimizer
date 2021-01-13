function [f] = get_max_forces_slc(F, M)
    % ignore x&y matrices
    F = F(:,1:4);

    %% optionally mix individually as a check
%     u=[1 0 0 0]';
%     mr=M*u
%     fr=mr'*F;
%     
%     u=[0 1 0 0]';
%     mp=M*u
%     fp=mp'*F;
%     
%     u=[0 0 1 0]';
%     my=M*u
%     fy=my'*F;
%     
%     u=[0 0 0 1]';
%     mt=M*u
%     ft=mt'*F;
%     
%     f=[fr(1), fp(2), fy(3), ft(4)];
    
    %% mix all at once
    %first mix a control input u with max input on all channels
    u=[1 1 1 1]';
    m=M*u;
    %now find the resulting forces
    f=m'*F;

end