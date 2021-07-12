function [cMat] = SmoothWithGaussianKernel(Mat,khalfsize,Sigma)

[XCor, YCor] = meshgrid(-khalfsize:khalfsize);
GaussK = normpdf(XCor,0,Sigma).*normpdf(YCor,0,Sigma);
cMat = conv2(Mat,GaussK,'same');
