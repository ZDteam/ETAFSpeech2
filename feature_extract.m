function [v] = feature_extract(x,fs,zcr,shortEnergy)

%         v=get_det(zcr);
      v= mfcc(x,fs,shortEnergy);

%      v = [v get_det(zcr) get_det(shortEnergy)];
     %      return ;
%      %     v1 =unify( get_det(zcr),0,100);
%      v2 = unify(get_det(shortEnergy),0,100);
%      v3 = mfcc(x,fs,shortEnergy);
%      v4 = unify(zcr,0,100);
%      for i = 1:size(v3,1)
%          v3(i,:) = unify(v3(i,:),0,80);
%      end
% % disp(v);
% %     v = [v zcr];
%      v = [v2 v3 v4];
end