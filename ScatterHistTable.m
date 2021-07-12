function [] = ScatterHistTable(X,varargin)
% ScatterHistTable(X,'color','xlabels','ylabels','titles','subplotdim',
% 'FigurePos','FigureUnits','FigureColor','interpreter','FigureHandle')

if rem(numel(varargin),2) ~= 0
    error('Wrong number of inputs')
end

num_cols = size(X,2);
ColZ = [.1 .1 .9];
XLabels = X.Properties.VariableNames;
YLabels = {'Density'};
Titles = {''};
subplotdim = ones(1,2)*ceil(sqrt(num_cols));
FigurePos   = [0 0 16 16];
FigureUnits = 'centimeters'; 
FigureColor = 'w';
TextInterpreter = 'tex';
FigureHandle = 'none';
BandWidth = 0.05;
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
            case 'Bandwidth'
                BandWidth = varargin{i+1};
        end
    end
end

if numel(Titles) == 1
   Titles = repmat(Titles,[num_cols 1]); 
end
if numel(YLabels) == 1
   YLabels = repmat(YLabels,[num_cols 1]); 
end
if numel(XLabels) == 1
   XLabels = repmat(XLabels,[num_cols 1]); 
end

if strcmp(FigureHandle,'none')
    FigureHandle = figure('color',FigureColor,'units',FigureUnits,'position',FigurePos);
else
    FigureHandle.Color = FigureColor;
    FigureHandle.Units = FigureUnits;
    FigureHandle.Position = FigurePos;
    get(FigureHandle)
end
    

for i_col = 1:num_cols
    subplot(subplotdim(1),subplotdim(2),i_col)
    iX = table2array(X(:,i_col));
    try
    [f0,xi0] = ksdensity(iX,'Bandwidth',BandWidth);
    [jitX0] = abs(MakeSemiGaussianJitter(iX,BandWidth)-1);
    hold on
    H(1) = plot(xi0,f0,'-','color',ColZ,'linewidth',2);
    H(2) = plot(iX,jitX0,'.','color',ColZ);
    box off
    set(gca,'tickdir','out')
    LimY = ylim;
    LimY = unique([0 LimY]);
    set(gca,'ytick',LimY)
    catch
       warning(['Column variable "' XLabels{i_col} '" could not be displayed']) 
    end
    title(Titles{i_col})
    xlabel(XLabels{i_col},'interpreter',TextInterpreter)
    ylabel(YLabels{i_col})
end


end


function [jitX] = MakeSemiGaussianJitter(X,BandWidth)
num_cols = size(X,2);
jitX     = zeros(size(X));
for i_col = 1:num_cols
    i_X = X(:,i_col);
    if std(i_X) < 1e-3
        jitX(:,i_col) = (rand(size(jitX,1),1)).*1 + i_col;
    else
        jitX(:,i_col) = (rand(size(jitX,1),1)).*GetSemiDensity(i_X,BandWidth) + i_col;
    end
end

end

function [Y] = GetSemiDensity(Y,BandWidth)
is_ok = ~isnan(Y);
X = Y(is_ok);
[X] = ksdensity(X,X,'Bandwidth',BandWidth);
Y(is_ok) = X;
end