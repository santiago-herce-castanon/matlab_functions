function [h] = StandardErrorAreaPlotFedSE(x,y1,y2,Col,alphaVal)
  
if nargin < 4
    Col = [.3 .3 1];
end

if nargin < 5
    alphaVal = .7;
end

yMean = y1;

ySE = y2;


yHigh = yMean+ySE;
yLow = yMean-ySE;

h = fill([x(:); flipud(x(:))], [yLow(:) ; flipud(yHigh(:))],Col,'edgecolor',Col,'facealpha',alphaVal);
% line([x'  x']', [yLow' yHigh']', 'color', Col,'linewidth',2)
hold on
hp = plot(x,yMean,'color',Col/2,'linewidth',2);
set(gca,'LineWidth',2);
box off

