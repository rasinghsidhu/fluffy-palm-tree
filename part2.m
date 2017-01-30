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
global targetPos targetQuat avgRoll avgPitch avgYaw obstacles link_length;
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
    
    [pos,frame,pts] = fk(symbolic, link_length);
    diffVec = pos - targetPos;
    df1 = gradient(diffVec(1),symbolic(:));
    df2 = gradient(diffVec(2),symbolic(:))  ;
    df3 = gradient(diffVec(3),symbolic(:));
    df4 = gradient(rotquatdist(frame(1:3,1:3),targetQuat),symbolic(:));
    %d2f1 = hessian(diffVec(1),symbolic(:));
    %d2f2 = hessian(diffVec(2),symbolic(:));
    %d2f3 = hessian(diffVec(3),symbolic(:));
    %d2f4 = hessian(rotquatdist(frame(1:3,1:3),targetQuat),symbolic(:));
    
    df1 = matlabFunction(df1, 'Vars', {symbolic});
    df2 = matlabFunction(df2, 'Vars', {symbolic});
    df3 = matlabFunction(df3, 'Vars', {symbolic});
    df4 = matlabFunction(df4, 'Vars', {symbolic});
    %d2f1 = matlabFunction(d2f1, 'Vars', {symbolic});
    %d2f2 = matlabFunction(d2f2, 'Vars', {symbolic});
    %d2f3 = matlabFunction(d2f3, 'Vars', {symbolic});
    %d2f4 = matlabFunction(d2f4, 'Vars', {symbolic});
    
    initDraw(obstacles);
    options = optimoptions('fmincon', 'SpecifyConstraintGradient', true);
    [params,fval,exitflag,output] = fmincon(@criterion, params,[],[],[],[],lb,ub,@constraint2, options);
    r = params(:,1);
    p = params(:,2);
    y = params(:,3);
    
    function [ineq, eq, dineq, deq] = constraint2(param)
        [ineq,eq] = constraints(param);
        dineq = [];
        %d2ineq = [];
        deq = [df1(param)'; df2(param)'; df3(param)'; df4(param)';]';
        %        deq = [df1(param)'; df2(param)'; df3(param)'; df4(param)';]';
        %d2eq = [d2f1(param); d2f2(param); d2f3(param); d2f4(param);];
    end

    sympref('HeavisideAtOrigin',oldHeavisideParam);
end