function[] = MultifactorBarplot(Y,multiDimX)

NumDim = size(multiDimX,2);
NumLevelsEachDim = nan(NumDim,1);
ByColumnYVals = [];
SpaceForDims = [];
XPositionEachBar = [];
XPos = 0;
for i = 1:NumDim
    whichLevelsCurrDim = unique(multiDimX(:,i));
    nLevelsCurrDim = length(whichLevelsCurrDim);
    NumLevelsEachDim(i) = nLevelsCurrDim;
    SpaceForDims = [SpaceForDims;nLevelsCurrDim+i];
    for j = 1:nLevelsCurrDim
        NanVector = nan(length(Y),1);
        currLevel = whichLevelsCurrDim(j);
        IndLevel = multiDimX(:,i) == currLevel;
        NanVector(IndLevel) = Y(IndLevel);
        ByColumnYVals = [ByColumnYVals NanVector];
        XPos = XPos+1;
        XPositionEachBar = [XPositionEachBar; XPos];
    end
    XPos = XPos +2;
end



MaxNLevels = max(NumLevelsEachDim);

NumBars = prod(NumLevelsEachDim);

