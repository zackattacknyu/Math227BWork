function [ orderAcc ] = doProb2OrderAccTest(  )
%DOPROB2ORDERACCTEST Summary of this function goes here
%   Detailed explanation goes here

func1 = @(t,y) -t*y;
func2 = @(t,y) sin(t)*y;
minOrderAcc=Inf;
startT=1; endT=5; numTries = 100;

%tries different initial condition each time to test order accuracy
%   also try varying N values to get different h values each time
for tt = 1:numTries
    w0 = rand(1,1)*200+100;
    NN = floor(rand(1,1)*10+5)*10;
    
    Avalue1 = w0/exp(-0.5*(startT^2));
    Avalue2 = w0/exp(-cos(startT));
    
    func1Actual = @(tCurrent) Avalue1*exp(-0.5*(tCurrent^2));
    func2Actual = @(tCurrent) Avalue2*exp(-cos(tCurrent));
    
    orderAcc = getRungeKuttaOrderAccuracy( ...
        func1,func1Actual,startT,endT,NN );
    minOrderAcc = min(orderAcc,minOrderAcc);
    
    orderAcc = getRungeKuttaOrderAccuracy( ...
        func2,func2Actual,startT,endT,NN );
    minOrderAcc = min(orderAcc,minOrderAcc);
end



end

function [ orderAcc ] = getRungeKuttaOrderAccuracy( ...
    func,funcActual,startT,endT,N1 )
%GETRUNGEKUTTAORDERACCURACY Summary of this function goes here
%   Detailed explanation goes here

h=(endT-startT)/N1;
errorH = doRungeKuttaLocal( func,...
    funcActual,startT,N1,h );

N2=N1*2;
h2=(endT-startT)/N2;
errorH2 = doRungeKuttaLocal( func,...
    funcActual,startT,N2,h2 );

orderAcc = (log(errorH)-log(errorH2))/log(2);
end

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

function [ nextW ] = calcNextW( func,tCurrent,wCurrent,h )
%CALCNEXTW Summary of this function goes here
%   Detailed explanation goes here

k1 = h*func(tCurrent,wCurrent);
k2 = h*func(tCurrent + (2/3)*h,wCurrent+(2/3)*k1);
nextW = wCurrent + (1/4)*k1 + (3/4)*k2;
end

