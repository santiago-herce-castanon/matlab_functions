function [HandeBars] = ProportionBarPlot(x,y,Col,Alpha)
    
if nargin < 2
    y = x;
    x = size(y,2);
end

if nargin < 3
    Col = [.3 .3 1];
end

if nargin < 4
    Alpha = .9;
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
    
    yN = sum(~isnan(y(:,1)));
    yMean = nanmean(y);
    yCI_95 = yMean-[(binoinv(0.025,yN,yMean)); (binoinv(0.975,yN,yMean))]./yN;
    %yStd = nanstd(y);
    
    %ySE = yStd/(sqrt(sum(~isnan(y(:,1)))));
    
    HandeBars = bar(x,yMean,'facecolor',Col);
    %pH = arrayfun(@(x) allchild(x),HandeBars);
    set(HandeBars,'FaceAlpha',Alpha);
    hold on
    % set(gca,'xticklabel', XLabels)
    errorbar(x,yMean, yCI_95(1,:),yCI_95(2,:),'.','color','k')
end
box off
% line([x x], [yMean-ySE yMean+ySE])

end



