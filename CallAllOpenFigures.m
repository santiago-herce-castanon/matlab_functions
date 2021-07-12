function [] = CallAllOpenFigures()

Figs = get(0,'children');

FigureType = 1;
for i = 1: numel(Figs)
    figure(Figs(i))
end