function [HandeBars] = StandardErrorBarPlot(x,y,Col,Alpha, Width, DoLines)
    
if (nargin < 2) | (isempty(y))
    y = x;
    x = size(y,2);
end

if (nargin < 3) | (isempty(Col))
    Col = [.3 .3 1];
end

if (nargin < 4) | (isempty(Alpha))
    Alpha = 1;
end

if (nargin < 5) | (isempty(Width))
    Width = .8;
end

if (nargin < 6) | (isempty(DoLines))
    DoLines = 1;
end

if (numel(y) == 1) & (numel(x) == 1)
    yMean = y;
    HandeBars = bar(x,yMean,'facecolor',Col);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
elseif (sum(size(y) == 1) > 0) & (length(y) == length(x))
    yMean = y;
    HandeBars = bar(x,yMean,'facecolor',Col);
    pH = arrayfun(@(x) allchild(x),HandeBars);
    set(pH,'FaceAlpha',Alpha);
    hold on
else
    
    yMean = nanmean(y);
    yStd = nanstd(y);
    
    ySE = yStd/(sqrt(sum(~isnan(y(:,1)))));
    
    if DoLines
        HandeBars = bar(x,yMean,Width,'facecolor',Col,'EdgeColor',[0 0 0]);
    else
        HandeBars = bar(x,yMean,Width,'facecolor',Col,'EdgeColor',Col);
    end
    %pH = arrayfun(@(x) allchild(x),HandeBars);
    %set(HandeBars,'FaceAlpha',Alpha);
    hold on
    % set(gca,'xticklabel', XLabels)
    errorbar(x,yMean, ySE,'.','color','k')
end
 box off
% line([x x], [yMean-ySE yMean+ySE])

end



