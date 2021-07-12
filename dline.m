function[] = dline(lincolors)

hold on
if nargin < 1
    lincolors = [0 0 0];
end
xLimits = xlim;
yLimits = ylim;

[yvals] = horzvec(yLimits);
[xvals] = horzvec(xLimits);

minAll = nanmin([yvals xvals]);
maxAll = nanmax([yvals xvals]);

plot([minAll maxAll], [minAll maxAll],'color',lincolors)
ylim(yLimits)
xlim(xLimits)

end

function[horzVec] = horzvec(vec)

if sum(size(vec) == 1) < 1
    error('Wrong Input', 'Error: input is not a vector')
else
    if size(vec,2) < size(vec,1)
        horzVec = vec';
    else
        horzVec = vec;
    end
end
end
