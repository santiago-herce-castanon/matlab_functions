function [Handles_all] = PlotCorrelationWithKernel(X,ColZ,BndWdth,VarNames)
nvars = size(X,2);
if istable(X)
    if nargin < 4
        VarNames = X.Properties.VariableNames;
    end
    X = table2array(X);
else
    if nargin < 4
        for i = 1:nvars
            VarNames{i} = ['var ' num2str(i)];
        end
    end
end
if nargin < 2
    ColZ = [.1 .1 .9];
end
if nargin < 3
    BndWdth = 0.05;
end
nj = nvars;
nk = nvars;
H_kernel_all = nan(nj,nk);

for j = 1:nj
    jX = X(:,j);
    for k = 1:nk
        Hsb = subplot(nj,nj,nvars*(j-1)+k);
        kY = X(:,k);
        if nvars == 2
            
        else
            % for the diagonal subplots
            if j == k
                VertViolinPlot(1,jX,ones(size(jX)),[0.3 0.3 0.9],.3);
                set(gca,'xtick','')
                rangX = range(jX);
                ylim([min(jX)-0.05.*rangX max(jX)+0.05.*rangX])

            end
            
            % for the below diagonal subplots
            if j > k
                PlotScatterDensity(jX,kY,BndWdth,ColZ);
            end
            
            % for the above diagonal subplots
            if j < k
                [rho pval] = corr(jX,kY,'type','spearman');
                Hi = imagesc(rho);
                CMap2 = MakeFranceColormap;
                colormap(Hsb,CMap2)
                caxis([-1 1])
                set(gca,'ydir','normal')
                text(.6,1.25,['rho = ' num2str(rho,'%.2f')])
                text(.6,.75,['p = ' num2str(pval,'%.3f')])
                axis off
            end
            
            if k == 1
                ylabel(VarNames{j})
            end
            if j == nvars
                xlabel(VarNames{k})
            end
            
        end
        
        
    end
    
end
    
end
