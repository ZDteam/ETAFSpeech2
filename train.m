function  [feature_mat] = train(train_set,TEST_FS,ETAF_DEBUG,ETAF_RMZERO)

files = dir(train_set);
[n,~] = size(files);
n = n-2;

% fprintf('======================== training ========================\n');
feature_mat = cell(n,1);

for i =1:n
    waveFile = [train_set,num2str(i),'.wav'];
    [y,fs,nbits] = wavread(waveFile);
    if(ETAF_DEBUG)
        fprintf('fs = %d nbits=%d\n',fs,nbits);
    end
    if(fs ~= TEST_FS)
        y = resample(y,TEST_FS,fs);
        fs = TEST_FS;
    end
%     [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
    if(ETAF_RMZERO)
        y=remove_zero(y);
    end
    
    feature_mat{i}= feature_extract_2(y,fs);
    
end
% fprintf('======================== trained successfully ============\n');
end

