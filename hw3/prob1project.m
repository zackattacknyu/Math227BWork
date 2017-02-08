syms y1(t) y2(t)
eqns = [diff(y1,t)==-5*y1+3*y2, diff(y2,t)==100*y1-301*y2];
conds = [y1(0)==52.29,y2(0)==83.82];
[y1(t), y2(t)] = dsolve(eqns,conds);

%%
tt = 0:0.01:1;
figure
hold on
plot(tt,y1(tt),'r-');
plot(tt,y2(tt),'b-');
hold off
%%

hValue = 0.01;
nVal = 99;
initY0=[52.29;83.82];
initY1=[y1(hValue);y2(hValue)];

yValues = doProb1scheme(initY0,initY1,hValue,nVal);

figure
hold on
plot(tt,yValues(1,:),'r--');
plot(tt,yValues(2,:),'b--');
hold off