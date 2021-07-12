function [RaZ,RHO1,PVAL1,RHO2,PVAl2] = MyPartialCorrTable(DataT,wh_X_vars,wh_Y_vars,wh_Z_vars)

wh_vars_common_all = DataT.Properties.VariableNames;
[logA,indY] = ismember(wh_Y_vars,wh_vars_common_all);
[logA,indX] = ismember(wh_X_vars,wh_vars_common_all);
[logA,indZ] = ismember(wh_Z_vars,wh_vars_common_all);

i_data4_Y = DataT(:,wh_Y_vars);
i_data4_X = DataT(:,wh_X_vars);
i_data4_Z = DataT(:,wh_Z_vars);

Y_mat = table2array(i_data4_Y);
X_mat = table2array(i_data4_X);
Z_mat = table2array(i_data4_Z);

X_aZ = nan(size(X_mat));
Y_aZ = nan(size(Y_mat));

% partial-out the z variables from X
for ix = 1:size(X_mat,2)
    %[B, Dev, Stats] = glmfit(Z_mat,X_mat(:,ix));
    [B, Dev, Stats] = glmfit(NPNTrans(Z_mat),NPNTrans(X_mat(:,ix)));
    %[B, Dev, Stats] = glmfit(tiedrank(Z_mat),tiedrank(X_mat(:,ix)));
    X_aZ(:,ix) = Stats.resid;
end
% partial-out the z variables from Y
for iy = 1:size(Y_mat,2)
    %[B, Dev, Stats] = glmfit(Z_mat,Y_mat(:,iy));
    [B, Dev, Stats] = glmfit(NPNTrans(Z_mat),NPNTrans(Y_mat(:,iy)));
    %[B, Dev, Stats] = glmfit(tiedrank(Z_mat),tiedrank(Y_mat(:,iy)));
    Y_aZ(:,iy) = Stats.resid;
end

%RaZ = array2table([Y_aZ X_aZ]);
RaZ = array2table(NPNTrans([Y_aZ X_aZ]));
RaZ.Properties.VariableNames = [ wh_Y_vars wh_X_vars];

%[RHO1,PVAL1] = corr((Y_afterZ),(X_afterZ),'type','Spearman');
[RHO1,PVAL1] = corr(NPNTrans(Y_aZ),NPNTrans(X_aZ),'type','Spearman');
%[RHO1,PVAL1] = corr(ZTransformX(Y_afterZ),ZTransformX(X_afterZ),'type','Spearman');
[RHO2,PVAl2] = partialcorr(X_mat,Y_mat,Z_mat,'type','Spearman');

end