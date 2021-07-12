function [] = DownloadAndParseMTurkData(WebDir)%,LocalDir)
if nargin < 1
    WebDir = 'http://185.47.61.11/main/tasks/santiago/expcuesquircles/data';
end
FolderName = 'expcuesquircles_datos';%Name of folder to save data in
 
mturk_parseurl(FolderName,WebDir)%Download and parse data
 
ConvertParsedDataToStruct(FolderName)
 
end
 
function [] = ConvertParsedDataToStruct(FolderName)
 
cd(FolderName)% Go inside folder
cd data
 


DirFiles = dir('*.txt.uncell*');
NumFiles = length(DirFiles);
iGoodFile = 1;
for iFile = 1: NumFiles
    
    FileName = DirFiles(iFile).name;
    load(FileName);
    NumTrials = data.parameters.numtrials;
    NumSamples = data.parameters.numsamples;
    
    TrialType = data.sdata.trialtype;
    TargetMeanColour = data.sdata.targetcolourmean;
    TargetMeanShape = data.sdata.targetshapemean;
    TargetStdColour = data.sdata.targetcolourstd;
    TargetStdShape = data.sdata.targetshapestd;
    
    EvidenceColour = reshape(data.sdata.evidencecolour,NumTrials,NumSamples);
    EvidenceShape = reshape(data.sdata.evidenceshape,NumTrials,NumSamples);
    
    
    ndata.whichcorrect = data.sdata.whichcorrect;
    ndata.whichchosen = data.sdata.whichchosen;
    ndata.wasrespcorr = data.sdata.wasrespcorr;
    ndata.reactiontimes = data.sdata.reactiontimes;
    ndata.evidencecolour = EvidenceColour;
    ndata.evidenceshape = EvidenceShape;
    ndata.targetmeanscolour = TargetMeanColour;
    ndata.targetmeansshape = TargetMeanShape;
    ndata.targetstdcolour = TargetStdColour;
    ndata.targetstdshape = TargetStdShape;
    
    ndata.actualmeanscolour = data.sdata.actualcolourmean;
    ndata.actualmeansshape = data.sdata.actualshapemean;
    ndata.validcue = data.sdata.cuevalidity;
    ndata.whichcue = data.sdata.whichcue;
    ndata.trialtype = TrialType;
    ndata.expdata = data.edata;
    ndata.parameters = data.parameters;
    ndata.sequencelengthtrial = data.sdata.sequencetimelength;
    
%     figure;
%     subplot(2,2,1), hold all
%     plot(mean(reshape(ndata.wasrespcorr,ndata.parameters.blocklength,ndata.parameters.numblocks),1));
%     subplot(2,2,2), hold all
%     plot(ndata.sequencelengthtrial,'*');
%     subplot(2,2,3), hold all
%     plot(ndata.reactiontimes,'o');
%     subplot(2,2,4), hold all
%     plot(ndata.whichcorrect,'o');
%     plot(ndata.whichchosen+1,'+');
%     ylim([0 4])
 
    
    NewName = ['SUB' num2str(iGoodFile, '%02d') '_' FileName(1:end-15) '.mat']
    data = ndata;
    
    if isfield(data.expdata, 'exp_finishtime')
        if (data.expdata.exp_finishtime > (20*60*1000))
            save(NewName, 'data')
            iGoodFile = iGoodFile+1;
        end
    end
    
   
end
 
cd ..
cd ..
 
    
    
end