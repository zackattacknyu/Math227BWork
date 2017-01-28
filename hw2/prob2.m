func = @(t,y) -t*y;

w0=200;

startT=1;
endT=5;
NN=40;

h=(endT-startT)/NN;

wVals = zeros(1,NN);

wCurrent = w0;
tCurrent = startT;
for i = 1:NN
    k1 = h*func(tCurrent,wCurrent);
    k2 = h*func(tCurrent + (2/3)*h,wCurrent+(2/3)*k1);
    nextW = wCurrent + (1/4)*k1 + (3/4)*k2;
    
    wCurrent = nextW;
    tCurrent = tCurrent + h;
end

Avalue = w0/exp(-0.5*(startT^2));
actualY = Avalue*exp(-0.5*(endT^2));

error = abs(wCurrent-actualY)