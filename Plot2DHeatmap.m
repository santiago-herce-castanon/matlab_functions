function [] = Plot2DHeatmap(X,Y,NBinsX,NBinsY,ColZ)
%%
Res = 100;
if (nargin<3) || (isempty(NBinsX))
    NBinsX = 10;
end
if (nargin<4) || (isempty(NBinsY))
    NBinsY = 10;
end
if (nargin< 5) || (isempty(ColZ))
    ColZ = linspace(0,1,Res)'.*[0.3 0.3 0.9] + flipud(linspace(0,1,Res)');
end
X = X(:);
Y = Y(:);
%%
minX = min(X(:));
minY = min(Y(:));
maxX = max(X(:));
maxY = max(Y(:));

bin_ranges_ox = linspace(minX,maxX,NBinsX+1);
bin_ranges_x = bin_ranges_ox;
bin_ranges_x(1) = -inf; 
bin_ranges_x(end) = inf;
bin_ranges_oy = linspace(minY,maxY,NBinsY+1);
bin_ranges_y = bin_ranges_oy;
bin_ranges_y(1) = -inf; 
bin_ranges_y(end) = inf;

is_ok1 = ~any(isnan([X Y]),2);

[countsx, ind_cnts_x] = histc(X(is_ok1),bin_ranges_x);
[countsy, ind_cnts_y] = histc(Y(is_ok1),bin_ranges_y);

figure('color','w','units','centimeters','position',[0 0 20 15])

cMat = nan(NBinsY,NBinsX);
for ibin = 1:NBinsX
    for jbin = 1:NBinsY
        cMat(jbin,ibin) = sum((ind_cnts_x==ibin)&(ind_cnts_y==jbin));
    end
end
nbins_sbpl = 25;

sb_pl1 = (2:nbins_sbpl)+((nbins_sbpl+1).*(0:(nbins_sbpl-1))');
subplot(nbins_sbpl+1,nbins_sbpl+1,sort(sb_pl1(:)))
imagesc(cMat./sum(cMat(:)))
bin_rang_app = round(100.*bin_ranges_o)./100;
%set(gca,'ydir','normal','xtick',.5:1:(nbins+1),'xticklabel',bin_rang_app,'ytick',.5:1:(nbins+1),'yticklabel',bin_rang_app)
%set(gca,'ydir','normal','xtick',.5:1:(nbins_sbpl+1),'xticklabel','','ytick',.5:1:(nbins_sbpl+1),'yticklabel','')
set(gca,'ydir','normal','xtick','','xticklabel','','ytick','','yticklabel','')
colormap(ColZ)

%title(['(only when correct matrices)'])

subplot(nbins_sbpl+1,nbins_sbpl+1,(1)+((nbins_sbpl+1).*(0:(nbins_sbpl-1))'))
imagesc(sum(cMat,2))
set(gca,'ydir','normal','xtick',[],'ytick',[])
ylabel(['production alpha' newline '(transition probability from production)'])
set(gca,'ydir','normal','xtick','','xticklabel',bin_rang_app,'ytick',.5:1:(nbins_sbpl+1),'yticklabel',bin_rang_app)
%set(gca,'ydir','normal','xtick','','xticklabel',bin_rang_app,'ytick','','yticklabel',bin_rang_app)

subplot(nbins_sbpl+1,nbins_sbpl+1,(2:nbins_sbpl)+((nbins_sbpl+1).*(nbins_sbpl)'))
imagesc(sum(cMat,1))
set(gca,'ydir','normal','xtick',[],'ytick',[])
xlabel(['prediction alpha' newline '(transition probability from predictions)'])
set(gca,'ydir','normal','xtick',.5:1:(nbins_sbpl+1),'xticklabel',bin_rang_app,'ytick','','yticklabel',bin_rang_app)
%set(gca,'ydir','normal','xtick','','xticklabel',bin_rang_app,'ytick','','yticklabel',bin_rang_app)


%%
rangX = range(X);
rangY = range(Y);
xX = linspace(0,rangX*1.1,Res)+min(X)-rangX*.05;
yY = linspace(0,rangY*1.1,Res)+min(Y)-rangY*.05;

%xX = linspace(min(X)-BndWdth.*(abs(minX)),max(X),Res);
%yY = linspace(min(Y),max(Y),Res);

[cX indX] = histc(X,xX);
[cY indY] = histc(Y,yY);

PDF2d = normpdf(linspace(-5,5,ceil((Res))),0,NBinsX);
cXY = zeros(Res);
for i = 1:size(indX)
    cXY(indY(i),indX(i)) = cXY(indY(i),indX(i)) +1;
end
[pfdxy] = conv2(cXY,(PDF2d'.*PDF2d),'same');
%imagesc(xX,yY,pfdxy)

H_cf = contourf(xX,yY,pfdxy,'linecolor','none');
set(gca,'ydir','normal')
whCA = gca;
CMap3 = MakeDensityColormap(ColZ);
colormap(whCA,CMap3);
hold on,
HD = plot(X,Y,'k.'); lsline;



box off
XTcks = get(gca,'xtick');
YTcks = get(gca,'ytick');
set(gca,'xtick',[min(XTcks) max(XTcks)])
set(gca,'ytick',[min(YTcks) max(YTcks)])
PropExtra = 0.05;
LimX = xlim;
LimY = ylim;
%X_width = PropExtra.*range(LimX);
%X_height = PropExtra.*range(LimY);
%LimX = [LimX(1)-X_width  LimX(2)];
%LimY = [LimY(1)-X_height LimY(2)];
%xlim(LimX)
%ylim(LimY)

[dX xX] = ksdensity(X,xX,'bandwidth',NBinsX.*.05);
[dY xY] = ksdensity(Y,yY,'bandwidth',NBinsX.*.05);
%xlim([-inf max(XTcks)])
%ylim([-inf max(YTcks)])

HP(1) = patch(ones(numel(xX),1).*LimX(1),xY(:),max(pfdxy(:)).*((dY'./max(dY))),'EdgeColor','interp','FaceColor','interp','marker','s','markersize',5,'markerfacecolor','flat');
HP(2) = patch(xX(:),ones(numel(xY),1).*LimY(1),max(pfdxy(:)).*((dX'./max(dX))),'EdgeColor','interp','FaceColor','interp','marker','s','markersize',5,'markerfacecolor','flat');
%{
for i = 1:numel(xY)
    plot(xX(1),xY(i),'s','markeredgecolor','w','markerfacecolor',ones(1,3).*(1-(dY(i)'./max(dY))),'MarkerSize',5)
end
for i = 1:numel(xX)
    plot(xX(i),xY(1),'s','markeredgecolor','w','markerfacecolor',ones(1,3).*(1-(dX(i)'./max(dX))),'MarkerSize',5)
end
    %}
end
