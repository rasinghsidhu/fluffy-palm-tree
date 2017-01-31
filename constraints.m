    function [ineq_violation, eq_violation] = constraints(param)
       global obstacles link_length;
       [pos,frame,pts] = fk(param, link_length);
       eq_violation = [];
       ineq_violation = obstacle_dists(pts, obstacles);
    end