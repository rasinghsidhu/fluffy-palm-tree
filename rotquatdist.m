function dist = rotquatdist(rot,q2)
    q1 = rot2quat(rot);
    dist = quatdist(q1,q2);
    %u = rot * [1 0 0]';
    %v = quatmult(quat,quatmult([0 1 0 0], quatinv(quat)));
    %dist = 1 - dot(u,v(2:4));
end