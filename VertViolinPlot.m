function [Handles_all] = VertViolinPlot(X,Y,Group,ColZ, BndWdth,DoDots)
if nargin < 2
    Y = 1;
end
if nargin < 3
    Group = ones(size(X));
end
if isempty(Group)
    Group = ones(size(X));
end
wh_gr = unique(Group(:));
num_gr = numel(wh_gr);
if nargin < 4
    ColZ = GenerateDistinguishableColors(num_gr);
end

if (nargin < 5)
    BndWdth = 0.05;
else
    if isempty(BndWdth)
        BndWdth = 0.05;
    end
end

if nargin < 6
    DoDots = 1;
end

if mean(size(Group) ~= size(X))
   if mean(size(Group) ~= size(Y))
       error(['Group should match the size of X or Y']);
   else
       resize_group = 0;
   end
else 
    resize_group = 1;
end
    
% handle sizes
if numel(X) == 1
    X = cumsum(X.*ones(size(Y)),2);
    if resize_group
        Group = Group.*ones(size(Y));
    end
else
    if size(X,1) ~= size(Y,1)
        error(['X should be a scalar,' ...
            'a vector with the same number of rows Y,'...
            ' or a matrix of the same size as Y']);
    else
        if mean(size(X) == size(Y)) ~= 1
            if size(X,2) == 1
                X = repmat(X,[1 size(Y,2)]);
                if resize_group
                    Group = repmat(Group,[1 size(Y,2)]);
                end
            else
                error(['Y should be a scalar,' ...
                    'a vector with the same number of rows X,'...
                    ' or a matrix of the same size as X']);
            end
        end
    end
end
if numel(size(Y))>2
    error(['X should be a vector or 2-d matrix']);
end

Handles_all = nan(num_gr,size(Y,2));
% loop through columns
for i_col = 1:size(Y,2)
   ind_ok   = ~isnan(Y(:,i_col));
   i_Y      = Y(ind_ok,i_col);
   tot_Y    = sum(ind_ok); 
   i_X      = X(ind_ok,i_col);
   for i_gr = 1:num_gr
       ind_iY_iGr = Group(ind_ok,i_col) == wh_gr(i_gr);
       num_indIXGR = sum(ind_iY_iGr);
       if num_indIXGR>0
           %[f1,yi1] = ksdensity(i_Y(ind_iY_iGr),'bandwidth',.01);
           [f1,yi1] = ksdensity(i_Y(ind_iY_iGr),'bandwidth',std(i_Y(ind_iY_iGr)).*BndWdth);
           yi = [yi1(1) yi1 yi1(end)];
           f = [0 f1 0];
           f = (f./max(f))./3;
           scatter_y = i_Y(ind_iY_iGr);
           %scatter_y = randn(size(i_X(ind_iX_iGr)));
           [scatter_x] = GetDensityBasedJitter(yi1,f1,scatter_y);
       else
          % PDF is zeros 
          yi = [min(i_Y(ind_iY_iGr)) max(i_Y(ind_iY_iGr))];
          f = [0 0];
          scatter_y = 0;
          scatter_x = 0;
       end
       
       %iPDF = f.*(num_indIXGR./tot_X);
       iPDF = f;
       iPDF = iPDF./(2.25.*max(iPDF));
       for_plot_Y = [yi fliplr(yi)];
       for_plot_X = X(1,i_col)+[iPDF fliplr(-iPDF)];
       
       %H = patch(for_plot_X,for_plot_Y,ColZ(i_gr,:),'facealpha',0.3);
       %H = patch(for_plot_X,for_plot_Y,ColZ(i_gr,:),'facealpha',0.3,'edgecolor','none');
       H = patch(for_plot_X,for_plot_Y,ColZ(i_gr,:),'facealpha',0.3,'edgecolor',.3.*ones(1,3));
       hold on,
       %plot(X(1)+scatter_x,scatter_y,'.k')
       if DoDots
           %plot(X(1)+scatter_x,scatter_y,'.','color',[.5 .5 .5])
           plot(X(1,i_col)+scatter_x,scatter_y,'.','color',ColZ(i_gr,:).*.5)
       end
       %alpha(0.5)
       Handles_all(i_gr,i_col) = H;
   end
end

    
end

function [jitter_x] = GetDensityBasedJitter(xi1,f,scatter_x)
is_high = scatter_x > xi1(1:end-1);
is_low  = scatter_x <= xi1(2:end);
wh_bin  = sum((2:length(f)).*(is_low&is_high),2);

i_f = max([f(wh_bin) ;  f(wh_bin-1)],[],1);
i_f = i_f./max(i_f);

jitter_x = (-.5 + rand(size(scatter_x))).*i_f';
%jitter_x = 0.1.*(randn(size(scatter_x))).*i_f;
jitter_x = jitter_x./(2.5.*max(abs(jitter_x)));
%jitter_x = jitter_x./(2.25);
end
    