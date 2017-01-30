    function dist = obstacle_dist(lines, pt)
       lineVecs = lines(:,2:end) - lines(:, 1:(size(lines,2)-1));
       dist = zeros(size(lines,2)-1,1,class(lines));
       for i = 1:(size(lines,2)-1)
        u = lineVecs(:,i);
        o = lines(:,i);
        v = pt-o;
        t = dot(u,v)/norm(u);
        dist(i) = heaviside(t - eps) * norm(v) + heaviside(norm(u)-t-eps)*norm(pt - lines(:,i+1))...
            + heaviside(-t)*heaviside(t-norm(u))*norm(cross(u,v))/norm(u);
       end
    end

