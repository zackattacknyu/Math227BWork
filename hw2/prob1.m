%webpage here:
%http://www.math.ohiou.edu/courses/math3600/lecture13.pdf

%method is as follows for multidim case
%x_1 = x_0 - inv(Df(x_0)) f(x_0)

%Part B
%tests if correct by doing calculation
%   and plugging result back into F to see
%   if f values are near zero

clear all;



%%



%should be close to zero to ensure Newton's Method is correct
maxError = max(abs(fresArray(:)))