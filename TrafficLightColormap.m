function [RGB] = TrafficLightColormap(proportion,saturation,lightness)
% convert a value between 0 and 1 into a color between green and red
% through ornage and yellow
if nargin < 2
    saturation = 1;
end
if nargin < 3
    lightness = 1;
end
hue = ((proportion * (120 - 0)) + 0) ./ 360;
HSL = [hue saturation lightness];
RGB = hsv2rgb(HSL);
end