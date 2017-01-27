%webpage here:
%http://www.math.ohiou.edu/courses/math3600/lecture13.pdf

%method is as follows for multidim case
%x_1 = x_0 - inv(Df(x_0)) f(x_0)
clear all;
f1 = @(x1,x2) sin(x1) + cos(x2);
f2 = @(x1,x2) exp(x1)+sin(x2);

Df1x1 = @(x1,x2) cos(x1);
Df1x2 = @(x1,x2) -sin(x2);

Df2x1 = @(x1,x2) exp(x1);
Df2x2 = @(x1,x2) cos(x2);

N = 20;
fresArray = [];

for i = 1:N
   xv0 = rand(2,1).*10 + 6;
   [xvN,toAdd]  = doNewtonMethod( f1,f2,Df1x1,Df1x2,Df2x1,Df2x2,xv0 );
   if(toAdd)
      curF = [f1(xvN(1),xvN(2));f2(xvN(1),xvN(2))];
      fresArray = [fresArray curF];
   end

end

maxError = max(abs(fresArray(:)))