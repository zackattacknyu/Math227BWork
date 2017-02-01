F = @(x,y) 2*y^2/(1+y^2) - 1;
G = @(x,y) x^2/(1+x^2);
stablePts = [0 0;-1 1];
N1 = 800;
startT=1; endT=200; h=(endT-startT)/N1;
[xvals,yvals]=meshgrid(-2:0.1:2,-2:0.1:2);

func = @(t,ww) [F(ww(1),ww(2));G(ww(1),ww(2))];
wInits = [xvals(:)';yvals(:)'];
numInit = size(wInits,2);
wTrajectories = cell(1,numInit);
for jj = 1:numInit
    w0 = wInits(:,jj);
    wPts = getRungeKuttaTraj( func,w0,startT,NN,h );
    wTrajectories{jj} = wPts;
end

figure
hold on
for jj = 1:numInit
    wPts = wTrajectories{jj};
    plot(wPts(1,:),wPts(2,:),'Color',rand(1,3))
    axis([-2 2 -2 2]);
end
plot(stablePts(1,:),stablePts(2,:),'ro','LineWidth',4);
hold off
