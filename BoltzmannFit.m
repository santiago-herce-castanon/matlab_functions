function [CurvFit Coef RCuad Flag ] = BoltzmannFit(x,y,iCol)

StPnt = [ 0 1 1 3.5 ];
FtTyp = fittype('(a1-a2)./(1+exp((x-xo)./dx))+a2',...
     'dependent',{'y'},'independent',{'x'},...
     'coefficients',{'a1', 'a2', 'dx', 'xo'});
 LoBound = [ 0  0   -inf   -inf];
 UpBound = [ 1  1    inf    inf];
 %LoBound = [ 0  1   0   0];
 %UpBound = [ 0  1   1   0];
 FitOpt = fitoptions( 'Method', 'nonlinearleastsquares','algorithm','trust-region', ... % 'nonlinearleastsquares'
    'StartPoint',StPnt  ,'Lower',LoBound, 'Upper', UpBound,'maxfunevals',1000); % , 'Algorithm',...
     %'Gauss-Newton');
 
 [CurvFit Good Output] = fit(x(:),y(:),FtTyp, FitOpt);
Flag = Output.exitflag;
Coef = [CurvFit.a1 CurvFit.a2 CurvFit.dx CurvFit.xo];
RCuad = Good.rsquare;

if isempty(iCol)
    Graficar = 0;
else
    Graficar = 1;
end
if Graficar == 1
    figure1 = figure;
    DxText = num2str((Coef(2)-Coef(1)));%/(4*Coef(3)));
    % a1 = Coef(1); a2 = Coef(2); dx = Coef(3);xo = Coef(4);
    % YDif = ((a1-a2)./(1+exp((10-xo)./dx))+a2) - ((a1-a2)./(1+exp((30-xo)./dx))+a2);
    plot(x,y,'*b','DisplayName',DxText)
    hold on
    %lsline
    h_ = plot(CurvFit,'fit',0.99 );%,'color',i);
    annotation(figure1,'textbox',[0.1875 0.8133 0.08929 0.06429],...
        'String',DxText);


end