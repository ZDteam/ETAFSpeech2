function d = etaf_dist( s,t )
%ETAF_DIST Summary of this function goes here
%   Detailed explanation goes here
ns = size(s,1);
nt = size(t,1);
max_offset =  min([20,nt,ns]);
d = Inf;
for i=1:max_offset
    ld = etaf_ldist(s,t(i:nt,:));
    d = min(d,ld);
end

end

function ld = etaf_ldist(s,t)
   ns = size(s,1);
   nt = size(t,1);
   if(nt<ns)
        t(nt+1:ns,:) = -s(nt+1:ns,:);
   end
   ld = 0;
   for i=1:ns
       ld = ld + sum( (s(i,:)-t(i,:)).^2 );
   end
   
end


