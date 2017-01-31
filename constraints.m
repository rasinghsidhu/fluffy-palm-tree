    function [ineq_violation, eq_violation] = constraints(param)
       global obstacles link_length targetPos targetQuat;
       [pos,frame,pts] = fk(param, link_length);
       diff = pos - targetPos;
       eq_violation(1) = diff(1);
       eq_violation(2) = diff(2);
       eq_violation(3) = diff(3);
       eq_violation(4) = rotquatdist(frame(1:3,1:3),targetQuat);
       for i = 1:size(obstacles,1)
          obstacle = obstacles(i,:);
          d = min(obstacle_dist(pts, obstacle(1:3)'));
          ineq_violation(i) = obstacle(4)-d;
       end
    end