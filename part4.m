function [r,p,y] = part4( target, ll, min_roll, max_roll, min_pitch, max_pitch, min_yaw, max_yaw, o )
    global targetPos targetQuat avgRoll avgPitch avgYaw obstacles link_length;
    global draw armHandle;
    draw = 0;
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
    opts.MaxFunctionEvaluations = 5000;
    prob = createOptimProblem('fmincon','objective', @criterion, ...
        'x0', params, 'lb', lb, 'ub', ub, 'nonlcon', @constraints, ...
        'options', opts);
    ms = MultiStart('Display', 'iter', 'UseParallel', false);
    [params,f, flagg, outptg, manyminsg] = run(ms,prob,20);
    
    drawArm(params, link_length, armHandle);
    hold on;
    colors = ['b' 'r' 'g' 'm'];
    for i = 2:min([4 numel(manyminsg)])
       drawArm(manyminsg(i).X, link_length, initArmHandle(colors(i)));
    end
    hold off;
    
    
    r = params(:,1);
    p = params(:,2);
    y = params(:,3);
    
    
end