function [CumSTD, CumMean] = CumSTD2D(X,dim)

% Mean of squares minus square of means
if dim == 2
    Divs    = repmat((1:size(X,2)),[size(X,1) 1]);
else
    Divs    = repmat((1:size(X,1))',[1 size(X,2)]);
end
MusOfSq = cumsum(X.^2,dim)./Divs;
CumMean = cumsum(X,dim)./Divs;
SqOfMus = (CumMean).^2; %
CumSTD = sqrt(abs(MusOfSq-SqOfMus));

end