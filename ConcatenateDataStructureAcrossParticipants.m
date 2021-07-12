function [DataAll] = ConcatenateDataStructureAcrossParticipants()

Files = dir('BSUB*.mat');
NumFiles = numel(Files);
DataAll.subject = [];
DataAll.rejectedsubjects = [];
DataAll.subjectnameold = [];
for iFile = 1:NumFiles
    
    Name = Files(iFile).name;
    load(Name)
    Acc = nanmean(data.wasrespcor(data.biasedtrial(:)==0)==1);
    OrigSub = str2num(Name(5:6));
    if Acc > 0.55
        Fields = fieldnames(data);
        NewSubs = [DataAll.subject; ones(length(data.wasrespcor),1)*iFile];
        OldSubs = [DataAll.subjectnameold; ones(length(data.wasrespcor),1)*OrigSub];
        DataAll = setfield(DataAll,'subject',NewSubs);
        DataAll = setfield(DataAll,'subjectnameold',OldSubs);
        for iField = 1:numel(Fields)
            
            FieldName = Fields{iField};
            %display(['File:' num2str(iFile) '_FielNo:' num2str(iField) '_FieldName:' FieldName])
            if ~isfield(DataAll,FieldName)
                DataAll = setfield(DataAll,FieldName,[]);
            end
                NewVal = [ getfield(DataAll, FieldName) ; getfield(data, FieldName)];
                DataAll = setfield(DataAll, FieldName, NewVal);
        end
    else
        RejSub = [DataAll.rejectedsubjects; OrigSub];
        DataAll = setfield(DataAll,'rejectedsubjects',RejSub);
    end
end

data =  DataAll;
try
data.biasedtrial = data.biasedtrial'; data.biasedtrial = data.biasedtrial(:);
data.stimuli = [];
data.pvs = data.actualsamplesshown;
data.fixhighcontrial = data.fixhighcontrial'; data.fixhighcontrial = data.fixhighcontrial(:);
data.fixhighvartrial = data.fixhighvartrial'; data.fixhighvartrial = data.fixhighvartrial(:);
data.fixlowcontrial = data.fixlowcontrial'; data.fixlowcontrial = data.fixlowcontrial(:);
data.fixlowvartrial = data.fixlowvartrial'; data.fixlowvartrial = data.fixlowvartrial(:);
catch 
end
DataAll = data;

end