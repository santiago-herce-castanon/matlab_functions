function [Colz] = GetPseudoColormap(numCs,Col1,Col2)
Colz = nan(numCs,3);
Ws = linspace(0,1,numCs);
for i = 1:numCs
   Colz(i,:) =  Col1.*Ws(i) + Col2.*(1-Ws(i));
end
end