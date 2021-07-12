function [] = PlotScatterDensity(X,Y,BndWdth,ColZ)
%%
Res = 100;
if nargin< 4
    ColZ = [0.3 0.3 0.9];
end
if nargin< 3
    BndWdth = 1;
end
rangX = range(X);
rangY = range(Y);
xX = linspace(0,rangX*1.1,Res)+min(X)-rangX*.05;
yY = linspace(0,rangY*1.1,Res)+min(Y)-rangY*.05;

%xX = linspace(min(X)-BndWdth.*(abs(minX)),max(X),Res);
%yY = linspace(min(Y),max(Y),Res);

[cX indX] = histc(X,xX);
[cY indY] = histc(Y,yY);

PDF2d = normpdf(linspace(-5,5,ceil((Res))),0,BndWdth);
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

[dX xX] = ksdensity(X,xX,'bandwidth',BndWdth.*.05);
[dY xY] = ksdensity(Y,yY,'bandwidth',BndWdth.*.05);
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
