function [CMap2] = MakeBlueRedColormap()
%%
CMap = colormap;
CMap2 = ones(size(CMap));
sz1 = size(CMap,1);
Blk1 = ones(sz1,1).*((1:sz1)'-1)./(sz1-1);
CMap2(  1:sz1,1) = Blk1;
CMap2(  1:sz1,3) = flipud(Blk1);
CMap2(:,2) = 0;
colormap(CMap2);
end