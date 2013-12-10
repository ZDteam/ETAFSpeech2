function dist = get_dist_direct(s,t )
%GET_DIST_DIRECT Summary of this function goes here
%   Detailed explanation goes here
    len = min(size(s,1),size(t,1));
    dist = 0;
    for i=1:len
        dist = dist + sum((s(i,:)-t(i,:)).^2);
    end

end

