% test_ans = zeros(38,3,2);
% for i = 1:24
%     test_ans(i,1,1)=floor((i-1)/3)+1;
%     test_ans(i,1,2)=mod(i-1,3)+1;
%     test_ans(i,2,1)=-1;
%     test_ans(i,2,2)=-1;
%     test_ans(i,3,1)=-1;
%     test_ans(i,3,2)=-1;
% end
% 
% 
% for i=25:38
%     for j=1:3
%         test_ans(i,j,1)=-1;
%         test_ans(i,j,2)=-1;
%     end
% end
% 
% for i=1:38
%     for j=1:3
%         fprintf('%dth people %dth voice should be : door %d people %d\n',i,j,test_ans(i,j,1),test_ans(i,j,2));
%     end
% end
% 
% 
% save('test_ans2.mat','test_ans');

