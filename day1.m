%precision of machine
% defined as smallest # such that 1 + epsilon > 1
% if we do epsilon>0, then smaller numbers are possible
%       due to the fact that less digits are required
for i = 5:100
    epsilon = 2^(-i);
    cond1 = (epsilon > 0);
    cond2 = (1+epsilon>1);
    fprintf('i: %d, cond1: %d, cond2: %d\n',i,cond1,cond2);
end
%%


%does the quadratic formula badly

a = 2;
b= -200000000; 
c = 4; 

x1A = (-b+sqrt(b^2-4*a*c))/(2*a);
x1B = (4*a*c)/(2*a*(-b-sqrt(b^2-4*a*c)));
absError = abs(x1A-x1B)
relError = absError/abs(x1A)