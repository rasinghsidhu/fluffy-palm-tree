function [r,p,y] = testPart1Script()
   nlinks = 10;
   q = [pi 0 0 1];
   l = ones(1,nlinks)*-pi;
   u = ones(1,nlinks)*pi;
   links = ones(1,nlinks);
   numObstacles = 50;
   obstacles = randn(numObstacles,4);
   obstacles(:,1:3) = obstacles(:,1:3).*4;
   obstacles(:,4) = abs(obstacles(:,4)).*.75;
   [r,p,y] = part1([0 0 4  q]',links,l,u,l,u,l,u,obstacles) 
end