function a = close_enough(p1, p2, tol)
    
    [h1,w1]=size(p1);
    for i = 1:w1
        diff=(abs(p1(i)-p2(i)));
        if diff > tol
            a=-1;
            return
        end 
    end
    a=1;
end