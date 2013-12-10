function ccc = mfcc(x,fs,shortEnergy)

[nf,frameSize] = size(x);

% 归一化mel滤波器组系数
filter_num = 24; %三角滤波器个数
coef_num = 16; %阶数
% bank=melbankm(filter_num,frameSize,fs,0,0.5,'m');
bank=melbankm(filter_num,frameSize,fs,0,0.5,'tz');
% bank=full(bank);
% bank=bank/max(bank(:));
% 
% DCT系数,coef_num*filter_num;
for k=1:coef_num
  n=1:filter_num;
  dctcoef(k,:)=cos((n-0.5)*k*pi/(filter_num));
end

% 归一化倒谱提升窗口
w = 1 + 6 * sin(pi * [1:coef_num] ./ coef_num);
w = w/max(w);

% % 预加重滤波器
% xx=double(x);
% xx=filter([1 -0.9375],1,xx);

% % 语音信号分帧
% [x1,x2]= vad(xx);
% xx=enframe(xx,256,80);

% 计算每帧的MFCC参数
j=1;
for i=1:nf
  y = x(i,:);
  if y(:)==0
    m(j,:)=0;
    j=j+1;
    continue;
  end
  s = y' .* hamming(frameSize);
  t = abs(fft(s));
  t = t.^2;
  c1=dctcoef * log(bank * t(1:1+floor(frameSize/2)));
  c2 = c1.*w';
  m(j,:)=c2';
  j = j+1;
end

%差分系数
dtm = zeros(size(m));
for i=3:size(m,1)-2
%     if(i==size(m,1)-2)
% %         disp(m(i+1,:));
% %         disp(m(i+2,:));
%     end
    dtm(i,:) = -2*m(i-2,:) - m(i-1,:) + m(i+1,:) + 2*m(i+2,:);
end
dtm = dtm / 3;
%差分系数的差分
% dtm2 = zeros(size(dtm));
% for i=3:size(dtm,1)-2
%   dtm2(i,:) = -2*dtm(i-2,:) - dtm(i-1,:) + dtm(i+1,:) + 2*dtm(i+2,:);
% end
% dtm2 = dtm2 / 3;
%合并mfcc参数和一阶差分mfcc参数
ccc = [m dtm ];
%去除首尾两帧，因为这两帧的一阶差分参数为0
% ccc = ccc(3:size(m,1)-2,:);

