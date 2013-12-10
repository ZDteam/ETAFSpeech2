% Copyright (C) 2013 Quan Wang <wangq10@rpi.edu>,
% Signal Analysis and Machine Perception Laboratory,
% Department of Electrical, Computer, and Systems Engineering,
% Rensselaer Polytechnic Institute, Troy, NY 12180, USA

% dynamic time warping of two signals

function d=dtw(s,t)


ns=size(s,1);
nt=size(t,1);


%% initialization
D=zeros(ns+1,nt+1)+Inf; % cache matrix
D(1,1)=0;

%% begin dynamic programming
for i=1:ns
    for j=1:nt
%       oost=abs(s(i)-t(j));
        oost = Dist(s(i,:),t(j,:));
        D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
    end

end
d=D(ns+1,nt+1);
end

function dist =Dist(s1,s2)
%     disp(s1);
%     disp(s2);
    dist = sum((s1-s2).^2);
end
