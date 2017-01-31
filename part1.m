function [r, p, y] = part1( target, link_lengths, min_roll, max_roll, min_pitch, max_pitch, min_yaw, max_yaw, obstacle )
%% Function that uses optimization to do inverse kinematics for a snake robot

%%Outputs 
  % [r, p, y] = roll, pitch, yaw vectors of the N joint angles
  %            (N link coordinate frames)
%%Inputs:
    % target: [x, y, z, q0, q1, q2, q3]' position and orientation of the end
    %    effector
    % link_length : Nx1 vectors of the lengths of the links
    % min_xxx, max_xxx are the vectors of the 
    %    limits on the roll, pitch, yaw of each link.
    % limits for a joint could be something like [-pi, pi]
    % obstacles: A Mx4 matrix where each row is [ x y z radius ] of a sphere
    %    obstacle. M obstacles.
    global targetPos targetQuat avgRoll avgPitch avgYaw obstacles link_length;
    global draw;
    draw = 1;
    obstacles = obstacle;
    link_length = link_lengths;
    params = randn(size(link_length,2),3);%zeros(size(link_length,2),3);
    targetPos = target(1:3);
    targetQuat = target(4:7);
    targetQuat = targetQuat./norm(targetQuat);
    lb = [min_roll; min_pitch; min_yaw]';
    ub = [max_roll; max_pitch; max_yaw]';
    avgRoll = (min_roll + max_roll)/2;
    avgPitch = (min_pitch + max_pitch)/2;
    avgYaw = (min_yaw + max_yaw)/2;
    initDraw(obstacles);
    options = optimoptions('fmincon');
    options.Algorithm = 'active-set';
    options.MaxFunctionEvaluations = 10000;
    [params,fval,exitflag,output] = fmincon(@criterion, params,[],[],[],[],lb,ub,@constraints, options)
    r = params(:,1);
    p = params(:,2);
    y = params(:,3);





    
   
    



    

end