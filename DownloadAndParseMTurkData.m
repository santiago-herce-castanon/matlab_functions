function [] = DownloadAndParseMTurkData(WebDir)%,LocalDir)
if nargin < 1
    %WebDir = 'http://185.47.61.11/main/tasks/santiago/multialtColAAStair/data';
    WebDir = 'http://185.47.61.11/main/tasks/santiago/multialtColLower/data';
end
FolderName = 'multialt_datos';%Name of folder to save data in
 
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
    
    TargetMeanL = nan(NumTrials,1);
    TargetMeanM = nan(NumTrials,1);
    TargetMeanR = nan(NumTrials,1);
    TrialType = nan(NumTrials,1);
    for iTrial = 1:NumTrials
        TrialType(iTrial) = data.sdata.trialtype.(['value' num2str(iTrial-1)]);
    end
    TargetMeanL = data.sdata.stream.value0.targetmean(:); 
    TargetMeanM = data.sdata.stream.value1.targetmean(:); 
    TargetMeanR = data.sdata.stream.value2.targetmean(:);

    
    Evidence = nan(NumTrials,3,NumSamples);
    Evidence(:,1,:) = reshape(data.sdata.evidenceleft,NumTrials,NumSamples);
    Evidence(:,2,:) = reshape(data.sdata.evidencemid,NumTrials,NumSamples);
    Evidence(:,3,:) = reshape(data.sdata.evidenceright,NumTrials,NumSamples);
    
    ndata.whichcorrect = data.sdata.whichcorrect;
    ndata.whichchosen = data.sdata.whichchosen;
    ndata.whichunavailable = data.sdata.whichunavailable;
    ndata.earlyunavailable = data.sdata.earlyunavailable;
    ndata.wasrespcorr = data.sdata.wasrespcorr;
    ndata.reactiontimes = data.sdata.reactiontimes;
    ndata.evidence = Evidence;
    ndata.targetmeans = [TargetMeanL TargetMeanM TargetMeanR];
    ndata.actualmeans = mean(Evidence,3);
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