%f1,f2 equations as our example
f1 = @(x1,x2) sin(x1) + cos(x2);
f2 = @(x1,x2) exp(x1)+sin(x2);

%partial derivatives for the Jacobian
Df1x1 = @(x1,x2) cos(x1);
Df1x2 = @(x1,x2) -sin(x2);

Df2x1 = @(x1,x2) exp(x1);
Df2x2 = @(x1,x2) cos(x2);

N = 20; %number of initial points to try
fresArray = []; %f values at solutions found

for i = 1:N
   xv0 = rand(2,1).*10 + 6; %generate random initial points
   
   %find solutions
   [xvN,toAdd,xvAll]  = doNewtonMethod( f1,f2,...
       Df1x1,Df1x2,Df2x1,Df2x2,xv0 );
   
   %if solution was found, compute f values at the 
   %    solution, which should be near zero
   if(toAdd)
      curF = [f1(xvN(1),xvN(2));f2(xvN(1),xvN(2))];
      fresArray = [fresArray curF];
   end
end

%should be close to zero to ensure Newton's Method
%   is correct
maxError = max(abs(fresArray(:)))