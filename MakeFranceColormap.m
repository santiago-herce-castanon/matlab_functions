function [CMap2] = MakeFranceColormap()
%%
CMap = colormap;
CMap2 = ones(size(CMap));
sz1 = ceil(size(CMap,1)./2);
sz2 = ceil(size(CMap,1)./2)+1;
Blk1 = ones(sz1,1).*((1:sz1)'-1)./(sz1-1);
CMap2(  1:sz1,1) = Blk1;
CMap2(  1:sz1,2) = Blk1;
CMap2(sz2:end,3) = flipud(Blk1);
CMap2(sz2:end,2) = flipud(Blk1);
if nargout < 1
    colormap(CMap2);
end
end