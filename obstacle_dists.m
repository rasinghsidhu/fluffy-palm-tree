    function dist = obstacle_dists(lines, obpts)
        interval = 10;
        obradii = obpts(:,4);
        obpts = obpts(:,1:3);
        scale = (0:interval-1)/interval;
        rays = lines(:,2:end) - lines(:, 1:(size(lines,2)-1));
        pts = repmat(lines(:, 1:size(lines,2)-1),interval,1);
        rays = repmat(rays,interval,1);
        scale = repmat(scale, 3, size(lines,2)-1);
        pts = reshape(pts, 3, []);
        rays = reshape(rays, 3, []);
        pts = [pts lines(:,end)];
        rays = [rays zeros(3,1)];
        scale = [scale zeros(3,1)];
        pts = pts + rays.*scale;
        tstpt = repmat(obpts', size(pts,2),1);
        tstradii = repmat(obradii', size(pts,2),1);
        tstpt = reshape(tstpt, 3, []);
        tstradii = reshape(tstradii,1,[]);
        pts = repmat(pts, 1, numel(obpts)/3);
        dist = pts-tstpt;
        dist = sum(dist.^2, 1);
        dist = tstradii.*tstradii - dist;
    end

