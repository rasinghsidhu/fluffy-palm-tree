function score = cmaes_crit(paramVec)
    global link_length avgJointLims obstacles targetPos targetQuat;
    global cmae_disp_it;
    
       param = reshape(paramVec,numel(paramVec)/3,3);
       [pos,frame,pts] = fk(param, link_length);
    if(cmae_disp_it > 1000)
       cmae_disp_it = 0;
       drawArm(param, link_length);
    end
    cmae_disp_it = cmae_disp_it + 1;
       bounds_prox = sum(abs(paramVec-avgJointLims));
       
       dist = 0;
       for i = 1:size(obstacles,1)
          obstacle = obstacles(i,:);
          dist = dist + sum(obstacle_dist(pts, obstacle(1:3)').^-1)./size(link_length,2);
       end
       
       diff = pos - targetPos;
       score = dist * 1 + bounds_prox * 1 + norm(diff) * 5 + rotquatdist(frame(1:3,1:3), targetQuat) * 5; 
    end