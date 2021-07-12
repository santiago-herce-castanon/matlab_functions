function [zX] = ZTransformX(X)

if (size(X,1) == 1)
    if (size(X,2) == 1)
        error('X cannot be a scalar')
    else
        X = X(:);
        zX = (X-nanmean(X))./nanstd(X);
    end
else
    if size(X,1) < size(X,1)
        warning('remember X is transformed column wise')
    end
    meanX = repmat(nanmean(X),[size(X,1) 1]);
    stdX  = repmat(nanstd(X) ,[size(X,1) 1]);
    zX = (X-meanX)./stdX;
end