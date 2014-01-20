function  etaf
close all;
fs = 16000;
[y0,fs0] = wavread('songs/十年静音/origin/1.wav');
y0 = resample(y0,fs,fs0);
y0 = remove_zero(y0);
figure,melcepst(y0,fs);
feature0 = melcepst(y0,fs);
[y1,fs1] = wavread('songs/十年/test/刘旺/1.wav');
y1 = resample(y1,fs,fs1);
y1 = remove_zero(y1);

figure,melcepst(y1,fs);
feature1 = melcepst(y1,fs);

[y2,fs2] = wavread('songs/十年静音/test/静音/1.wav');

y2 = remove_zero(y2);
y2 = resample(y2,fs,fs2);
figure,melcepst(y2,fs);
feature2 = melcepst(y2,fs);

dist1 = dtw(feature0,feature1);
dist2 = dtw(feature0,feature2);

fprintf('dist1=%.2f\ndist2=%.2f\n',dist1/size(feature0,1),dist2/size(feature0,1));

end

