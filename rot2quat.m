    function q = rot2quat(rot)
       rot = rot';
       t = trace(rot);
       maxdiag = max(diag(rot));
       if(t > 0)
           r = sqrt(1+t);
           s = .5/r;
           w = .5*r;
           x = (rot(8) - rot(6)) * s;
           y = (rot(3) - rot(7)) * s;
           z = (rot(4) - rot(2)) * s;
       elseif(rot(1) == maxdiag)
           r = sqrt(1 + 2 * maxdiag - t);
           s = .5 / r;
           w = (rot(8) - rot(6)) * s;
           x = .5*r;
           y = (rot(2) + rot(4)) * s;
           z = (rot(7) + rot(3)) * s;
       elseif(rot(5) == maxdiag)
           r = sqrt(1 + 2 * maxdiag - t);
           s = .5 / r;
           w = (rot(3) - rot(7)) * s;
           x = (rot(2) + rot(4)) * s;
           y = .5*r;
           z = (rot(8) + rot(6)) * s;
       elseif(rot(9) == maxdiag)
           r = sqrt(1 + 2 * maxdiag - t);
           s = .5 / r;
           w = (rot(4) - rot(2)) * s;
           x = (rot(3) + rot(7)) * s;
           y = (rot(8) + rot(6)) * s;
           z = .5*r;
       end
       q = [w x y z]';
       q = q./norm(q);
       diff = abs(rot' - quat2rot(q));
       if(sum(diff(:))>.01)
        assert(isequal(rot',quat2rot(q))==1,'quaternion conversion failed');
       end
    end