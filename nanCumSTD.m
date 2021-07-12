function [CumSTD, CumMean] = nanCumSTD(X)

X = X(:);
NanX = isnan(X);
X(NanX) = 0;
Divs = cumsum([ 1; ~NanX(1:end-1)]);
% Mean of squares minus square of means
MusOfSq = cumsum(X.^2)./Divs;
CumMean = cumsum(X)./Divs;
SqOfMus = (CumMean).^2; %
CumSTD = sqrt(MusOfSq-SqOfMus);

end