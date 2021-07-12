function [bX, bZ, bY, mbX,mbZ] = GetPsychometricPointsQuantiles2D(X,Y,Z,nBx,nBz)
bX = quantile(X,linspace(0,1,nBx+1));
bZ = quantile(Z,linspace(0,1,nBz+1));
bY  = nan(nBx,nBz);
mbX = nan(nBx,nBz);
mbZ = nan(nBx,nBz);
llZ = [ bZ(1:end-1) ];
hlZ = [ bZ(2:end)   ];
llX = [ bX(1:end-1) ];
hlX = [ bX(2:end)   ];
for iZ = 1:nBz
    for iX = 1:nBx
        indBin = (((X) >= llX(iX)) & ((X) < hlX(iX)))&((Z) >= llZ(iZ)) & ((Z) < hlZ(iZ));
        bY(iX,iZ) = nanmean(Y(indBin));
        mbX(iX,iZ) = nanmean(X(indBin));
        mbZ(iX,iZ) = nanmean(Z(indBin));
    end
    
end
bX  = bX(1:end);
bZ  = bZ(1:end);

end
