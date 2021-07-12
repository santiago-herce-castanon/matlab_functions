function [sMu] = SlideMean(x,binsize)
origxsize = size(x);
if origxsize(1) > origxsize(2)
    x = x';
    xsize = size(x);
    WasTransposed = 1;
else
    xsize = origxsize;
    WasTransposed = 0;
end

xmat = zeros(xsize(1),xsize(2)+binsize);

for i = 1:binsize
    xmat(:,i:(end-(binsize+1)+i)) = xmat(:,i:(end-(binsize+1)+i)) + x;
end

sMu = xmat(:,binsize:(end-binsize))./binsize;

if WasTransposed
    sMu = sMu';
end

end