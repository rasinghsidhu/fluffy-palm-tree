 function [pt,frame,pts] = fk(params, lengths)
        frame = eye(4);
        pts = zeros(3, size(params,1), class(params));
        for i = 1:size(params,1)
            len = lengths(i);
            yaw = params(i,3);
            pitch = params(i,2);
            roll = params(i,1);
            Rx = [1 0 0 0; 0 cos(roll) -sin(roll) 0; 0 sin(roll) cos(roll) 0; 0 0 0 1 ];
            Ry = [cos(pitch) 0 sin(pitch) 0; 0 1 0 0; -sin(pitch) 0 cos(pitch) 0; 0 0 0 1 ];
            Rz = [cos(yaw) -sin(yaw) 0 0; sin(yaw) cos(yaw) 0 0; 0 0 1 0; 0 0 0 1 ];
            Translate = [1 0 0 len; 0 1 0 0; 0 0 1 0; 0 0 0 1];
            T = Rx * Ry * Rz * Translate;
            frame =  frame * T;
            pt = frame*[0 0 0 1]';
            pts(:,i) = pt(1:3);
        end
        pt = pt(1:3);
    end