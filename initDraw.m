
    function initDraw(obstacles)
       global armHandle targetQuatHandle gripperQuatHandle;

       armHandle = plot3(0,0,0, '.-', 'LineWidth', 4, 'MarkerSize', 6) ;
       hold on;
       axis equal;
       xlim([-7 7]);
       ylim([-7 7]);
       zlim([-7 7]);
       targetQuatHandle = line(0,0,0);
       gripperQuatHandle = line(0,0,0);
       
       [sx,sy,sz] = sphere(8);
       for i = 1:size(obstacles,1)
           x = obstacles(i,1);
           y = obstacles(i,2);
           z = obstacles(i,3);
           r = obstacles(i,4);
           plot3(sx*r+x,sy*r+y,sz*r+z);
       end
       hold off;
    end