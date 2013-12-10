function  [feature_mat,thresholds] = train(train_set)

files = dir(train_set);
[n,~] = size(files);
n = n-2;

% fprintf('======================== training ========================\n');
feature_mat = cell(n,1);

for i =1:n
    waveFile = [train_set,num2str(i),'.wav'];
    [y,fs,nbits] = wavread(waveFile);
%             fprintf('fs = %d nbits=%d\n',fs,nbits);
    [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
    feature_mat{i}= feature_extract(x,fs,zcr,shortEnergy);
    
end
% fprintf('======================== trained successfully ============\n');
end

