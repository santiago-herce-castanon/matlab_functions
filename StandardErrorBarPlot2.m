function [HandeBars] = StandardErrorBarPlot2(x,y,Col,Alpha)

if nargin < 2
    y = x;
    x = size(y,2);
end

if nargin < 3
    Col = [.3 .3 1];
end

if nargin < 4
    Alpha = 1;
end



X = repmat(x,4,1);
X = X + repmat([-(1/3) -(1/3) (1/3) (1/3)]',1,numel(x));
Y = repmat(nanmean(y,1),4,1);
Y([1 4],:) = 0;

HandeBars = area(X(:),Y(:));
set(HandeBars,'FaceColor',Col);

if size(y,1) > 1
    yMean = nanmean(y);
    yStd = nanstd(y);
    ySE = yStd/(sqrt(size(y,1)));
    hold on
    %errorbar(x,yMean, ySE,'','color','k')
    errorbar(x,yMean, ySE,'.','color','k')
end
