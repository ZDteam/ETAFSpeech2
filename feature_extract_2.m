function [ v ] = feature_extract_2( y,fs )
%FEATURE_EXTRACT_2 Summary of this function goes here
%   Detailed explanation goes here
%  frameTime 每帧的时间 单位ms
frameTime = 15;
% 分幀
frameSize = floor(fs*frameTime/1000);
% v = melcepst(y,fs,'MD');
v = melcepst(y,fs,'Md',12,24,256);
    
end

