function [H] = SimultaneousPatch(X,Y,Colz,Alpha)
if nargin < 2
    Y = X;
    X = 1:numel(X);
end
Y = Y(:)';
X = X(:)';
if nargin < 3
    Colz = [.1 .1 .8];
end
if nargin < 4
    Alpha = .7;
end

H = fill([X fliplr(X)], [Y Y.*0],Colz,'edgecolor',Colz,'facealpha',Alpha);
hold on,
end