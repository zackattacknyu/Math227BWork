aa = 0; bb = 20; testInterval = 1e-5; hExps = 1:9;
testX = aa:testInterval:bb; 

functions = cell(1,2);
functions{1} = @(x) 2*sin(x) + 3*sin(2*(x-1)) + ...
    sin(3*(x-2)) + x.^2/10;
functions{2} = @(x) exp(-.2*(x-5).^2) + 3*exp(-.4*(x-10).^2) +...
    2*exp(-.5*(x-15).^2) + x/5;

methods = {'not-a-knot','periodic'}; errorH = zeros(length(hExps),2,2);

for hi = hExps;
    hh = 2^(-hi); xx = aa:hh:bb;
    for i = 1:2
       for j = 1:2
          curPoly = csape(xx,functions{i}(xx),methods{j});       
          fxVals = functions{i}(testX); cxVals = fnval(curPoly,testX);
          errorH(hi,i,j) = max(abs(fxVals-cxVals));
       end
    end 
end

pVals = zeros(length(hExps)-1,2,2);
for k = 1:(length(hExps)-1)
    for i = 1:2 
        for j = 1:2
            errorHval = errorH(k,i,j); errorHOver2Val = errorH(k+1,i,j);
            logPval = ( log(errorHval) - log(errorHOver2Val) )/log(2);
            pVals(k,i,j) = exp(logPval);
        end
    end
end

hDispVals = (-hExps(1:end-1));
figure; hold on
for i = 1:2
    for j = 1:2
        subplot(2,2,2*(j-1)+i); plot(hDispVals,pVals(:,i,j));
        title(strcat('Function',num2str(i),', Cond:',methods{j}));
        ylabel('p Value'); xlabel('log_2(h)');
    end
end
hold off