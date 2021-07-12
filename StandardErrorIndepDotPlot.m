function [HandeBars] = StandardErrorIndepDotPlot(x,y,Col,MrkTyp,MarkerSz)
    
if nargin < 2
    y = x;
    x = size(y,2);
end

if nargin < 3
    Col = [.3 .3 1];
end

if nargin < 4
    MrkTyp = 1;
end


if nargin < 5
    MarkerSz = 5;
end



if (numel(y) == 1) & (numel(x) == 1)
    yMean = y;
    HandeBars = plot(x,yMean,'color',Col);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
elseif (sum(size(y) == 1) > 0) & (length(y) == length(x))
    yMean = y;
    HandeBars = plot(x,yMean,'color',Col);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
else
    
    yMean = nanmean(y);
    yStd = nanstd(y);
    
    ySE = yStd/(sqrt(sum(~isnan(y(:,1)))));
    HandeBars = plot(x,yMean,'marker',MrkTyp,'markerfacecolor',Col,'markeredgecolor',Col,'markersize',MarkerSz,'linestyle','none');
    hold on
    %errorbar(x,yMean, ySE,'.','color','k','markerfacecolor',Col,'markeredgecolor',Col)
    errorbar(x,yMean, ySE,'.','color','k','markerfacecolor','k','markeredgecolor','k')
    %pH = arrayfun(@(x) allchild(x),HandeBars);
    %set(pH,'FaceAlpha',Alpha);
    % set(gca,'xticklabel', XLabels)
end

% line([x x], [yMean-ySE yMean+ySE])

end



