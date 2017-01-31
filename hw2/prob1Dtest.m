%generate random parameters
alpha1 = rand(1,1)*5+1;
alpha2 = rand(1,1)*10+6;
beta1 = rand(1,1)*5+1;
beta2 = rand(1,1)*10+6;
AA = rand(1,1)*5 + 2;
BB = rand(1,1)*4 + 3;
alphaD = rand(1,1)*7+4;
betaD = rand(1,1)*7+4;
NN = floor(rand(1,1)*4+1);

%F, G equations in our example
F = @(x,y) alpha1*AA^NN + alpha2*y^NN - alphaD*x*(AA^NN+y^NN);
G = @(x,y) beta1*BB^NN + beta2*x^NN - betaD*y*(BB^NN+x^NN);

%partial derivatives for the Jacobian
DFdx = @(x,y) -alphaD*(AA^NN + y^NN);
DFdy = @(x,y) NN*y^(NN-1)*(alpha2-alphaD*x);
DGdx = @(x,y) NN*x^(NN-1)*(beta2-betaD*y);
DGdy = @(x,y) -betaD*(BB^NN + x^NN);

N = 20; %number of initial points to try
fresArray = []; %f values at solutions found
solutionPts = []; %solution points

%we will draw random points from the 
%   square of this radius around the origin
squareRad = 40; 

%if the square distance between two points is less than this,
%   the points will be considered identical for practical purposes
squareDistTol = 1e-3;

for i = 1:N
   %generate random initial points
    xv0 = rand(2,1).*squareRad -squareRad/2; 
   
   %find solutions
   [xvN,toAdd,xvAll]  = doNewtonMethod( F,G,...
       DFdx,DFdy,DGdx,DGdy,xv0 );
   
   %if solution was found, compute f values at the 
   %    solution, which should be near zero
   if(toAdd)
      curF = [F(xvN(1),xvN(2));G(xvN(1),xvN(2))];
      fresArray = [fresArray curF];
      
      %add current xvN to solution array if it does not match one
      %     already in there
      if(size(solutionPts,2)>0)
          
          %find squared distance between current solution and 
          % already found solutions
          diffVec = solutionPts-repmat(xvN,1,size(solutionPts,2));
          minDist = min(sum(diffVec.^2)); 
          
          %if min squared distance is high enough that current
          %     solution is likely unique, add it to the array
          %     of solutions
          if(minDist > squareDistTol)
             solutionPts = [solutionPts xvN]; 
          end
      else
          
          %if no solutions have been added yet
          solutionPts =  xvN;
      end
       
   end
end
maxError = max(fresArray(:));

%show the output that was put into the .tex document
fprintf('Max Value of F,G at solutions (should be close to zero):%d\n\n',maxError);
fprintf('Here is the paramter regime\n');
fprintf('Alpha1=%d\n',alpha1);
fprintf('Alpha2=%d\n',alpha2);
fprintf('AlphaD=%d\n',alphaD);
fprintf('Beta1=%d\n',beta1);
fprintf('Beta2=%d\n',beta2);
fprintf('BetaD=%d\n',betaD);
fprintf('A=%d\n',AA);
fprintf('B=%d\n',BB);
fprintf('N=%d\n\n',NN);
fprintf('Solution Points are as follows (row 1 is x, row 2 is y):\n');
solutionPts