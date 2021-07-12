function [ROC, pROC, ROC_dist] = ROCTest(Vec1, Vec2, NumPerm, SamplingType)
if nargin < 4
    SamplingType = 'NoReplacement';
end
if nargin < 3
    NumPerm = 1000;
end
VecLnth1 = numel(Vec1);

[ROC] = GetLocalROC(Vec1,Vec2);

if NumPerm > 0
    ROC_dist = nan(NumPerm,1);
    tot_vec = [Vec1(:); Vec2(:)];
    num_tot_vec = numel(tot_vec);
    
    switch SamplingType
        case 'NoReplacement'
            for iPerm = 1:NumPerm
                iOrd = randperm(num_tot_vec);
                
                iOrd1 = iOrd(1:VecLnth1);
                iOrd2 = iOrd((VecLnth1+1):end);
                iVec1 = tot_vec(iOrd1);
                iVec2 = tot_vec(iOrd2);
                [iROC] = GetLocalROC(iVec1,iVec2);
                ROC_dist(iPerm) = iROC;
            end
        case 'WithReplacement'
            for iPerm = 1:NumPerm
                iOrd = randi(num_tot_vec,num_tot_vec,1);
                
                iOrd1 = iOrd(1:VecLnth1);
                iOrd2 = iOrd((VecLnth1+1):end);
                iVec1 = tot_vec(iOrd1);
                iVec2 = tot_vec(iOrd2);
                [iROC] = GetLocalROC(iVec1,iVec2);
                ROC_dist(iPerm) = iROC;
            end
    end
end

pROC = mean(abs(ROC_dist-.5) >= abs(ROC-.5));

end

function [ROC] = GetLocalROC(Vec1,Vec2)
Vec1 = Vec1(:);
Vec2 = Vec2(:);

try
    [1;2]-[1 2];
    diffMat = Vec1-Vec2';
catch
    diffMat = repmat(Vec1,[1 numel(Vec2)]) - repmat(Vec2,[1 numel(Vec1)])';
end

ROC = mean(diffMat(:) == 0)./2 + mean(diffMat(:) > 0);
end