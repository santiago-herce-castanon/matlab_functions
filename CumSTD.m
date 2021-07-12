function [CumSTD, CumMean] = CumSTD(X)

X = X(:);
% Mean of squares minus square of means
Divs    = (1:length(X))';
MusOfSq = cumsum(X.^2)./Divs;
CumMean = cumsum(X)./Divs;
SqOfMus = (CumMean).^2; %
CumSTD = sqrt(MusOfSq-SqOfMus);

end