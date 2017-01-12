function [ qkans ] = calcQk( xVal,kVal )
%CALCQK Summary of this function goes here
%   Detailed explanation goes here

qkans = 0;

for i = 1:kVal
    signVal = (-1)^i;
    denom = factorial(2*i+1);
    numer = xVal^(2*i-1);
    qkans = qkans + signVal*numer/denom;
end

end

