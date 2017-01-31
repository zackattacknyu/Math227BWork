function [ maxLocError ] = doRungeKuttaLocal( func,...
    funcActual,startT,NN,h )
%DORUNGEKUTTA Returns the global and local trunction errors for Runge Kutta
%               Method described

tCurrent = startT;
localErrors = zeros(1,NN);
for i = 1:NN
    
    %calculate local error at this w
    yHere = funcActual(tCurrent);
    localNextW  = calcNextW( func,tCurrent,yHere,h );
    tCurrent = tCurrent + h;
    localNextY = funcActual(tCurrent);
    localErrors(i) = abs(localNextW-localNextY);
    
    
end

maxLocError = max(localErrors);

end

