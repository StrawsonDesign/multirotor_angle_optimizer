function p = get_cyphy_p()

p1x = -sin(20.78 * 2 * pi / 360);
p1y = (21.73/216.33);
p2x = sin(16.23 * 2 * pi / 360);
p2y = -54.9/217;
p3x = sin(5 * 2 * pi / 360);
p3y = -75.3/217;


p=[p1x p1y p2x p2y p3x p3y];
end
