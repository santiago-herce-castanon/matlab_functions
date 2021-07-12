function [] = PlotAlluvialFlow(X,nbins,left_labels, right_labels, chart_title)
if (nargin < 2) || isempty(nbins)
    nbins = 4;
end
if (nargin < 3) || isempty(left_labels)
    left_labels = '';
end
if (nargin < 4) || isempty(right_labels)
    right_labels = '';
end
if (nargin < 5) || isempty(chart_title)
    chart_title = '';
end
%%
o_bins = permute(linspace(-.01,1.01,nbins+1),[3 1 2]);
r_x = range(X,1);
min_x = min(X,[],1);
wh_bins = o_bins.*[r_x] + min_x;

data = zeros(size(X));
max_cnt = 0;

for ib = 1:nbins
    cond1 = X >= wh_bins(:,:,ib);
    cond2 = X < wh_bins(:,:,ib+1);
    max_cnt = max([max_cnt sum(cond1.*cond2)]);
    data = data + (cond1.*cond2).*ib;
end

for ic = size(data,2):-1:1
data = sortrows(data,ic);
end

%%
nr = size(data,1);
ncol = size(data,2);

[u_rows, indA, indC] = unique(data,'rows','stable');
num_u = size(u_rows,1);

prop_r = linspace(0,1,num_u)';
%prop_r = sum((data-1).^[ncol:-1:1],2); prop_r = prop_r./max(prop_r);
all_colz = [prop_r 0.*prop_r 1-prop_r];

hold on,
line_res = 20;

for ir = 1:nr
    ird = data(ir,:);
    ind_row = find(mean(u_rows == ird,2)==1);
    for icol = 1:(ncol-1)
        irc =(0:1)+icol;
        ipair = ird(irc);
        
        iiy1 = ipair(1)-sum(data(1:ir,icol+0) == ipair(1))./max_cnt;
        iiy2 = ipair(2)-sum(data(1:ir,icol+1) == ipair(2))./max_cnt;
                
        ix = linspace(irc(1),irc(2),line_res);
        iy = ir./nr - 1 + ipair(1) + diff(ipair).*(1-cos(linspace(0,pi,line_res)))./2;
        %iy = iiy1-1 + (iiy2-iiy1).*(1-cos(linspace(0,pi,line_res)))./2;
        %iy = iiy1-1 + ipair(1) + (diff(ipair)).*(1-cos(linspace(0,pi,line_res)))./2;
        
        %plot(ix,iy,'-','color',all_colz(ir,:))
        plot(ix,iy,'-','color',all_colz(ind_row,:))
    end
end

%set (gca,'xtick',1:ncol,'ytick',0:nbins,'yticklabel',num2str(round(100.*squeeze(wh_bins(1,1,:)))./100)) % 
set (gca,'xtick',1:ncol,'ytick',0:nbins,'yticklabel',num2str(squeeze(wh_bins(1,1,:)),'%.2f')) % 
xlim([1 ncol])
ylim([0 nbins])



end
