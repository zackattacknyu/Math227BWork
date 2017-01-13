function [ pkans ] = calcPkX( xVal,kVal )
%CALCPKX Summary of this function goes here
%   Detailed explanation goes here

pkans = 0;

for i = 1:kVal
    signVal = (-1)^i;
    denom = factorial(2*i+1);
    numer = xVal^(2*i);
    pkans = pkans + signVal*numer/denom;
end


end

