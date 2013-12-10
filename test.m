function test( test_set,feature_mat )
%TEST Summary of this function goes here
%   Detailed explanation goes her

% dist_seg = [0,500,1200,2500,10000];
% score_seg = [100,92,85,1,0];
dist_seg = [0,800,2500,10000];
score_seg = [100,90,1,0];

seg_num = length(score_seg)-1;
cof_abc = zeros(seg_num,3);
for i=1:seg_num
    
    x1 = dist_seg(i);
    x2 = dist_seg(i+1);
    y1 = score_seg(i);
    y2 = score_seg(i+1);
    cof_abc(i,1) = (y2-y1)/((x2-x1)^2);
    cof_abc(i,2) = -2*x1*cof_abc(i,1);
    cof_abc(i,3) = y1+x1^2*cof_abc(i,1);
end
% max_dist = 100000;
% cof_k = -90/max_dist;

ps = dir(test_set);
test_people = size(ps,1)-2 ;

% results = zeros(test_people,1);
fprintf('======================== testing =========================\n');

for p = 1:test_people
    %     test_dir = [test_set,num2str(p),')/'];
    
    
    test_dir = [test_set,ps(p+2).name,'/'];
    files = dir(test_dir);
    n = size(files,1)-2;
    
    dists = zeros(n,1);
    final_score = 0;
    dist = zeros(1,1);
    dist_sum =zeros(1,1);
    
    %     seg_ps = zeros(seg_num,1);
    fprintf('#####  %s : \n',ps(p+2).name);
    for i=1:n
        waveFile = [test_dir,num2str(i),'.wav'];
        [y,fs,nbits] = wavread(waveFile);
        %             fprintf('fs = %d nbits=%d\n',fs,nbits);
        %             wavplay(y,fs);
        [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
        
        feature =  feature_extract(x,fs,zcr,shortEnergy);
        
        dist = dtw(feature_mat{i},feature);
        dist = dist/size(feature_mat{i},1);
        dist_sum = dist_sum+dist;
        %
        %         if(dist > max_dist)
        %             score = 0;
        %         else
        %             score = cof_k*dist+100;
        %         end
        
        for j=1:seg_num
            if(dist_seg(j)<=dist && dist <dist_seg(j+1))
                %                 seg_ps(j) = seg_ps(j)+1;
                score = dist^2*cof_abc(j,1)+dist*cof_abc(j,2)+cof_abc(j,3);
                %                 final_score = final_score + score;
            end
        end
        
%         fprintf('%dth sentence score = %.2f dtw_dist=%.2f\n',i,score,dist);
        
        %                       fprintf('%dth people %dth sentence: dist= %f score=%f\n',p,i,dist,score);
        %         dists(i) = dist;
        
        %          if dist > dist_seg(2)
        %              score = 0;
        %          else
        %             score = dist*cof_k+100;
        %          end
        %          fprintf('%dth people %dth sentence: score = %f dist=%f\n',p,i,score,dist);
        %          dist_sum = dist_sum+dist;
    end
    dist = dist_sum/n;
    for j=1:seg_num
        if(dist_seg(j)<=dist && dist <dist_seg(j+1))
            %                 seg_ps(j) = seg_ps(j)+1;
            final_score = dist^2*cof_abc(j,1)+dist*cof_abc(j,2)+cof_abc(j,3);
            
        end
    end
    
    %     if(dist > max_dist)
    %         final_score = 0;
    %     else
    %         final_score = cof_k*dist+100;
    %     end
    
    %         figure;
    %         plot(dists,'.-');
    %
    %         title([num2str(p),'th people']);
    
    %      fprintf('%dthpeople avg dist = %.2f\n',p,dist);
        fprintf('=== %s final score = %.2f ===\n',ps(p+2).name,final_score);
    results(p) = struct('name',ps(p+2).name,'final_score',final_score,'avg_dist',dist);
    %     fprintf('%dth people:\n');
    %     for i=1:seg_num
    %         fprintf('%d - %d:%d\n',dist_seg(i),dist_seg(i+1),seg_ps(i));
    %     end
    %    fprintf('##################\n');
end

fprintf('sorted result:\n');
[ans,pos] = sort([results.final_score],'descend');
% [ans,pos] = sort([results.dist]);
for i=1:test_people
    fprintf('%d: %s score=%.2f dtw_dist=%.2f\n',i,results(pos(i)).name,ans(i),results(pos(i)).avg_dist);
end

fprintf('======================== test end ========================\n');


end





