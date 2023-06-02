clc;clear;
net ='multi_model';  
test_set ='paris6k';
layers = 'pool5';
qe = 10;
crop = 0;
switch test_set
    case {'oxford5k'}
        train_set = 'paris6k';
    case {'paris6k'}
        train_set = 'oxford5k';
    case {'holidays'}
        train_set = 'oxford5k';
    case {'oxford105k'}
        train_set = 'paris6k';
        query_files = dir(fullfile('D:\features\oxfordD\query\','*.mat'));
    case {'paris106k'}
        train_set ='oxford5k';
        query_files = dir(fullfile('D:\features\parisD\query\','*.mat'));
end
eval(['load gnd_' test_set '.mat']);
switch layers
    case {'pool5'}
        if ~exist("query_files","var")
        % VGG16
            query_files = dir(fullfile('D:\features\parisD\pool5QUERY\','*.mat'));
        end
        test_files = dir(fullfile('D:\features\parisD\pool5\','*.mat'));
        train_files = dir(fullfile('D:\features\oxfordD\pool5\','*.mat'));
        % VGG19
        test_filese = dir(fullfile('D:\features\parisE\pool5\','*.mat'));
        train_filese = dir(fullfile('D:\features\oxfordE\pool5\','*.mat'));
        query_filese = dir(fullfile('D:\features\parisE\pool5QUERY\','*.mat'));
    case {'res5c_relu'}
        if ~exist("query_files","var")
            query_files = dir(fullfile('F:\features\resnet101\oxford_resnet101_res5c_relu_query_features\','*.mat'));
        end
        test_files = dir(fullfile('F:\features\resnet101\oxford_resnet101_res5c_relu_features\','*.mat'));
        train_files = dir(fullfile('F:\features\resnet101\paris_resnet101_res5c_relu_features\','*.mat'));
end
warning off 
% base_line(net,test_set,train_set,test_files,train_files,query_files);
fprintf('Extracting test set features...\n')
eval(['load gnd_' test_set '.mat']);
test_features = features_aggregation(test_files,imlist,test_filese);
fprintf('Extracting train set features...\n')
eval(['load gnd_' train_set '.mat']);
train_features = features_aggregation(train_files,imlist,train_filese);
test_features_normalize = normalize(test_features,2,"norm");
train_features_normalize = normalize(train_features,2,"norm");
eval(['load gnd_' test_set '.mat']);
if  strcmpi(test_set,'holidays')
    query_nocrop_features_normalize = test_features_normalize(qidx,:);
    query_crop_features_normalize = 0;
else
    eval(['load gnd_' test_set '.mat']);
    query_features=features_aggregation(query_files,q_name,query_filese);
    query_crop_features_normalize = normalize(query_features,2,"norm");
    query_nocrop_features_normalize = test_features_normalize(qidx,:);
end
display_query_result(net,test_set,train_features_normalize,test_features_normalize,query_crop_features_normalize,query_nocrop_features_normalize,gnd,qe);