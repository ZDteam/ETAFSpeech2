function test( test_set,feature_mat,TEST_FS,song_name,ETAF_DEBUG,ETAF_RMZERO )




%%
% dist_seg = [0,500,1200,2500,10000];
% score_seg = [100,92,85,1,0];
% dist_seg = [0,800,2500,10000];
% score_seg = [100,90,1,0];
dist_seg = [0,15,100,inf];
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
    
    %     cof_abc(i,1) = -(y2-y1)/((x2-x1)^2);
    %     cof_abc(i,2) = -2*x2*cof_abc(i,1);
    %     cof_abc(i,3) = y2+x2^2*cof_abc(i,1);
    
end
%%
ps = dir(test_set);
test_people = size(ps,1)-2 ;

% results = zeros(test_people,1);
fprintf('======================== testing =========================\n');
for p = 1:test_people
    test_dir = [test_set,ps(p+2).name,'/'];
    files = dir(test_dir);
    n = size(files,1)-2;
    
    dists = zeros(n,1);
    final_score = 0;
    dist = zeros(1,1);
    dist_sum =zeros(1,1);
    
    for i=1:n
        waveFile = [test_dir,num2str(i),'.wav'];
        [y,fs,nbits] = wavread(waveFile);
        if(ETAF_DEBUG)
            fprintf('fs = %d nbits=%d\n',fs,nbits);
        end
        if(fs ~= TEST_FS)
            y = resample(y,TEST_FS,fs);
            fs = TEST_FS;
        end
        if(ETAF_DEBUG)
            fprintf('resample: fs = %d\n',fs);
        end
        %             wavplay(y,fs);
        %         [x,zcr,shortEnergy] = pre_process(waveFile,y,fs,nbits);
        if(ETAF_RMZERO)
            y = remove_zero(y);
        end
        if(length(y)<256)
            dist =Inf;
        else
            feature =  feature_extract_2(y,fs);
            dist = dtw(feature_mat{i},feature);
            
%             dist = etaf_dist(feature_mat{i},feature);
           
            dist = dist/size(feature_mat{i},1);
            dist_sum = dist_sum+dist;
        end
        if(ETAF_DEBUG)
            fprintf('%dth sentence origin_frame_num = %d; test_frame_num=%d\n',i,size(feature_mat{i},1),size(feature,1));
        end
        
        
       
        
        for j=1:seg_num
            if(dist_seg(j)<=dist && dist <dist_seg(j+1))
                score = dist^2*cof_abc(j,1)+dist*cof_abc(j,2)+cof_abc(j,3);
            end
        end
        
        
    end
    dist = dist_sum/n;
    for j=1:seg_num
        if(dist_seg(j)<=dist && dist <dist_seg(j+1))
            
            final_score = dist^2*cof_abc(j,1)+dist*cof_abc(j,2)+cof_abc(j,3);
            
        end
    end
    
    
    if(ETAF_DEBUG)
        fprintf('### %s final score = %.2f\n',ps(p+2).name,final_score);
    end
    results(p) = struct('name',ps(p+2).name,'final_score',final_score,'avg_dist',dist);
    
end
%%
fprintf('%s: sorted result:\n',song_name);
[etaf_ans,pos] = sort([results.avg_dist],'ascend');

for i=1:test_people
    fprintf('%d: %s score=%.2f dtw_dist=%.2f\n',i,results(pos(i)).name,results(pos(i)).final_score,results(pos(i)).avg_dist);
end

fprintf('======================== test end ========================\n');

%%
fp = fopen('test_report.txt','a+');
now_time = [num2str(hour(now)),':',num2str(minute(now)),' ',num2str(year(now)),'-',num2str(month(now)),'-',num2str(day(now))];

fprintf(fp,'======================== test begin ========================\n');

fprintf(fp,'test_report at %s\n',now_time);
fprintf(fp,'%s: sorted result:\n',song_name);

for i=1:test_people
    fprintf(fp,'%d: %s score=%.2f dtw_dist=%.2f\n',i,results(pos(i)).name,etaf_ans(i),results(pos(i)).avg_dist);
end

fprintf(fp,'======================== test end ========================\n\n\n');

fclose(fp);
end





