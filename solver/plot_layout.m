%% takes p and makes a nice 3d plot.
% this is a little weird since p and equ of motion are in NED coordinates 
% but matlab plots everything in normal XYZ so here x and y are switched
% and z is inverted.
function plot_layout(p)
    
    [weight_plus,weight_minus,r,mass,thrust_max,torque_max,rp_z,angle,radius,rotation]=parameters();
    [x, y ] = get_rotor_positions( angle, radius );
    
    
    [tuv_x, tuv_y, tuv_z] = p_to_components(p);

    fig1 = figure();
    %set(fig1, 'Units', 'pixels');
    set(fig1, 'Position', [500 500 900 900]);%x,y,w,h
    
    hold on
    l=r*0.5; %scale factor for thrust vector lengths
    for i = 1:6
        % plot motor 'arm' from origin to base of vector
        % we must flip x&y because NED coordinates
        plot3([0;-y(i)],[0,x(i)],[0,-rp_z],'r')
        plot3([0;-y(i)],[0,x(i)],[-rp_z,-rp_z],'r')
        
        %plot thrust vector
        plot3([-y(i);-y(i)-tuv_y(i)*l],[x(i);x(i)+tuv_x(i)*l], [-rp_z ; -rp_z - tuv_z(i)*l],'b')

        
    end
    %plot forward pointer
    plot3([0,0],[0;r],[0,0],'r')
    
    %plot line down to center of mass
    plot3([0;0],[0,0],[0,-rp_z],'r')
    
    axis equal
    scale = 1.1*r;
    axis([-scale,scale,-scale,scale]);
    title('Optimum Solution Thrust Vectors')
    xlabel('Y-axis (meters)')
    ylabel('X-axis (meters)')
    zlabel('Z-axis (meters)')
    set(gca,'fontsize',18)
end