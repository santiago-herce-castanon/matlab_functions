function [mu,ci] = GetBootstrapCI(X,alpha,nrep)
if nargin < 2
    alpha = 0.05;
end
if nargin < 3
    nrep = 1000;
end

% for reproducibility
rng('default');

%%
wh_samps = randi(size(X,1),size(X,1),size(X,2),nrep);
X_samp = nan(size(wh_samps));

for i_dim = 1:size(X,2)
    W = X(wh_samps(:,i_dim,:),i_dim);
    X_samp(:,i_dim,:) = reshape(W,size(X,1),1,nrep);
end
mu = nanmean(X);
mus = sort(nanmean(X_samp),3);
ci = [mus(:,:,ceil(nrep.*((alpha/2)))); mus(:,:,ceil(nrep.*(1-(alpha/2))))];

end