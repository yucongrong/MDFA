function [features]=sum_pool5(files,imlist)
features_num = size(files,1);
if nargin==2
    features=[];
    parfor i=1:features_num
        features_path=[files(i).folder,'\',imlist{i},'.mat'];
        pool5 = importdata(features_path);
        [h,w,K] = size(pool5);

        sum_p=reshape(sum(pool5,[1,2]),[1,K]);  %sum_pooling,base line

        features=[features;sum_p];

        if mod(i,1000) == 0
            i
        end
    end
else
    features=[];
    parfor i=1:features_num
        features_path=[files(i).folder,'\',files(i).name];
        pool5 = importdata(features_path);
        [h,w,K] = size(pool5);

        sum_p=reshape(sum(pool5,[1,2]),[1,K]);  %sum_pooling,base line

        features=[features;sum_p];

        if mod(i,1000) == 0
            i
        end
    end
end
end