function [ShadedGabor] = CreateShadedGabor(AngleDeg,GaborSamp, ShadingFactor)

DiamCircle = length(GaborSamp);
angle = (AngleDeg-90)*pi/180;

CorrectionX = sin(angle);
CorrectionY = cos(angle);

Circulo = CreateCircularAperture(DiamCircle,0);
[x,y] = meshgrid((1:DiamCircle)-(siz));

x = Circulo.*x;
y = Circulo.*y;

z = ((-x*CorrectionX) + (-y*CorrectionY));
% minZ = abs(min(z(:)));
% maxZ = max(z(:));
% z = (z + (minZ))/ (maxZ + minZ);



ShadedGabor = GaborSamp + 128*ones(301,301) + (z*ShadingFactor);


end

