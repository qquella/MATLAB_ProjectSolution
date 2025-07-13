function preprocess_jsb(rootDir,outFile)
% Convert JSB Chorales CSV files (train/valid/test) into token sequences.
% rootDir : path to JSB_Chorales folder
% outFile : .mat file to write (default = 'jsb_data.mat')

if nargin<2, outFile='jsb_data.mat'; end

parts  = ["train","valid","test"];      % expected sub-directories
seqs   = {};                            % cell array of int16 row vectors
tokRest = int16(129);                   % special tokens
tokBOS  = int16(130);
tokEOS  = int16(131);

for p = parts
    files = dir(fullfile(rootDir,p,"*.csv"));
    for f = files'
        row = readmatrix(fullfile(f.folder,f.name),"Delimiter",",");   % 1-by-T
        row = row(~isnan(row));                                       % chop NaNs
        row = int16(row);                                             % to int16
        row(row == -1) = tokRest;                                     % rest → 129
        row(row >= 0)  = row(row >= 0) + 1;                           % pitch+1
        seqs{end+1} = [tokBOS row tokEOS];                            %#ok<AGROW>
    end
end

save(outFile,"seqs","-v7.3")
end
