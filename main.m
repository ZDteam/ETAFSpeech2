function main(song_name)

close all;
% clc;
open_multiple_thread();
% clear all;
warning off
if nargin == 1
    song_name_list = {song_name};
else
song_name_list = {...
    'beiyiwangdeshiguang',...
    'yiqiangeshangxindeliyou',...
    'yujian',...
    'badboy',...
    'cunzai',...
    'chenzao'...
    };
end
for i=1:length(song_name_list)
    song_name = song_name_list{i};
    fprintf('#### song: %s\n',song_name);
    train_dir = ['songs/',song_name,'/origin/'];
    if ~isdir(train_dir)
        fprintf('%s train_set does not exit!\n',song_name);
        continue;
    end
    test_dir =  ['songs/',song_name,'/test/'];
    if ~isdir(test_dir)
        fprintf('%s test_set does not exit!\n',song_name);
        continue;
    end
    feature_mat = train(train_dir);
    % fprintf('song_name: %s trained successfully\n',song_name);
    test(test_dir,feature_mat);
end


end

