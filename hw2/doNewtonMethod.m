function [ curXvec2,solFound ] = doNewtonMethod( f1,f2,Df1x1,Df1x2,Df2x1,Df2x2,xv0 )
%DONEWTONMETHOD Summary of this function goes here
%   
%
%Similar to code on this wikipedia page:
%   https://en.wikipedia.org/wiki/Newton's_method

Jacob = @(x1,x2) [Df1x1(x1,x2) Df1x2(x1,x2);...
    Df2x1(x1,x2) Df2x2(x1,x2)];

numIter = 50;
epsilon = 1e-4;
tolerance = 1e-8;
%xvValues2 = zeros(2,numIter);

curXvec2 = xv0;
solFound=false;
for i = 1:numIter
   
   curX1A = curXvec2(1);
   curX2A = curXvec2(2);
   fxv2 = [f1(curX1A,curX2A);f2(curX1A,curX2A)];
   curJacob2 = Jacob(curX1A,curX2A);
   
   if(abs(det(curJacob2))<epsilon)
       solFound=false;
      break; 
   end
   
   deltaX = linsolve(curJacob2,-fxv2);
   nextX2 = curXvec2 + deltaX;
   curXvec2 = nextX2;
   
   if(norm(deltaX)<tolerance*norm(curXvec2))
       solFound=true;
       break;
   end
   
end

end

