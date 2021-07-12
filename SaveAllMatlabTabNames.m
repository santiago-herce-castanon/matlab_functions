function [] = SaveAllMatlabTabNames(Filename,FolderName)
if nargin < 1
    Filename = ['AllTabs_' datestr(now,30)];
end
if nargin < 2
    FolderName = '~/Google Drive/WorkSpace/';
end
AllTabs = matlab.desktop.editor.getAll;
n_tabs = length(AllTabs);


for i_t = 1:n_tabs
    i_t_name = AllTabs(i_t).Filename;
    try
        AllTabNames{i_t,1} = i_t_name;
    catch
       warning(['error saving: ' i_t_name]) 
    end
end
save([FolderName Filename '.mat'], 'AllTabNames')
end