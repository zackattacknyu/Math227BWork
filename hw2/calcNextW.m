function [ nextW ] = calcNextW( func,tCurrent,wCurrent,h )
%CALCNEXTW Summary of this function goes here
%   Detailed explanation goes here

k1 = h*func(tCurrent,wCurrent);
k2 = h*func(tCurrent + (2/3)*h,wCurrent+(2/3)*k1);
nextW = wCurrent + (1/4)*k1 + (3/4)*k2;
end

