
    function initDraw(obstacles)
       global armHandle targetQuatHandle gripperQuatHandle targetPos targetQuat;
       global link_length;
       bounds = sum(link_length);
       clf;
       hold on;
       armHandle = initArmHandle('b');
       axis equal;
       xlim([-bounds bounds]);
       ylim([-bounds bounds]);
       zlim([-bounds bounds]);
       targetQuatHandle = line(0,0,0,'Color','r', 'LineWidth', 3);
       gripperQuatHandle = line(0,0,0,'Color', 'g');
       drawOrientation(targetQuatHandle, targetPos, targetQuat);
       [sx,sy,sz] = sphere(16);
       for i = 1:size(obstacles,1)
           x = obstacles(i,1);
           y = obstacles(i,2);
           z = obstacles(i,3);
           r = obstacles(i,4);
           mesh(sx*r+x,sy*r+y,sz*r+z,'facecolor', 'none');
       end
       hold off;
    end