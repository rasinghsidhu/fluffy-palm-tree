function dist = rotquatdist(rot,q2)
    if(isa(rot,'sym'))
        u = rot * [1 0 0]';
        v = quatmult(q2,quatmult([0 1 0 0], quatinv(q2)));
        dist = 1 - dot(u,v(2:4));
    else
        q1 = rot2quat(rot);
        dist = quatdist(q1,q2); 
    end
end