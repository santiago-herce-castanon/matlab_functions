function [DataAll] = ConcatenateDataStruct()

Files = dir('ORNE*.mat');
NumFiles = numel(Files);
DataAll.subject = [];
for iFile = 1:NumFiles
    
    Name = Files(iFile).name;
    load(Name)
    
    Fields = fieldnames(data);
    NewSubs = [DataAll.subject; ones(length(data.wasrespcor),1)*iFile];
    DataAll = setfield(DataAll,'subject',NewSubs);
    for iField = 1:numel(Fields)
        
        FieldName = Fields{iField};
        if ~isfield(DataAll,FieldName)
            DataAll = setfield(DataAll,FieldName,[]);
        end
        NewVal = [ getfield(DataAll, FieldName) ; getfield(data, FieldName)];
        DataAll = setfield(DataAll, FieldName, NewVal);
    end
end

end