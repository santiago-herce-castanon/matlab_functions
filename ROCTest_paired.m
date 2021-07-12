function [ROC, pROC, iROC_dist] = ROCTest_paired(A, B, NumPerm, SamplingType,IsPaired,Tol)
if nargin < 5
    IsPaired = 1;
end
if nargin < 6
    Tol = 1e-6;
end
if nargin < 4
    SamplingType = 'NoReplacement';
end
if nargin < 3
    NumPerm = 1000;
end

lngthA = size(A,1);
lngthB = size(B,1);

wdthA = size(A,2);
wdthB = size(B,2);

maxWdth = max([wdthA wdthB]);

if IsPaired
    if lngthA ~= lngthB
        error('inputs A and B must have the same number of rows')
    end
end
if wdthA ~= wdthB
    if (wdthA == 1) || (wdthB == 1)
        try
            %[1;2]-[1 2];
            %DoRepmat = 0;
            A = ones(lngthA,maxWdth).*A;
            B = ones(lngthB,maxWdth).*B;
        catch
            A = repmat(A,[1 maxWdth./wdthA]);
            B = repmat(B,[1 maxWdth./wdthB]);
            %DoRepmat = 1;
        end
    end
end


ROC  = nan(1,maxWdth);
pROC = nan(1,maxWdth);
iROC_dist = nan(NumPerm,maxWdth);

rng('default');

for ic = 1:maxWdth
    
    % take the ith column of A and B
    iA = A(:,ic);
    iB = B(:,ic);
    

    if IsPaired
        is_ok = ~any(isnan([iA iB]),2);
        iA = iA(is_ok);
        iB = iB(is_ok);
        % compute the difference and compare it against zero
        iAmB = iA-iB;
        [oROC] = GetLocalROC(iAmB,0,Tol);
    else
        iA = iA(~isnan([iA]));
        iB = iB(~isnan([iB]));
        [oROC] = GetLocalROC(iA,iB,Tol);
    end
    
    numA = sum(~isnan(iA),1);
    numB = sum(~isnan(iB),1);
    if any([numA numB] == 0)
        break
    end
    % store the value into the ith column of the output
    ROC(1,ic) = oROC;
    
    if NumPerm > 0
        
        if ((numel(iA) == 1)&(iA==0))
            iA = sign(rand(size(iB))-.5);
        end
        
        if ((numel(iB) == 1)&(iB==0))
            iB = sign(rand(size(iA))-.5);
        end
        
        tot_vec = [iA(:); iB(:)];
        num_tot_vec = numel(tot_vec);
        
        switch SamplingType
            case 'NoReplacement'
                for iPerm = 1:NumPerm
                    iOrd = randperm(num_tot_vec);
                    iOrd1 = iOrd(1:numA);
                    iOrd2 = iOrd((numA+1):end);
                    if IsPaired
                        [iROC] = GetLocalROC(tot_vec(iOrd1)-tot_vec(iOrd2),0,Tol);
                    else
                        [iROC] = GetLocalROC(tot_vec(iOrd1),tot_vec(iOrd2),Tol);
                    end
                    iROC_dist(iPerm,ic) = iROC;
                end
            case 'WithReplacement'
                for iPerm = 1:NumPerm
                    iOrd = randi(num_tot_vec,num_tot_vec,1);
                    iOrd1 = iOrd(1:numA);
                    iOrd2 = iOrd((numA+1):end);
                    if IsPaired
                        [iROC] = GetLocalROC(tot_vec(iOrd1)-tot_vec(iOrd2),0,Tol);
                    else
                        [iROC] = GetLocalROC(tot_vec(iOrd1),tot_vec(iOrd2),Tol);
                    end
                    iROC_dist(iPerm,ic) = iROC;
                end
        end
    end
    
end

pROC = mean(abs(iROC_dist-.5) >= abs(ROC-.5));
pROC(isnan(ROC)) = nan;
ROC(isnan(ROC)) = 0.5;
end

function [ROC] = GetLocalROC(Vec1,Vec2,Tol)
Vec1 = Vec1(:);
Vec2 = Vec2(:);

try
    [1;2]-[1 2];
    diffMat = Vec1-Vec2';
catch
    diffMat = repmat(Vec1,[1 numel(Vec2)]) - repmat(Vec2,[1 numel(Vec1)])';
end

ROC = mean(abs(diffMat(:)) < Tol)./2 + mean(diffMat(:) > Tol);
end