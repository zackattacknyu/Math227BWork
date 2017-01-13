function [ exans ] = calcEx2( xVal,kVal )
%CALCEX Summary of this function goes here
%   Detailed explanation goes here


fx = sin(xVal)/xVal - 1;
numer = abs(fx-calcPkX(xVal,kVal));
%denom = abs(fx);
denom=1;
exans = numer/denom;



end

