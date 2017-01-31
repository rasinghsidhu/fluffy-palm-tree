function drawArm(params, lengths, armHandle)
        global targetQuatHandle gripperQuatHandle targetPos targetQuat;
        frame = eye(4);
        lines = zeros(size(lengths,2)+1, 3);
        for i = 1:size(params,1)
            len = lengths(i);
            yaw = params(i,3);
            pitch = params(i,2);
            roll = params(i,1);
            
            Rx = [1 0 0 0; 0 cos(roll) -sin(roll) 0; 0 sin(roll) cos(roll) 0; 0 0 0 1 ];
            Ry = [cos(pitch) 0 sin(pitch) 0; 0 1 0 0; -sin(pitch) 0 cos(pitch) 0; 0 0 0 1 ];
            Rz = [cos(yaw) -sin(yaw) 0 0; sin(yaw) cos(yaw) 0 0; 0 0 1 0; 0 0 0 1 ];
            Translate = [1 0 0 len; 0 1 0 0; 0 0 1 0; 0 0 0 1];
            T =  Rx * Ry * Rz * Translate;
            frame = frame * T;
            endPt = frame * [0 0 0 1]';
            lines(i+1, :) = endPt(1:3);
        end
        pt = [0 0 0 1]';
        pt = frame * pt;
        q = rot2quat(frame(1:3,1:3));
        set(armHandle, 'XData', lines(:,1), 'YData', lines(:,2), 'ZData', lines(:,3));
        hold on;
        drawOrientation(gripperQuatHandle, pt(1:3), q);
        drawOrientation(targetQuatHandle, targetPos, targetQuat);
        hold off;
        drawnow;
    end