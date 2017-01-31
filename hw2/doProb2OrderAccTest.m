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

