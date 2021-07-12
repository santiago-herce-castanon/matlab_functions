function [Or, newP] = RandPermCorrCoeff(X,Y,NumPerm)

[Or Op] = corrcoef(X,Y);
nX = numel(X);
AllRs = nan(NumPerm,1);
for iP = 1: NumPerm
    iOrder = randperm(nX);
    [r p] = corrcoef(X(iOrder),Y);
    AllRs(iP) = r(2);
end

newP = sum(abs(AllRs) >= abs(Or(2)))/NumPerm;