function score = criterion(param)
    global avgRoll avgPitch avgYaw link_length targetPos targetQuat armHandle;
    global draw;
       [pos,frame,pts] = fk(param, link_length);
       if(not(isa(param,'sym')) && draw)
        drawArm(param, link_length,armHandle);
       end
       bounds_prox = sum(abs(param(:,1)-avgRoll'));
       bounds_prox = bounds_prox + sum(abs(param(:,2)-avgPitch'));
       bounds_prox = bounds_prox + sum(abs(param(:,3)-avgYaw'));
       quatdiff = rotquatdist(frame(1:3,1:3), targetQuat);
       diff = pos - targetPos;
       score = norm(diff) * 20 + quatdiff*400 + bounds_prox *1;
    end