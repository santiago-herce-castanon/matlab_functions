function [Handles_all] = HorViolinPlot(Y,X,Group,ColZ)
if nargin < 2
    X = Y;
    Y = 1;
end
if nargin < 3
    Group = ones(size(Y));
end
if isempty(Group)
    Group = ones(size(Y));
end
wh_gr = unique(Group(:));
num_gr = numel(wh_gr);
if nargin < 4
    ColZ = GenerateDistinguishableColors(num_gr);
end

if mean(size(Group) ~= size(Y))
   if mean(size(Group) ~= size(X))
       error(['Group should match the size of X or Y']);
   else
       resize_group = 0;
   end
else 
    resize_group = 1;
end
    
% handle sizes
if numel(Y) == 1
    Y = Y.*ones(size(X));
    if resize_group
        Group = Group.*ones(size(X));
    end
else
    if size(Y,1) ~= size(X,1)
        error(['Y should be a scalar,' ...
            'a vector with the same number of rows X,'...
            ' or a matrix of the same size as X']);
    else
        if mean(size(Y) == size(X)) ~= 1
            if size(Y,2) == 1
                Y = repmat(Y,[1 size(X,2)]);
                if resize_group
                    Group = repmat(Group,[1 size(X,2)]);
                end
            else
                error(['Y should be a scalar,' ...
                    'a vector with the same number of rows X,'...
                    ' or a matrix of the same size as X']);
            end
        end
    end
end
if numel(size(X))>2
    error(['X should be a vector or 2-d matrix']);
end

Handles_all = nan(num_gr,size(X,2));
% loop through columns
for i_col = 1:size(X,2)
   ind_ok   = ~isnan(X(:,i_col));
   i_X      = X(ind_ok,i_col);
   tot_X    = sum(ind_ok); 
   i_Y      = Y(ind_ok,i_col);
   for i_gr = 1:num_gr
       ind_iX_iGr = Group(ind_ok,i_col) == wh_gr(i_gr);
       num_indIXGR = sum(ind_iX_iGr);
       if num_indIXGR>0
           [f,xi] = ksdensity(i_X(ind_iX_iGr));
           xi = [xi(1) xi xi(end)];
           f = [0 f 0];
           scatter_x = i_X(ind_iX_iGr);
           scatter_y = randn(size(i_X(ind_iX_iGr)));
       else
          % PDF is zeros 
          xi = [min(i_X(ind_iX_iGr)) max(i_X(ind_iX_iGr))];
          f = [0 0];
          scatter_x = 0;
           scatter_y = 0;
       end
       
       %iPDF = f.*(num_indIXGR./tot_X);
       iPDF = f;
       for_plot_X = [xi fliplr(xi)];
       for_plot_Y = Y(1)+[iPDF fliplr(-iPDF)];
       
       H = patch(for_plot_Y,for_plot_X,ColZ(i_gr,:),'facealpha',0.5);
       %alpha(0.5)
       Handles_all(i_gr,i_col) = H;
   end
end

    
end
    