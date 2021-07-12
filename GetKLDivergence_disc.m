function [Dpq] = GetKLDivergence_disc(P,Q,dim)
% Compute the Kullback-Leibler divergence between two discreet probability
% distributions, P and Q. This is a directed measure, so P will be used as
% the reference: Dkl(P||Q) = SUMxP(x)log(P(x)/Q(x))
% define a dimension over which to compute the KLdivergence. This is always
% needed and it is useful when P and Q are not vectors for matrices of
% concatenated independent vectors
%is_not_ok = (Q==0);
is_not_ok = (Q==0)|(P==0);
log_ratio = log(P./Q);
log_ratio(is_not_ok) = 0;
Dpq = sum(P.*log_ratio,dim);
end