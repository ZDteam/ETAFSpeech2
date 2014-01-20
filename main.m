function main(song_name)

close all;
% clc;
open_multiple_thread();
% clear all;
warning off

ETAF_DEBUG = false;
ETAF_RMZERO  = false;
TEST_FS = 16000;

if nargin == 1
    song_name_list = {song_name};
else
    song_name_list = {...
        'ʮ�꾲��',...
        '��������ʱ��',...
        'һǧ�����ĵ�����',...
        '����',...
        '���ǵļ���',...
        'ǡ���������'...
        %     '����ˮ',...
        %     'ʮ��',...
        %     '����',...  
        %     'һ���˵ľ���', ...
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
    feature_mat = train(train_dir,TEST_FS,ETAF_DEBUG,ETAF_RMZERO);
    % fprintf('song_name: %s trained successfully\n',song_name);
    test(test_dir,feature_mat,TEST_FS,song_name,ETAF_DEBUG,ETAF_RMZERO);
end


end

