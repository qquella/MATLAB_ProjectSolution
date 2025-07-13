function net=train_jsb(dataFile,modelFile)
if nargin<1, dataFile='jsb_data.mat'; end
if nargin<2, modelFile='jsb_net.mat'; end
load(dataFile,'seqs')
X=cellfun(@(s) double(s(1:end-1)),seqs,'UniformOutput',false);
Y=cellfun(@(s) categorical(s(2:end)),seqs,'UniformOutput',false);
layers=[ ...
    sequenceInputLayer(1)
    wordEmbeddingLayer(128,131)
    lstmLayer(512,'OutputMode','sequence')
    dropoutLayer(0.2)
    lstmLayer(512,'OutputMode','sequence')
    fullyConnectedLayer(131)
    softmaxLayer];
opts=trainingOptions('adam', ...
    'MaxEpochs',50, ...
    'MiniBatchSize',32, ...
    'Shuffle','every-epoch', ...
    'GradientThreshold',1, ...
    'Verbose',false);
net=trainNetwork(X,Y,layers,opts);
save(modelFile,'net','-v7.3')
end
