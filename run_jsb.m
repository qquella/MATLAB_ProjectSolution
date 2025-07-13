function run_jsb(rootDir,temp,maxLen)
% One-liner to preprocess CSV, train the LSTM, and generate a sample.
% rootDir : path to JSB_Chorales folder (train/valid/test sub-dirs inside)
% temp    : sampling temperature (default 1.0)
% maxLen  : maximum generated length in tokens (default 512)

if nargin<2, temp   = 1.0;  end
if nargin<3, maxLen = 512;  end

preprocess_jsb(rootDir,"jsb_data.mat");     % CSV → token sequences
train_jsb("jsb_data.mat","jsb_net.mat");    % train LSTM
generate_jsb("jsb_net.mat","chorale_sample.mid",temp,maxLen);  % sample
end
