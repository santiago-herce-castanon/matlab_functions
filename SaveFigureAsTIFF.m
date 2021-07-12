function [] = SaveFigureAsTIFF(Figure,Format)
if nargin<1
    Figure = gcf;
end
if nargin<2
    Format = 'tiff';
end
switch Format 
    case 'tiff'
        BackColor = 'w';
end
axesHandles = get(gcf,'children');
% AllYTicks   = get(axesHandles,'ytick');
% if numel(axesHandles) == 1
%    YTicks  = AllYTicks;
%    set(axesHandles,'ytick',[YTicks(1) YTicks(end)],'tickdir','out','color','k')
% else
%    for iAx = 1:numel(AllYTicks)
%        YTicks  = AllYTicks{iAx};
%         set(axesHandles(iAx),'ytick',[YTicks(1) YTicks(end)],'tickdir','out','color','k')
%    end
% end
OutrSz          = Figure.Position;
set(gcf,'paperunits','centimeters','papersize',[OutrSz(3),OutrSz(4)],'paperposition',[0,0,OutrSz(3),OutrSz(4)],'color',BackColor)
FName           = get(gcf,'Name');
s               = hgexport('factorystyle');
s.Background    = BackColor;
s.Units         = 'centimeters';
s.Width         = OutrSz(3);
s.Height        = OutrSz(4);
s.Format        = Format;
s.Resolution    = 600;
CD = cd;
try
    cd('Figures')
    hgexport(gcf,FName,s);
    display(['Figure :' FName ' printed succesfully!'])
catch
    warning(['Error while trying to print figure: ' FName])
end
cd(CD)
close
end