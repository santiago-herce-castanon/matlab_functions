function [H] = PlotTrilinearGraph(X,Rot,ColZ,OffX,OffY)
if size(X,2) ~= 3
    error('data must have three columns!')
end
if max(X(:)) > 1
    error('maximum allowed value is 1!')
end
if min(X(:)) < 0
    error('maximum allowed value is zero!')
end
if (nargin < 2) || isempty(Rot)
    Rot = 0;
end
if (nargin < 3) || isempty(ColZ)
    ColZ = [1 0 0 ; 0 1 0 ; 1 1 0];
end
CleanXAx = 0;
if (nargin < 4) || isempty(OffX)
    CleanXAx = 1;
    OffX = 0;
end
CleanYAx = 0;
if (nargin < 5) || isempty(OffY)
    CleanYAx = 1;
    OffY = 0;
end
%%
Alpha = 0.9;
is_ok = ~any(isnan(X),2);
X = X(is_ok,:);
%%
muX = nanmean(X,1);

LnCol = [0 0 0];
LnStyl = '-';
if any(isnan(muX))
    LnStyl = ':';
    LnCol = [.7 .7 .7];
end
V1 = [cosd(90+Rot) sind(90+Rot)] + [OffX OffY];
V2 = [cosd(210+Rot) sind(210+Rot)] + [OffX OffY];
V3 = [cosd(330+Rot) sind(330+Rot)] + [OffX OffY];
Vall = [V1; V2; V3];

%plot(Vall(:,1),Vall(:,2),'k*'), hold on
%line([V1(1) V2(1)],[V1(2) V2(2)],'color',[0 0 1])
line([Vall(:,1) Vall([2 3 1],1)],[Vall(:,2) Vall([2 3 1],2)],'color',LnCol,'LineStyle',LnStyl)

Centroid = muX*Vall; % muX/Vall'   Vall'/muX   muX*Vall 
hold on

%{
pX = X;
XPts = pX*Vall;
for i = 1:size(XPts,1)
    %plot(XPts(i,1),XPts(i,2),'o','markeredgecolor',[.5 .5 .5],'markerfacecolor',X(i,:)*ColZ([2 3 1],:))
    plot(XPts(i,1),XPts(i,2),'.','color',X(i,:)*ColZ([2 3 1],:))
end
%}

H(1) = fill([Vall([1 2],1); Centroid(1)],[Vall([1 2],2); Centroid(2)],ColZ(1,:),'LineStyle','none','FaceAlpha',Alpha);
H(2) = fill([Vall([2 3],1); Centroid(1)],[Vall([2 3],2); Centroid(2)],ColZ(2,:),'LineStyle','none','FaceAlpha',Alpha);
H(3) = fill([Vall([1 3],1); Centroid(1)],[Vall([1 3],2); Centroid(2)],ColZ(3,:),'LineStyle','none','FaceAlpha',Alpha);
%plot(Centroid(1),Centroid(2),'.k')

ax1(1) = gca;
if CleanYAx
    ax1(1).YAxis.Visible = 'off';
else
    ax1(1).YAxis.Visible = 'on';
end
if CleanXAx
    ax1(1).XAxis.Visible = 'off';
else
    ax1(1).XAxis.Visible = 'on';
end
axis equal


end