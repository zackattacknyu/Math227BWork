%webpage here:
%http://www.math.ohiou.edu/courses/math3600/lecture13.pdf

%method is as follows for multidim case
%x_1 = x_0 - inv(Df(x_0)) f(x_0)

f1 = @(x1,x2) sin(x1) + cos(x2);
f2 = @(x1,x2) exp(x1)+sin(x2);

Df1x1 = @(x1,x2) cos(x1);
Df1x2 = @(x1,x2) -sin(x2);

Df2x1 = @(x1,x2) exp(x1);
Df2x2 = @(x1,x2) cos(x2);

xv0 = [0;0];
Jacob = @(x1,x2) [Df1x1(x1,x2) Df1x2(x1,x2);...
    Df2x1(x1,x2) Df2x2(x1,x2)];



numIter = 20;
%xvValues = zeros(2,numIter);
xvValues2 = zeros(2,numIter);

%curXvec = xv0;
curXvec2 = xv0;
for i = 1:numIter
    %{
   curX1 = curXvec(1);
   curX2 = curXvec(2);
   fxv = [f1(curX1,curX2);f2(curX1,curX2)];
   curJacob = Jacob(curX1,curX2);
   
   nextX = curXvec - curJacob\fxv;
   xvValues(:,i) = nextX;
   curXvec = nextX;
   %}
   
   curX1A = curXvec2(1);
   curX2A = curXvec2(2);
   fxv2 = [f1(curX1A,curX2A);f2(curX1A,curX2A)];
   curJacob2 = Jacob(curX1A,curX2A);
   
   deltaX = linsolve(curJacob,-fxv);
   nextX2 = curXvec2 + deltaX;
   xvValues2(:,i) = nextX2;
   curXvec2 = nextX2;
end