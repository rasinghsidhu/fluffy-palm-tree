    function drawOrientation(handle, pt, quat)
        pureVec = [0 1 0 0];
        rotVec = quatmult(quat,quatmult(pureVec, quatinv(quat)));
        endpt = pt + rotVec(2:4)';%quat(2:4)./norm(quat(2:4));
        set(handle, 'XData', [pt(1) endpt(1)], 'YData', [pt(2) endpt(2)], 'ZData', [pt(3) endpt(3)]);
    end