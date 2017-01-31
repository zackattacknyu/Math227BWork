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

