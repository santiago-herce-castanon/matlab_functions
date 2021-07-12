function [] = SetPanelName(lab_txt,pos_perc_x,pos_perc_y,txt_sz)
if nargin < 2
    pos_perc_x = -.25;
end
if nargin < 3
    pos_perc_y = 1.20;
end
if nargin < 4
    txt_sz = 12;
end
panel_handles = get(gca);
limX = panel_handles.XLim;
limY = panel_handles.YLim;
x_pos = limX(1) + (limX(2)-limX(1)).*pos_perc_x;
y_pos = limY(1) + (limY(2)-limY(1)).*pos_perc_y;
text(x_pos,y_pos,lab_txt,'fontsize',txt_sz,'fontweight','bold')
end