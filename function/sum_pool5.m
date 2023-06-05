function features=sum_pool5(files,imlist)

features_num = size(files,1);

features=[];

parfor i=1:features_num

    features_path=[files(i).folder,'\',imlist{i},'.mat'];

    pool5 = importdata(features_path);

    [~,~,K] = size(pool5);

    sum_p=reshape(sum(pool5,[1,2]),[1,K]);

    features=[features;sum_p];

    if mod(i,1000) == 0
        i
    end
    
end
