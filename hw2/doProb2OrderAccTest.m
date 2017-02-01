function [ orderAcc ] = doProb2OrderAccTest(  )

%f_1 and f_2 for this example
func1 = @(t,y) -t*y;
func2 = @(t,y) sin(t)*y;

%initializing variables
minOrderAcc=Inf;
startT=1; endT=5; numTries = 100;

%tries different initial condition each time to test order accuracy
%   also try varying N values to get different h values each time
for tt = 1:numTries
    w0 = rand(1,1)*200+100;
    NN = floor(rand(1,1)*10+5)*10;
    
    %finds the A_1 and A_2 values to use
    Avalue1 = w0/exp(-0.5*(startT^2));
    Avalue2 = w0/exp(-cos(startT));
    
    %exact solution
    func1Actual = @(tCurrent) Avalue1*exp(-0.5*(tCurrent^2));
    func2Actual = @(tCurrent) Avalue2*exp(-cos(tCurrent));
    
    %calls runge-kutta order of accuracy calculator
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

%finds h value
h=(endT-startT)/N1;

%gets the local truncation error for h
errorH = doRungeKuttaLocal( func,...
    funcActual,startT,N1,h );

N2=N1*2;
h2=(endT-startT)/N2;

%gets the local truncation error for h/2
errorH2 = doRungeKuttaLocal( func,...
    funcActual,startT,N2,h2 );

%calculates order of accuracy using previously found errors
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

%uses the specified formulas to iterate to the next Runge-Kutta step
k1 = h*func(tCurrent,wCurrent);
k2 = h*func(tCurrent + (2/3)*h,wCurrent+(2/3)*k1);
nextW = wCurrent + (1/4)*k1 + (3/4)*k2;
end

