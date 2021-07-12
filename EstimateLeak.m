function [Alpha tc con] = EstimateLeak(b)

g=fittype('exp((x-a1)/a2)','coeff',{'a1','a2'});
options=fitoptions(g);
x=1:length(b);
w0=[1 1];
[w,gof3,out] = fit(x',b', g, 'Startpoint', [1 1],'Robust','Off','Lower',[-inf -inf],'Upper',[inf inf],'MaxIter',2000,'TolFun',10^-10);
a=coeffvalues(w);

Alpha=exp(-1./a(2));
tc=a(2);
con=a(1);
end