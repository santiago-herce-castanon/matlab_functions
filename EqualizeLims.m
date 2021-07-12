function [] = EqualizeLims(X,Y)
if nargin < 2
    X = [1];
    Y = [1];
end

NewYlims = [inf -inf];
NewXlims = [inf -inf];
try
    hAxesAll = findall(gcf,'type','axes');
    
    for GetSet = 1:2
        for iAx = 1:numel(hAxesAll)
            if GetSet == 1
            YLims = get(hAxesAll(iAx),'ylim');
            XLims = get(hAxesAll(iAx),'xlim');
            NewYlims = [min([NewYlims(1) YLims(1)]) max([NewYlims(2) YLims(2)]) ];
            NewXlims = [min([NewXlims(1) XLims(1)]) max([NewXlims(2) XLims(2)]) ];                
            else
                if X == 1
                    set(hAxesAll(iAx),'xlim',NewXlims)
                end
                if Y == 1
                    set(hAxesAll(iAx),'ylim',NewYlims)
                end
            end
        end
    end
catch  
end

end