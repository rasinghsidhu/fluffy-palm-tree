    function [ineq_violation, eq_violation] = constraints(param)
       global obstacles link_length;
       [pos,frame,pts] = fk(param, link_length);
       eq_violation = [];
       ineq_violation = [];
       for i = 1:size(obstacles,1)
          obstacle = obstacles(i,:);
          d = min(obstacle_dist(pts, obstacle(1:3)'));
          ineq_violation(i) = obstacle(4)-d;
       end
    end