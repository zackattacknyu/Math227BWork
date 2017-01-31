function [ localErrors ] = doRungeKutta( func,...
    funcActual,w0,startT,NN,h )
%DORUNGEKUTTA Returns the global and local trunction errors for Runge Kutta
%               Method described

wCurrent = w0;
tCurrent = startT;
localErrors = zeros(1,NN);
for i = 1:NN
    
    %current iteration of w
    nextW  = calcNextW( func,tCurrent,wCurrent,h );
    wCurrent = nextW;
    
    %calculate local error at this w
    yHere = funcActual(tCurrent);
    localNextW  = calcNextW( func,tCurrent,yHere,h );
    tCurrent = tCurrent + h;
    localNextY = funcActual(tCurrent);
    localErrors(i) = abs(localNextW-localNextY);
    
    
end

end

