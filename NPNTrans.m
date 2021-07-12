function [z] = NPNTrans(x)
% Conducting the nonparanormal (npn) transformation via shrunkun ECDF....
% from HUGE package in R, Authors:
% Tuo Zhao, Han Liu, Kathryn Roeder, John Lafferty, and Larry Wasserman
% Maintainers: Tuo Zhao<tzhao5@jhu.edu>
if size(x,2)>size(x,1)
    warning('transposing input for non-paranormal transformation')
    x = x';
end
w = nanstd(x,[],1);
if numel(x) > 1
    z = tiedrank(x);
    z = z/(size(z,1)+1);
    z = norminv(z,0,1);
end
q =w==0; 
if any(q)
    warning('some variables have no variability (left unchanged)')
    z(:,q) = x(:,q);
end
end