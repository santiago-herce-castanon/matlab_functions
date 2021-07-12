function[H] = hline(yvals,lincolors)

hold on
if nargin < 2
    lincolors = [0 0 0];
end
xLimits = xlim;
[yvals] = horzvec(yvals);
if size(yvals,2) < 2
    H = plot(xLimits, ones(1,2)*yvals,'color',lincolors);
else
    H = line([ones(length(yvals),1)*xLimits(1)...
         ones(length(yvals),1)*xLimits(2)]', [yvals; yvals],'color',[lincolors]);
    
end

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
