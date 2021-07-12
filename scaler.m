function [xout] = scaler(xin)
MaxVal = max(xin(:));
MinVal = min(xin(:));

xout = (xin-MinVal)./(MaxVal-MinVal);