
    function initDraw(obstacles)
       global armHandle targetQuatHandle gripperQuatHandle;
       clf;
       hold on;
       armHandle = initArmHandle('b');
       axis equal;
       xlim([-7 7]);
       ylim([-7 7]);
       zlim([-7 7]);
       targetQuatHandle = line(0,0,0,'Color','m');
       gripperQuatHandle = line(0,0,0,'Color', 'g');
       
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