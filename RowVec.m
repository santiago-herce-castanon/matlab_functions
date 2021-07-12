function [x] = RowVec(x)
if size(x,1)*size(x,2) > max(size(x))
    warning('Input is not a Vector')
    sound(sin(sin(0:0.01:pi*10).*((0:0.01:pi*10)*2)))
else
    if size(x,1) > size(x,2)
        x = x';
    end
end