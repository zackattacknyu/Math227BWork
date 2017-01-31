function [ maxMout ] = doQuadConvergeTest( f1,f2,Df1x1,Df1x2,Df2x1,Df2x2 )
%DOQUADCONVERGETEST Does the quadratic convergence test 
%   by finding candidates for the constant M such that
%   ||x_{j+1}-x*|| <= M ||x_{j+1}-x*||^2
%
%Input:
%	f1 - function 1 handle
%	f2 - function 2 handle
%   Df1x1 - handle for partial deriv of func 1 with respect to x1
%   Df1x2 - handle for partial deriv of func 1 with respect to x2
%   Df2x1 - handle for partial deriv of func 2 with respect to x1
%   Df2x2 - handle for partial deriv of func 2 with respect to x2
%

N=20;
maxMarray = [];
for i = 1:N
    %generate random starting point
   xv0 = rand(2,1).*10 + 6;
   
   %find solution and generate intermediate points
   [xvN,toAdd,xvAll]  = doNewtonMethod( f1,f2,Df1x1,Df1x2,Df2x1,Df2x2,xv0 );
   
   %if solution found, see if convergence was quadratic
   if(toAdd)
       
       %calculates ||x_j - x*|| for each j
      diffVec=xvAll-repmat(xvN,1,size(xvAll,2));
      array = sqrt(sum(diffVec.^2,1));
      
      %calculates ||x_{j+1} - x*||/||x_j - x*||^2 for each j
      constValue = array(2:end)./(array(1:end-1).^2);
      maxM = max(constValue);
      maxMarray = [maxMarray maxM];
   end

end

maxMout = max(maxMarray);
end

