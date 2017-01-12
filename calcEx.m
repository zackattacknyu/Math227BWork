function [ exans ] = calcEx( xVal,kVal )
%CALCEX Summary of this function goes here
%   Detailed explanation goes here

term = calcQk(xVal,kVal)/(sin(xVal)-xVal);
exans = abs(1-term);


end

