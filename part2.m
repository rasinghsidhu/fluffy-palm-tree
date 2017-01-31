function [r, p, y] = part2( target, ll, min_roll, max_roll, min_pitch, max_pitch, min_yaw, max_yaw, o )
%% Function that uses analytic gradients to do optimization for inverse kinematics in a snake robot

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

% Your code goes here.
global targetPos targetQuat avgRoll avgPitch avgYaw obstacles link_length armHandle;
    link_length = ll;
    obstacles = o;
    params = randn(size(link_length,2),3);%zeros(size(link_length,2),3);
    oldHeavisideParam = sympref('HeavisideAtOrigin',1);
    targetPos = target(1:3);
    targetQuat = target(4:7);
    targetQuat = targetQuat./norm(targetQuat);
    lb = [min_roll; min_pitch; min_yaw]';
    ub = [max_roll; max_pitch; max_yaw]';
    avgRoll = (min_roll + max_roll)/2;
    avgPitch = (min_pitch + max_pitch)/2;
    avgYaw = (min_yaw + max_yaw)/2;
    
    symbolic = sym('p', size(params));
    
    crit = criterion(symbolic);
    dcrit = gradient(crit, symbolic(:));
    %d2crit = hessian(crit, symbolic(:));
    
    crit = matlabFunction(crit, 'Vars', {symbolic});
    dcrit = matlabFunction(dcrit, 'Vars', {symbolic});
    %d2crit = matlabFunction(d2crit, 'Vars', {symbolic});
    
    function [s,g] = criterion2(param)
       s = crit(param);
       g = dcrit(param);
       %h = d2crit(param);
       drawArm(param, link_length, armHandle);
    end
    
    initDraw(obstacles);
    options = optimoptions('fmincon', 'SpecifyObjectiveGradient', true);
    [params,fval,exitflag,output] = fmincon(@criterion2, params,[],[],[],[],lb,ub,@constraints, options);
    r = params(:,1);
    p = params(:,2);
    y = params(:,3);

    sympref('HeavisideAtOrigin',oldHeavisideParam);
end