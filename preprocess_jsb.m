function preprocess_jsb(rootDir,outFile,quant)
if nargin<2, outFile='jsb_data.mat'; end
if nargin<3, quant=4; end
f=dir(fullfile(rootDir,'**','*.mid'));
seqs=cell(1,numel(f));
for k=1:numel(f)
    m=midiread(fullfile(f(k).folder,f(k).name));
    tpq=m.TicksPerQuarterNote;
    q=floor(tpq/quant);
    n=m.NoteEvents;
    t=ceil(max(n(:,3))/q);
    s=ones(1,t,'int16')*129;
    for i=1:size(n,1)
        idx=floor(n(i,1)/q)+1;
        s(idx)=int16(n(i,2)+1);
    end
    seqs{k}=int16([130 s 131]);
end
save(outFile,'seqs','-v7.3')
end
