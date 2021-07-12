function [HandeBars] = StandardErrorLinePlotFedSE(x,y1,y2,Col)
  
if nargin < 4
    Col = [.3 .3 1];
end

yMean = y1;

ySE = y2;

HandeBars = plot(x,yMean,'color',Col,'linewidth',5);
hold on
%errorbar(x,yMean, ySE,'.','color','k','markerfacecolor',Col,'markeredgecolor',Col)
errorbar(x,yMean, ySE,'.','color','k','markerfacecolor','k','markeredgecolor','k')
box off