function [bX, bY, mbX] = GetPsychometricPointsQuantiles(X,Y,nB)
bX = quantile(X,linspace(0,1,nB+1));
llC = [ bX(1:end-1) ];
hlC = [ bX(2:end)   ];
bX  = bX(1:end-1);
bY  = nan(1,nB);
mbX = nan(1,nB);
for j = 1:nB
    indBin = ((X) >= llC(j)) & ((X) < hlC(j));
    bY(j) = nanmean(Y(indBin));
    mbX(j) = nanmean(X(indBin));
end
end
