function [domu,se_domu,muod,se_muod] = GetDiffOfMeansAndSE(X1,X2)
if any(size(X1) ~= size(X2))
   if any(size(X1)==1 | size(X2)==1)
       X1 = ones(size(X1)).*ones(size(X2)).*X1;
       X2 = ones(size(X1)).*ones(size(X2)).*X2;
   else
       error('inputs must be of same size or have singleton dimensions')
   end
end

% mean of X1 and X2
mu_1 = nanmean(X1);
mu_2 = nanmean(X2);

% pointwise difference
diff = X1-X2;

% number of values in X1, X2 and difference
n1 = sum(~isnan(X1));
n2 = sum(~isnan(X2));
nd = sum(~isnan(diff));

% difference of mus
domu = mu_1-mu_2;
% mean of differences
muod = nanmean(diff);

% variance of X1 and X2
S_1 = nanstd(X1).^2;
S_2 = nanstd(X2).^2;

% variance of the difference of means
S_d_u = S_1 + S_2; % unweighted
S_d = ((n1.*S_1) + (n2.*S_2))./(n1+n2); % weighted by number of elements

% std of the difference of means
s_domu = sqrt(S_d);
% std of the mean of differences
s_muod = nanstd(diff);

se_domu = s_domu./sqrt(n1+n2);
se_muod = s_muod./sqrt(nd);


end