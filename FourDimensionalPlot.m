function [hSlice] = FourDimensionalPlot(ThreeDMat,XValsLab,YValsLab,ZValsLab,labelX,labelY,labelZ)

if nargin < 7
    labelZ = 'Z';
end
if nargin < 6
    labelY = 'Y';
end
if nargin < 5
    labelX = 'X';
end
ZVals = 1:size(ThreeDMat,3);
XVals = 1:size(ThreeDMat,1);
YVals = 1:size(ThreeDMat,2);

MaxMat = nanmedian(ThreeDMat(:));
MinMat = nanmin(ThreeDMat(:));

hSlice = slice(ThreeDMat,XVals,YVals,ZVals);
set(hSlice,'EdgeColor','none','FaceColor', ...
    'interp','FaceAlpha','interp')
alpha('color')

alphamap('rampdown')
alphamap('decrease',.0095)
colormap hot
caxis([MinMat MaxMat])

set(gca,'xtick',1:numel(XValsLab),'xticklabel',XValsLab,'ytick',1:numel(YValsLab),'yticklabel',YValsLab,'ztick',1:numel(ZValsLab),'zticklabel',ZValsLab)
xlabel(labelX)
ylabel(labelY)
zlabel(labelZ)

view([40,45,50])