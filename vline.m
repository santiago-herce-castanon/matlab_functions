function[H] = vline(xvals,lincolors)

hold on
if nargin < 2
    lincolors = [0 0 0];
end
yLimits = ylim;
[xvals] = horzvec(xvals);
if size(xvals,2) < 2
    H = plot(ones(1,2)*xvals,yLimits,'color',lincolors);
else
    H = line([xvals; xvals],[ones(1,length(xvals))*yLimits(1)...
        ; ones(1,length(xvals))*yLimits(2)],'color',[lincolors]);
    
end

end

function[horzVec] = horzvec(vec)

if sum(size(vec) == 1)== 0
    error('Wrong Input', 'Error: input is not a vector')
else
    if size(vec,2) < size(vec,1)
        horzVec = vec';
    else
        horzVec = vec;
    end
end
end
