function[XOut] = ztransform(x)

X = x(:);
MeanX = mean(X);
STDX = std(X);
NewX = (X-MeanX)/STDX;
XOut = reshape(NewX,size(x));