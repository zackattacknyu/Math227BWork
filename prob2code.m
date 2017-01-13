xValsTest = [];
for ee = 1:15
    start = 10^(-ee);
    inc = 10^(-ee);
    endVal = 10^(-ee+1);
    addList = start:inc:endVal;
    xValsTest = [xValsTest addList];
end

for k = 1:30
    curMaxError = 0;
    for xv = xValsTest
        exVal = calcEx2(xv,k);
        if(exVal>curMaxError)
           curMaxError = exVal; 
        end
    end
    fprintf('k=%d error=%d\n',k,curMaxError);
end