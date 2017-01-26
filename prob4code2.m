aa = 0; bb = 20; testInterval = 1e-3; hExps = 0:2;
testX = aa:testInterval:bb; 

functions = cell(1,2);
functions{1} = @(x) 2*sin(x) + 3*sin(2*(x-1)) + ...
    sin(3*(x-2)) + x.^2/10;
functions{2} = @(x) exp(-.2*(x-5).^2) + 3*exp(-.4*(x-10).^2) +...
    2*exp(-.5*(x-15).^2) + x/5;

methods = {'not-a-knot','periodic'}; 

for hi = hExps;
    hh = 2^(-hi); xx = aa:hh:bb;
    for i = 1:2
       for j = 1:2
          curPoly = csape(xx,functions{i}(xx),methods{j});       
          fxVals = functions{i}(testX); cxVals = fnval(curPoly,testX);
          figure
          hold on
          plot(testX,fxVals,'k-');
          plot(testX,cxVals,'r--');
          title(strcat('function',num2str(i),...
              ' method',num2str(j),' h=2^-',num2str(hi)));
          hold off
       end
    end 
end
