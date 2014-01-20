function [ c ] = etaf_dct(y )
%ETAF_DCT Summary of this function goes here
%   Detailed explanation goes here
[n,~] = size(y);
for i=1:n
    c(i,:) = dct(y(i,:));
end

