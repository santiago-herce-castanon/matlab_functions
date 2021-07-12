function[] = ShowPairwiseCorr(X,XLabs,OrderX,CorrType)
n_col = size(X,2);
if nargin < 2
    XLabs = '';
end
if nargin < 3
    OrderX = 1:n_col;
end
if nargin < 4
    CorrType = 'spearman';
end

if strcmp(OrderX,'optimal')
    XDist = pdist(X','spearman');
    SqXDist = squareform(XDist);
    treecorr = linkage(XDist,'average');
    OrderX = optimalleaforder(treecorr,XDist,'criteria','group','Transformation','inverse');
end
    
    

[rhos, pval] = corr(X(:,OrderX),'type',CorrType);
imagesc(rhos)
caxis([-1 1])
colorbar
MakeFranceColormap;%colormap('jet')
set(gca,'xtick',1:n_col,'xticklabel',XLabs(OrderX),'xticklabelrotation',45)
set(gca,'ytick',1:n_col,'yticklabel',XLabs(OrderX))
hold on
p_05_x = (pval<0.05).*cumsum(ones(size(pval)),2);
p_05_y = (pval<0.05).*cumsum(ones(size(pval)),1);
p_01_x = (pval<0.01).*cumsum(ones(size(pval)),2);
p_01_y = (pval<0.01).*cumsum(ones(size(pval)),1);

plot(p_05_x,p_05_y,'.k','markersize',7)
plot(p_01_x,p_01_y,'ok','markerfacecolor','k','markersize',7)


end