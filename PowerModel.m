function [pCh] = PowerModel(PV,params)

% define Stimulus space X. It might be convenient to use values between -1
% and 1
Xres = 0.01; % resolution of X
X = (-1:Xres:1);

if nargin<2
    EN = .1;
    Kappa = .1;
    LN = .1;
else
    EN = params(1);
    Kappa = params(2);
    LN = params(3);
end

% create matrix of X and PV compatible with normpdf
XMat = repmat(X,[size(PV,1) 1 size(PV,2)]);
PVMat = repmat(permute(PV,[1 3 2]), [1 numel(X) 1 ]);

% HERE COMES EARY NOISE
% Get PDFs given early noise
PDFs = normpdf(XMat,PVMat,EN);

% To visualize all PDFs of first trial figure, plot(X,squeeze(PDFs(1,:,:)))
%figure, plot(X,squeeze(PDFs(1,:,:)))


% HERE COMES A NONLINEARITY
% RA step, compute the gain of each X given the power
Gain = (abs(X).^Kappa).*sign(X);
%Gain2 = Kappa.*(abs(X)).^(Kappa-1);
GainMat = (abs(XMat).^Kappa).*sign(XMat);
% to visualize the gain function
%figure,plot(X,Gain)
%figure,plot(X,Gain2)

% Apply gain
nonlinX = PDFs.*GainMat;

% HERE COMES INTEGRATION
% compute the posterior by multiplying the transformed PDFs
postX = prod(abs(nonlinX),3);
% compute the sum of the transformed PDFs
%sumX  = sum(abs(nonlinX),3);

%figure,plot(X,postX(1,:))
%figure,plot(X,sumX(1,:))


% HERE COMES LATE NOISE
LNVec = normpdf(X,0,LN);
NPostX = conv2(postX,LNVec,'same');


% CHECK THE PROPORTION OF THE CURVE ABOVE THE BOUNDARY 
pCh = sum(abs(NPostX(:,X>0)),2)./(sum(abs(NPostX),2));


end