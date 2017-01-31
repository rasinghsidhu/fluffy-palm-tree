function [r,p,y] = testPart2Script()
   nlinks = 5;
   q = [pi 0 0 1];
   l = ones(1,nlinks)*-pi;
   u = ones(1,nlinks)*pi;
   links = ones(1,nlinks);
   numObstacles = 5;
   obstacles = randn(numObstacles,4);
   obstacles(:,1:3) = obstacles(:,1:3).*1.5;
   obstacles(:,4) = abs(obstacles(:,4)).*.5;
   obstacles(obstacles < .6 & obstacles >-.6) = .6;
   [r,p,y] = part4([0 0 2  q]',links,l,u,l,u,l,u,obstacles) 
end