function [ x1,x2 ] = vad2( x,zcr,amp )

amp2 = 1;

amp2 = min(amp2, max(amp)/12);
len = length(zcr);

for i=1:len
    if abs(amp(i)) > amp2
        x1 = i;
        break;
    end
end

for i=len:-1:1
    if abs(amp(i)) > amp2
        x2 = i;
        break;
    end
end
end

