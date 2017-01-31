function [r,p,y] = testScript()
   obs_packin = .8;
   obs_density = .5;
   nlinks = 3;
   numObstacles = 50;
   links = ones(1,nlinks);
   bounds = sum(links);
   pos = (rand(1,3)-.5);
   pos = pos./norm(pos);
   pos = pos.*rand(1,1).*bounds;
   
   q = rand(1,4);
   q = q./norm(q);
   l = ones(1,nlinks)*-pi;
   u = ones(1,nlinks)*pi;
   obs_radius = 2*(obs_density*bounds^3*(1/numObstacles)*(3/pi/4))^(1/3);    
   while 1
       obspos = rand(numObstacles,3);
       obspos = (obspos-.5).*2*bounds*obs_packin;
       obsradii = rand(numObstacles,1).*obs_radius;
       obsradiiSq = obsradii.*obsradii;
       tooCloseToStart = (sum(obspos.^2,2)-obsradiiSq) < 0;
       tooCloseToGoal = (sum((obspos - repmat(pos,numObstacles,1)).^2,2)-obsradiiSq) < 0;
       if(not(tooCloseToStart | tooCloseToGoal))
           break;
       end
   end
   
   obstacles = [obspos obsradii];
   
   
   %for i = 1:size(obstacles,1)
   % while(norm(obstacles(i,1:3))
   %end
   [r,p,y] = part2([pos q]',links,l,u,l,u,l,u,obstacles) 
end