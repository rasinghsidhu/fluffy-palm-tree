function score = cmaes_crit(paramVec)
    global link_length avgJointLims obstacles targetPos targetQuat;
    global cmae_disp_it armHandle;
    
       param = reshape(paramVec,numel(paramVec)/3,3);
       [pos,frame,pts] = fk(param, link_length);
    if(cmae_disp_it > 100)
       cmae_disp_it = 0;
       drawArm(param, link_length, armHandle);
    end
    cmae_disp_it = cmae_disp_it + 1;
       bounds_prox = sum(abs(paramVec-avgJointLims));
       
       dist = obstacle_dists(pts,obstacles);
       dist = sum(abs(dist(dist>0)))*50;
       quatdiff = rotquatdist(frame(1:3,1:3), targetQuat);
       diff = pos - targetPos;
       score = dist * 1 + bounds_prox * 1 + norm(diff) * 5 + quatdiff* 100; 
    end