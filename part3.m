function [r,p,y] = part3( target, ll, min_roll, max_roll, min_pitch, max_pitch, min_yaw, max_yaw, o )
    global targetPos targetQuat avgJointLims obstacles link_length;
    global cmae_disp_it armHandle;
    cmae_disp_it = 0;
    link_length = ll;
    obstacles = o;
    params = randn(size(link_length,2)*3,1);%zeros(size(link_length,2),3);
    targetPos = target(1:3);
    targetQuat = target(4:7);
    targetQuat = targetQuat./norm(targetQuat);
    initDraw(obstacles);
    lb = [min_roll; min_pitch; min_yaw];
    ub = [max_roll; max_pitch; max_yaw];
    lb = reshape(lb, numel(lb), 1);
    ub = reshape(ub, numel(ub), 1);
    avgJointLims = (lb+ub).*.5;
    opts = cmaes;
    opts.LBounds = lb;
    opts.UBounds = ub;
    opts.MaxIter = 1000;
    [params, fmin, ceval, stopflag, out, bestever] = cmaes('cmaes_crit', params, pi/2, opts);
    params = reshape(params, numel(params)/3, 3);
    drawArm(params, link_length,armHandle);
    r = params(:,1);
    p = params(:,2);
    y = params(:,3);
    
    
end