function [ wVals ] = getRungeKuttaTraj( func,w0,startT,NN,h )
%GETRUNGEKUTTATRAJ Summary of this function goes here
%   Detailed explanation goes here

tCurrent = startT;
wCurrent = w0;
wVals = zeros(2,NN+1);
wVals(:,1)=wCurrent;
for i = 1:NN
    
    nextW=calcNextW( func,tCurrent,wCurrent,h );
    
    tCurrent = tCurrent + h;
    
    wVals(:,i+1)=nextW;
    wCurrent=nextW;
    
end

end


function [ nextW ] = calcNextW( func,tCurrent,wCurrent,h )
%CALCNEXTW Summary of this function goes here
%   Detailed explanation goes here

k1 = func(tCurrent,wCurrent).*h;
k2 = func(tCurrent + (2/3)*h,wCurrent+k1.*(2/3)).*h;
nextW = wCurrent + k1.*(1/4) + k2.*(3/4);
end