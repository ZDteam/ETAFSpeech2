function [ x ] = remove_zero( y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
j=1;
for i=1:length(y)
    if(y(i)>0)
        x(j) = y(i);
        j=j+1;
    end
end
end

