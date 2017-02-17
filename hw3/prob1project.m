syms y1(t) y2(t)
eqns = [diff(y1,t)==-5*y1+3*y2, diff(y2,t)==100*y1-301*y2];
conds = [y1(0)==52.29,y2(0)==83.82];
[y1(t), y2(t)] = dsolve(eqns,conds);


nVal = 20;
hValue = 0.001;
tt=0:hValue:hValue*(nVal-1);

initY0=[52.29;83.82];
initY1=[y1(hValue);y2(hValue)];

yValues = doProb1scheme(initY0,initY1,hValue,nVal);
figure
hold on
plot(tt,y1(tt),'g--','LineWidth',2);
plot(tt,y2(tt),'k--','LineWidth',2);
plot(tt,yValues(1,1:nVal),'r-');
plot(tt,yValues(2,1:nVal),'b-');
xlabel('t');
legend('y1 Exact','y2 Exact','y1 Scheme Estimate','y2 Scheme Estimate')
hold off

%%
%h of 0.01 made at least one large error 

nVal = 100;

%exact y values. insert initial pt
yTrue = zeros(2,nVal);
yTrue(:,1)=[52.29;83.82];

%h values to be used
hValues = [1e-4 5e-5 0.001 0.0005 0.01 0.005 0.1 0.05 1 0.5];
errorHvals = zeros(1,length(hValues));

%loop through all h values
for hInd = 1:length(hValues)
    
    hValue = hValues(hInd);
    
    %get exact values at each time pt
    for jj = 1:nVal-1
        yTrue(:,jj+1)=[y1(hValue*jj);y2(hValue*jj)];
    end

    %sets the local estimates to the exact values at t=0 and t=h
    yLocalEst = zeros(2,nVal);
    yLocalEst(:,1:2)=yTrue(:,1:2);
    
    %uses the scheme to find the subsequent local values for t=2h,3h,...,(N-1)h
    for ii = 1:nVal-2
       curYvals = doProb1scheme(yTrue(:,ii),yTrue(:,(ii+1)),hValue,1); 
       yLocalEst(:,ii+2)=curYvals(:,3);
    end

    yDiffs = abs(yTrue-yLocalEst);
    errorHvals(hInd) = max(max(yDiffs(:,3:end)));
    
end

orderAccCals = zeros(1,5);
for i = 1:5
    orderAccCals(i) = (log(errorHvals(2*i-1))-log(errorHvals(2*i)))/log(2);
end

%prints order of accuracy values
for jj = 1:5
   fprintf(strcat(num2str(orderAccCals(jj)),'\n')) 
end

%prints h values
fprintf('h;error(h)\n');
for jj = 1:length(errorHvals)
   fprintf(strcat(num2str(hValues(jj)),';',num2str(errorHvals(jj)),'\n')) 
end

