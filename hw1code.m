%precision of machine
% defined as smallest # such that 1 + epsilon > 1
% problem 1
for i = 5:100
    epsilon = double(2^(-i));
    cond = (1+epsilon>1);
    if(~cond)
        break;
    end
end
precExp = i-1;
fprintf('Precision is 2^-%d\n',precExp);


%%


%problem 2

