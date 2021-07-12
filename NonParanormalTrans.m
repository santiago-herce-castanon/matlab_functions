function [x] = NonParanormalTrans(x)
% Conducting the nonparanormal (npn) transformation via shrunkun ECDF....
% from HUGE package in R, Authors:
% Tuo Zhao, Han Liu, Kathryn Roeder, John Lafferty, and Larry Wasserman 
% Maintainers: Tuo Zhao<tzhao5@jhu.edu>
x = tiedrank(x);
x = x/(numel(x)+1);
x = norminv(x,0,1);
end