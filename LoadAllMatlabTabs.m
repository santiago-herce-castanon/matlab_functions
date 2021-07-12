function [] = LoadAllMatlabTabs(AllTabs)

n_tabs = length(AllTabs);

for i_t = 1:n_tabs
    i_t_name = AllTabs{i_t};
    try
        open(i_t_name)
    catch
       warning(['error opening: ' i_t_name]) 
    end

end
end