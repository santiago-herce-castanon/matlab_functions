function [H1, H2] = ScatterHist1D(X,ColZ,BWidthProp,DrawLine)
if nargin < 2
    ColZ = [.1 .1 .9];
end
if nargin < 3
    BWidthProp = .05;
end
if nargin < 4
    DrawLine = 1;
end
X = X(:);

BandWidth = range(X).*BWidthProp;
[f0,xi0] = ksdensity(X,'Bandwidth',BandWidth);
[jitX0] = abs(MakeSemiGaussianJitter(X,BandWidth)-1);
hold on
if DrawLine
    H1 = plot(xi0,f0,'-','color',ColZ,'linewidth',2);
else
    H1 = [];
end
H2 = plot(X,jitX0,'.','color',ColZ);
box off

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

%{
function [jitX] = MakeSemiGaussianJitterOLD(X,BandWidth)

num_cols = size(X,2);
jitX     = zeros(size(X));
for i_col = 1:num_cols
    %jitX(:,i_col) = .3.*(rand(size(jitX,1),1)-.5).*GetSemiPercentile(X(:,i_col)) + i_col;
    jitX(:,i_col) = (rand(size(jitX,1),1)).*GetSemiDensity(X(:,i_col)) + i_col;
    
end

end
%}
