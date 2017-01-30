function rot = quat2rot(q)
    qw = q(1);
    qx = q(2);
    qy = q(3);
    qz = q(4);
    rot = [1-2*qy*qy-2*qz*qz 2*qx*qy-2*qz*qw 2*qx*qz+2*qy*qw; ...
        2*qx*qy+2*qz*qw 1-2*qx*qx-2*qz*qz 2*qy*qz-2*qx*qw; ...
        2*qx*qz-2*qy*qw 2*qy*qz+2*qx*qw 1-2*qx*qx-2*qy*qy];
end