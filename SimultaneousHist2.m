function [Hp] = SimultaneousHist2(X,Colz,Nbins,Alpha)

if nargin < 2
    Colz = [.2 .2 .9];
end

if nargin < 3
    Nbins = 100;
end

if nargin < 4
    Alpha = 0.7;
end

minX = min(X(:));
maxX = max(X(:));
rangeX = range(X(:));
Edges = minX:(rangeX/Nbins):maxX;


X = X(:)';

PlotX = 1:(Nbins+1);


CurrX = X;
N = histc(CurrX,Edges);
EdgMat = repmat(Edges,[4 1]);
EdgMat = EdgMat + repmat(((Edges(2)-Edges(1))).*[-(1/3) -(1/3) (1/3) (1/3)]',1,numel(Edges));
NMat = repmat(N,[4 1]); NMat([1 4],:) = 0;
Hp = patch(EdgMat(:),NMat(:),Colz);
set(Hp,'facealpha',Alpha)
hold on,



%MinMax = [Edges(1) Edges(end)];
%MinMax = (round((MinMax).*ceil(1/rangeX))./ceil(1/rangeX));
%set(gca,'xtick',[PlotX(1) PlotX(end)],'xticklabel',MinMax)
xlim([-inf inf])
ylim([-inf inf])
set(gca, 'box','off','tickdir','out')
    

