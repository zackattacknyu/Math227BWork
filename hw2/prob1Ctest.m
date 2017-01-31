f1 = @(x1,x2) sin(x1) + cos(x2);
f2 = @(x1,x2) exp(x1)+sin(x2);

Df1x1 = @(x1,x2) cos(x1); Df1x2 = @(x1,x2) -sin(x2);
Df2x1 = @(x1,x2) exp(x1); Df2x2 = @(x1,x2) cos(x2);

Mvalue1 = doQuadConvergeTest(f1,f2,...
    Df1x1,Df1x2,Df2x1,Df2x2)


f1A = @(x1,x2) cos(x1) + sin(x2);
f2A = @(x1,x2) exp(x1)+cos(x2);

Df1x1A = @(x1,x2) -sin(x1); Df1x2A = @(x1,x2) cos(x2);
Df2x1A = @(x1,x2) exp(x1); Df2x2A = @(x1,x2) -sin(x2);

Mvalue2 = doQuadConvergeTest(f1A,f2A,...
    Df1x1A,Df1x2A,Df2x1A,Df2x2A)
