 %parameter region as found in Problem 1 that produces two bistable
 %  solutions
alpha1=3.997191e+00;
alpha2=1.400523e+01;
alphaD=7.010486e+00;
beta1=1.525344e+00;
beta2=1.421442e+01;
betaD=8.005675e+00;
AA=6.205432e+00;
BB=4.418025e+00;
NN=3;

%F = @(x,y) alpha1 + (alpha2-alpha1)*y^NN/(AA^NN+y^NN) - alphaD*x;
%G = @(x,y) beta1 + (beta2-beta1)*x^NN/(BB^NN+x^NN) - betaD*y;
%stablePts = [0.5702 -4.0795;0.1939 -5.6756];

F = @(x,y) 2*y^2/(1+y^2) - 1;
G = @(x,y) x^2/(1+x^2);
stablePts = [0 0;-1 1];

func = @(t,ww) [F(ww(1),ww(2));G(ww(1),ww(2))];


N1 = 400;
startT=1; endT=40; h=(endT-startT)/N1;
[xvals,yvals]=meshgrid([-8:0.5:4],[-8:0.5:4]);
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
    axis([-8 4 -8 4]);
end
plot(stablePts(1,:),stablePts(2,:),'ro','LineWidth',4);
hold off
