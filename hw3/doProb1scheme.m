function [ yValues ] = doProb1scheme( initY0, initY1, hValue, nValue )
%DOPROB1SCHEME Summary of this function goes here
%   Detailed explanation goes here

yValues = zeros(2,nValue+2);

yValues(:,1)=initY0;
yValues(:,2)=initY1;

FMATRIX = [-5 3; 100 -301];

for ii = 3:nValue+2
    yNminus1 = yValues(:,ii-2);
    yN=yValues(:,ii-1);
    yN1star = yN + (hValue/2)*( (FMATRIX*yN)*3 - (FMATRIX*yNminus1) ) ;
    yN1 = yN + (hValue/2)*( (FMATRIX*yN) + (FMATRIX*yN1star) ) ;
    yValues(:,ii)=yN1;
end


end

