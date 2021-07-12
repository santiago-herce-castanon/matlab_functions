function [Handles] = SimultaneousHist(X,ID,Nbins)

if nargin < 2
    ID = ones(size(X));
end

if nargin < 3
    Nbins = 100;
end

minX = min(X(:));
maxX = max(X(:));
rangeX = range(X(:));
Edges = minX:(rangeX/Nbins):maxX;

if sum(size(X) == size(ID)) ~= 2
    
    if size(X,1) == size(ID,1)
        ID = repmat(ID,[1 size(X,2)]);
    elseif size(X,2) == size(ID,2)
        ID = repmat(ID,[size(X,1) 1]);
    else
        error('myApp:argChk', 'Incongruent Dimensions')
    end
end

X = X(:)';
ID = ID(:)';

IDTypes = unique(ID);
NumIDs = numel(IDTypes);
PlotX = 1:(Nbins+1);

Colors = colormap(jet(NumIDs));

for i = 1:NumIDs
    CurrID = IDTypes(i);
    indID = ID == CurrID;
    CurrX = X(indID);
    N = histc(CurrX,Edges);
    Handle = StandardErrorBarPlot(PlotX,N,Colors(i,:),.7);
    Handles{i} = Handle;
end

MinMax = [Edges(1) Edges(end)];
MinMax = (round((MinMax).*ceil(1/rangeX))./ceil(1/rangeX));
set(gca,'xtick',[PlotX(1) PlotX(end)],'xticklabel',MinMax)
xlim([-inf inf])
ylim([-inf inf])
set(gca, 'box','off','tickdir','out')
    

