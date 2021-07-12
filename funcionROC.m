function [ROC, Significancia] = funcionROC(SetDatosA, SetDatosB, NumPerm)
% Esta funci?n entrega un valor que indica qu? tan distintas son las
% distribuciones de dos sets de datos, la significancia obtenida depende
% de la probabilidad de que esos mismos datos acomodados al azar en dos
% sets puedan obtener un mejor resultado de ROC.
% Las variables de entrada son los sets de datos y el n?mero de
% permutaciones para conocer la significancia.
% Los valores de salida son el de la ROC y el de su significancia
%  Version 2.0
%Ejemplo:
%[x ,y] = funcionROC2([1 1 1 1 1 1 0 1 0], [0 0 0 0 0 0 1 0],1000)

NumDatosA = numel(SetDatosA);
NumDatosB = numel(SetDatosB);
if isempty(NumPerm) == 1
    NumPerm = 1000;
end
TamSetA = size(SetDatosA);
TamSetB = size(SetDatosB);

if TamSetA(1) < TamSetA(2)
    SetDatosA = SetDatosA';
end

if TamSetB(1) < TamSetB(2)
    SetDatosB = SetDatosB';
end
ROC = zeros(NumDatosA,1);
for i = 1: NumDatosA
    Iguales = length(find(SetDatosB == SetDatosA(i)));
    Menores = length(find(SetDatosB <  SetDatosA(i)));
    ProbAMayorB = ((Iguales/2) + Menores)/NumDatosB;
    ROC (i) = ProbAMayorB;
end
ROC = mean(ROC);

DatosTot = [SetDatosA; SetDatosB];
NumDatosTot = numel(DatosTot);

CasosMejores = 0;
DatoROC = abs(ROC -.5);


for j = 1 : NumPerm
    OrdenDatos = randperm(NumDatosTot);
    OrdenSetA = OrdenDatos(1:NumDatosA);
    OrdenSetB = OrdenDatos(NumDatosA+1:end);
    SetDatosA = DatosTot(OrdenSetA);
    SetDatosB = DatosTot(OrdenSetB);
    ROCPerm = 0;
    for i = 1: NumDatosA
        Iguales = length(find(SetDatosB == SetDatosA(i)));
        Menores = length(find(SetDatosB <  SetDatosA(i)));
        ROCPerm = ROCPerm + (Iguales*.5 + Menores)/NumDatosB;
    end
    
    ROCPerm = ROCPerm/NumDatosA;
    ROCP = abs(ROCPerm - .5);
    if ROCP >= DatoROC
        CasosMejores = CasosMejores +1;
    end
end
Significancia = CasosMejores / NumPerm;
