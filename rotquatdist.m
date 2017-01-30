function dist = rotquatdist(rot,quat)
    u = rot * [1 0 0]';
    v = quatmult(quat,quatmult([0 1 0 0], quatinv(quat)));
    dist = 1 - dot(u,v(2:4));
end