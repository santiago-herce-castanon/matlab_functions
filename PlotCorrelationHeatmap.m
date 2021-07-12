function [Handles_all] = PlotCorrelationHeatmap(X,VarNames)
nvars = size(X,2);
if istable(X)
    if nargin < 2
        VarNames = X.Properties.VariableNames;
    end
    X = table2array(X);
else
    if nargin < 2
        for i = 1:nvars
            VarNames{i} = ['var ' num2str(i)];
        end
    end
end

corr_type = 'Spearman'; % 'Spearman' 'Pearson'
Int_str = 'none';
T_fnt_sz = 8;

% add nargins here


% Partial correlations
%[p_rho, p_pval] = partialcorr(X,'type',corr_type);
% Titl_Str = 'Partial Correlations';

% Pairwise correlations
[p_rho, p_pval] = corr(X,'type',corr_type);
Titl_Str = ['Pairwise ' corr_type ' Correlations'];

% Plot

%figure('color','w','units','centimeters','position',[0 0 12 12])
Handles_all{1} = imagesc(p_rho);caxis([-1 1].*(max(abs(p_rho(:)))))
MakeFranceColormap;
hold on
p_05_x = (p_pval<0.05).*cumsum(ones(size(p_pval)),2);
p_05_y = (p_pval<0.05).*cumsum(ones(size(p_pval)),1);
p_01_x = (p_pval<0.01).*cumsum(ones(size(p_pval)),2);
p_01_y = (p_pval<0.01).*cumsum(ones(size(p_pval)),1);

Handles_all{2} = plot(p_05_x,p_05_y,'.k','markersize',7);
Handles_all{3} = plot(p_01_x,p_01_y,'ok','markerfacecolor','k','markersize',7);
colorbar
set(gca,'xtick',1:nvars,'xticklabel',VarNames,'XTickLabelRotation',60,'TickLabelInterpreter',Int_str,'fontsize',T_fnt_sz)
set(gca,'ytick',1:nvars,'yticklabel',VarNames,'YTickLabelRotation',0,'TickLabelInterpreter',Int_str,'fontsize',T_fnt_sz)
title(Titl_Str)
    
end


%{
FigurePos   = [0 0 16 16];
FigureUnits = 'centimeters'; 
FigureColor = 'w';
TextInterpreter = 'tex';
FigureHandle = 'none';
if nargin > 1
    for i = 1:2:numel(varargin)
        switch varargin{i}
            case 'color'
                ColZ = varargin{i+1};
            case 'xlabels'
                XLabels = varargin{i+1};
            case 'ylabels'
                YLabels = varargin{i+1};
            case 'titles'
                Titles = varargin{i+1};
            case 'subplotdim'
                subplotdim = varargin{i+1};
            case 'FigurePos'
                FigurePos = varargin{i+1};
            case 'FigureUnits'
                FigureUnits = varargin{i+1};
            case 'FigureColor'
                FigureColor = varargin{i+1};
            case 'interpreter'
                TextInterpreter = varargin{i+1};
            case 'FigureHandle'
                FigureHandle = varargin{i+1};
        end
    end
end
%}

