function [AllConditionsTrial, NumComb] = CounterbalanceConditions(Conditions,RoughNumTrials)
NumDim = numel(Conditions);
NumCondPerDim = [];
for i = 1:NumDim
    NumCombCurr = numel(Conditions{1,i});
    NumCondPerDim = [NumCondPerDim; NumCombCurr];
end
NumComb = prod(NumCondPerDim);
MatCases = nan(NumComb,NumDim);
for i = 1:NumDim
    NumCombCurr = numel(Conditions{1,i});
    %     Ind = (j-1)*(NumComb/NumCombCurr) + (1:NumCombCurr);
    Vec = Conditions{1,i}(:);
    Factors = [NumCondPerDim'];
    NumBreaks = NumComb/prod(Factors(1:i));
    BrSz = (NumComb/(NumBreaks*NumCombCurr));
    VecMat = repmat(Vec',[BrSz NumBreaks]);
    MatCases(:,i) = VecMat(:);
end
ActualCombTrial = Shuffle(rem((1:(ceil(RoughNumTrials/NumComb))*NumComb),NumComb))+1;%Shuffle(repmat(1:numel(AllMeans),1,ceil(NumTrials/numel(AllMeans))));
AllConditionsTrial = MatCases(ActualCombTrial,:);
end

