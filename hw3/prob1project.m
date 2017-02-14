syms y1(t) y2(t)
eqns = [diff(y1,t)==-5*y1+3*y2, diff(y2,t)==100*y1-301*y2];
conds = [y1(0)==52.29,y2(0)==83.82];
[y1(t), y2(t)] = dsolve(eqns,conds);


%{

figure
hold on
plot(tt,y1(tt),'r-');
plot(tt,y2(tt),'b-');
hold off

nVal = 5;
initY0=[52.29;83.82];
initY1=[y1(hValue);y2(hValue)];

yValues = doProb1scheme(initY0,initY1,hValue,nVal);
figure
hold on
plot(tt,yValues(1,1:nVal),'r--');
plot(tt,yValues(2,1:nVal),'b--');
hold off
%}

%h of 0.01 made at least one large error 
hValue = 0.01;
init=1;
numN = 10;
yTrue = zeros(2,numN);
yTrue(:,1)=[52.29;83.82];

yLocalEst = zeros(2,numN);

for jj = 1:numN
    yTrue(:,jj)=[y1(hValue*jj);y2(hValue*jj)];
end
yLocalEst(:,1:2)=yTrue(:,1:2);

for ii = 1:numN-2
   curYvals = doProb1scheme(yTrue(:,ii),yTrue(:,(ii+1)),hValue,1); 
   yLocalEst(:,ii+2)=curYvals(:,3);
end

tt=0:hValue:hValue*(numN-1);

figure
hold on
plot(tt,yTrue(1,:),'r-');
plot(tt,yTrue(2,:),'b-');
plot(tt,yLocalEst(1,:),'k--');
plot(tt,yLocalEst(2,:),'g--');
legend('y1 true','y2 true','y1 local est','y2 local est')
hold off

yDiffs = abs(yTrue-yLocalEst)