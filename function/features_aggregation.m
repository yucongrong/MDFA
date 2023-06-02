function features=features_aggregation(files,list,leveal)
features=[];
parfor i = 1:size(files,1)
    path = [files(i).folder,'\',list{i},'.mat'];
    path1 = [leveal(i).folder,'\',list{i},'.mat'];
    feature = [];
    pool5 = importdata(path);    %% VGG16
    poole =  importdata(path1);  %% VGG19
    feature = AVGmask(pool5,poole);
    features = [features;feature];
    if mod(i,1000) == 0
        i
    end
end
end