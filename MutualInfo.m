function [MutInfo] = MutualInfo(VectorA, VectorB,InfoNormalizada)
if nargin <3
    InfoNormalizada = 0;
end
MutInfo = 0;


MatrizVecs = [VectorA VectorB];

StatesA = unique(VectorA);
StatesB = unique(VectorB);
StatesMatriz = unique(MatrizVecs, 'rows');

ProbStatesA = zeros(length(StatesA),1);
for i = 1: length(StatesA)
    FrecAi = sum(VectorA == StatesA(i));
    ProbStatesA(i) = FrecAi/length(VectorA);
end

ProbStatesB = zeros(length(StatesB),1);
for i = 1: length(StatesB)
    FrecBi = sum(VectorB == StatesB(i));
    ProbStatesB(i) = FrecBi/length(VectorB);
end

ProbStatesM = zeros(length(StatesMatriz),1);
for i = 1: length(StatesMatriz)
    FrecMi = sum(MatrizVecs(:,1) == StatesMatriz(i,1) & MatrizVecs(:,2) == StatesMatriz(i,2));
    ProbStatesM(i) = FrecMi/ length(MatrizVecs);
    
    MicroA = ProbStatesA(StatesA == StatesMatriz(i,1));
    MicroB = ProbStatesB(StatesB == StatesMatriz(i,2));
    
    MicroAtimesB = MicroA * MicroB;
    
    if MicroAtimesB == 0
        InfoParcial = 0;
    elseif ProbStatesM(i) == 0
        InfoParcial = 0;
    else
        InfoParcial = ProbStatesM(i)* log2(ProbStatesM(i)/(MicroAtimesB));
    end
    MutInfo = MutInfo + InfoParcial;
end

if InfoNormalizada == 1
    MaxInfo = log2(length(StatesB));
    MutInfo = MutInfo/MaxInfo;
end