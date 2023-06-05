function features=features_aggregation(files,list,filese)

features=[];

parfor i = 1:size(files,1)

    path = [files(i).folder,'\',list{i},'.mat'];

    path1 = [filese(i).folder,'\',list{i},'.mat'];

    pool5 = importdata(path);    % VGG16

    poole =  importdata(path1);  % VGG19

    feature = models_aggregation(pool5,poole);

    features = [features;feature];

    if mod(i,1000) == 0
        i
    end

end

end