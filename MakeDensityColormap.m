function [CMap2] = MakeDensityColormap(HighCol)
%%
if nargin < 1
    HighCol = [.1 .1 .9];
end
CMap = colormap;
CMap2 = ones(size(CMap));
%sz1 = ceil(size(CMap,1)./2);
sz1 = ceil(size(CMap,1));
Wht1 = ones(sz1,1).*((1:sz1)'-1)./(sz1-1);
CMap2 = (CMap2.*flipud(Wht1) + HighCol.*(Wht1));
if nargout < 1
    colormap(CMap2);
end
end