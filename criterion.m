function score = criterion(param)
    global avgRoll avgPitch avgYaw obstacles link_length;
       [pos,frame,pts] = fk(param, link_length);
       if(not(isa(param,'sym')))
        drawArm(param, link_length);
       end
       bounds_prox = sum(abs(param(:,1)-avgRoll'));
       bounds_prox = bounds_prox + sum(abs(param(:,2)-avgPitch'));
       bounds_prox = bounds_prox + sum(abs(param(:,3)-avgYaw'));
       
       dist = 0;
       for i = 1:size(obstacles,1)
          obstacle = obstacles(i,:);
          dist = dist + sum(obstacle_dist(pts, obstacle(1:3)').^-1)./size(link_length,2);
       end
       
       score = dist * .1 + bounds_prox * .8;
    end