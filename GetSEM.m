function [xSEM] = GetSEM(X)
xStd = nanstd(X,1);
xSEM = xStd/(sqrt(sum(~isnan(X(:,1)))-1));
end