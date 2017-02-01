function [ wVals ] = getRungeKuttaTraj( func,w0,startT,NN,h )

tCurrent = startT;
wCurrent = w0; %starting point

%stores all the w points
wVals = zeros(2,NN+1);
wVals(:,1)=wCurrent;
for i = 1:NN
    
    %calculates w_{i+1}
    nextW=calcNextW( func,tCurrent,wCurrent,h );
    tCurrent = tCurrent + h;
    
    %adds w_{i+1} to array of points
    wVals(:,i+1)=nextW;
    wCurrent=nextW;
    
end

end


function [ nextW ] = calcNextW( func,tCurrent,wCurrent,h )

%uses the specified formulas to iterate to the next Runge-Kutta step
k1 = func(tCurrent,wCurrent).*h;
k2 = func(tCurrent + (2/3)*h,wCurrent+k1.*(2/3)).*h;
nextW = wCurrent + k1.*(1/4) + k2.*(3/4);
end