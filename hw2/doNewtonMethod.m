function [ curXvec2,solFound ,xvValues2] = doNewtonMethod( f1,f2,...
    Df1x1,Df1x2,Df2x1,Df2x2,xv0 )
%DONEWTONMETHOD Given two functions and their partials, 
%               this does Newton's Method
%Input:
%	f1 - function 1 handle
%	f2 - function 2 handle
%   Df1x1 - handle for partial deriv of func 1 with respect to x1
%   Df1x2 - handle for partial deriv of func 1 with respect to x2
%   Df2x1 - handle for partial deriv of func 2 with respect to x1
%   Df2x2 - handle for partial deriv of func 2 with respect to x2
%	xv0 - initial point to start the search
%
%I took some ideas from this page: 
%   https://en.wikipedia.org/wiki/Newton's_method

%anonymous function for the Jacobian matrix
Jacob = @(x1,x2) [Df1x1(x1,x2) Df1x2(x1,x2);...
    Df2x1(x1,x2) Df2x2(x1,x2)];

%max number of iterations to do
numIter = 50;

%min determinant of Jacobian allowed
epsilon = 1e-1;

%margin before deciding that solution has converged
tolerance = 1e-8;


xvValues2 = xv0; %array to store all x_v points
curXvec2 = xv0; %current x_v point
solFound=false; %whether or not loop has converged
for i = 1:numIter
   
   %calculate current f_i and current Jacobian
   curX1A = curXvec2(1);
   curX2A = curXvec2(2);
   fxv2 = [f1(curX1A,curX2A);f2(curX1A,curX2A)];
   curJacob2 = Jacob(curX1A,curX2A);
   
   %if Jacobian is near singular, then no solution 
   %	can be found
   if(abs(det(curJacob2))<epsilon)
       solFound=false;
      break; 
   end
   
   %calculate x_{i+1} using x_{i+1} = x_i + Jacob^-1 f_i
   deltaX = linsolve(curJacob2,-fxv2);
   curXvec2 = curXvec2 + deltaX;
   
   %add x_{i+1} to the array of x vectors
   xvValues2 = [xvValues2 curXvec2];
   
   %if difference is small enough, then solution has converged
   if(norm(deltaX)<tolerance*norm(curXvec2))
       solFound=true;
       break;
   end
   
end

end

