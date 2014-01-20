function d=dtw(s,t)


ns=size(s,1);
nt=size(t,1);
if(abs(ns-nt)>100)
    d=Inf;
    return;
end

% fprintf('ns = %d ; nt = %d\n',ns,nt);

%% initialization
D=zeros(ns+1,nt+1)+Inf; % cache matrix
D(1,1)=0;

%% begin dynamic programming
for i=1:ns
    for j=1:nt
        oost = Dist(s(i,:),t(j,:));
        D(i+1,j+1)=oost+min( [D(i,j+1), D(i+1,j), D(i,j)] );
    end
end
d=D(ns+1,nt+1);
% fp = fopen('fuck.txt','a+');
% fprintf(fp,'======================== fuck ========================\n');
% for i=1:ns
%     for j=1:nt
%         fprintf(fp,'%.2f ',D(i,j));
%     end
%     fprintf(fp,'\n');
% end
% fprintf(fp,'======================== fuck ========================\n');
end

function dist =Dist(s1,s2)
    dist = sum((s1-s2).^2);
end
