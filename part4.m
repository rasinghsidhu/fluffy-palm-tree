function [r,p,y] = part4( target, ll, min_roll, max_roll, min_pitch, max_pitch, min_yaw, max_yaw, o )
    global targetPos targetQuat avgRoll avgPitch avgYaw obstacles link_length;
    link_length = ll;
    obstacles = o;
    params = randn(size(link_length,2),3);%zeros(size(link_length,2),3);
    targetPos = target(1:3);
    targetQuat = target(4:7);
    targetQuat = targetQuat./norm(targetQuat);
    initDraw(obstacles);
    lb = [min_roll; min_pitch; min_yaw]';
    ub = [max_roll; max_pitch; max_yaw]';
    avgRoll = (min_roll + max_roll)/2;
    avgPitch = (min_pitch + max_pitch)/2;
    avgYaw = (min_yaw + max_yaw)/2;
    
    opts = optimoptions(@fmincon);
    prob = createOptimProblem('fmincon','objective', @criterion, ...
        'x0', params, 'lb', lb, 'ub', ub, 'nonlcon', @constraints, ...
        'options', opts);
    ms = MultiStart('Display', 'iter', 'UseParallel', false);
    [x,f] = run(ms,prob,8);
    
    
    r = params(:,1);
    p = params(:,2);
    y = params(:,3);
    
    
end