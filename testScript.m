function [r,p,y] = testScript()
   obs_density = .5;
   nlinks = 10;
   numObstacles = 20;
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
   obstacles = rand(numObstacles,4);
   obstacles(:,1:3) = (obstacles(:,1:3)-.5).*2*bounds;
   obstacles(:,4) = (obstacles(:,4)).*obs_radius;
   [r,p,y] = part1([pos q]',links,l,u,l,u,l,u,obstacles) 
end