clc;clear;
% Ender image address
oxford5k_image_dir=dir(fullfile('F:\dataset\oxford5k\','*.jpg'));
paris6k_image_dir=dir(fullfile('F:\dataset\paris6k\','*.jpg'));
holidays_image_dir=dir(fullfile('F:\dataset\HolidaysDataset\','*.jpg'));

% Parameter settings
net ='multi_model';  % VGG16 and VGG19
test_set ='oxford105k'; % oxford5k, paris6k, holidays, oxford105k, paris106k
layers = 'pool5';
qe = 10;
crop = 0;
switch test_set
    case {'oxford5k'}
        train_set = 'paris6k';
        test_image_dir=oxford5k_image_dir;
        train_image_dir=paris6k_image_dir;
    case {'paris6k'}
        train_set = 'oxford5k';
        test_image_dir=paris6k_image_dir;
        train_image_dir=oxford5k_image_dir;
    case {'holidays'}
        train_set = 'oxford5k';
        test_image_dir=holidays_image_dir;
         train_image_dir=oxford5k_image_dir;
    case {'oxford105k'}
        train_set = 'paris6k';
   
    case {'paris106k'}
        train_set ='oxford5k';
        
end
eval(['load gnd_' test_set '.mat']);


% Determine if a corresponding folder exists in the current path. If it does not exist, create it. You can change the './' to save your own file path
% such as: test_vgg16_pool5_dir = dir(['D:\data\',test_set,'_vgg16','\','pool5']);
% Extract test set features
test_vgg16_pool5_dir = dir(['./',test_set,'_vgg16','/','pool5']);
test_vgg16_pool5QUERY_dir = dir(['./',test_set,'_vgg16','/','pool5QUERY']);
if ~exist(['./',test_set,'_vgg16','/'],'dir')
   mkdir(['./',test_set,'_vgg16','/','pool5'])
   mkdir(['./',test_set,'_vgg16','/','pool5QUERY'])
   test_vgg16_pool5_dir = dir(['./',test_set,'_vgg16','/','pool5']);
   test_vgg16_pool5QUERY_dir = dir(['./',test_set,'_vgg16','/','pool5QUERY']);
   fprintf('Extracting vgg16 test features...\n')
   extract_feature(test_set,test_vgg16_pool5_dir,test_vgg16_pool5QUERY_dir,test_image_dir,'16')    
end

test_vgg19_pool5_dir = dir(['./',test_set,'_vgg19','/','pool5']);
test_vgg19_pool5QUERY_dir = dir(['./',test_set,'_vgg19','/','pool5QUERY']);
if ~exist(['./',test_set,'_vgg19','/'],'dir')
   mkdir(['./',test_set,'_vgg19','/','pool5'])
   mkdir(['./',test_set,'_vgg19','/','pool5QUERY'])
   test_vgg19_pool5_dir = dir(['./',test_set,'_vgg19','/','pool5']);
   test_vgg19_pool5QUERY_dir = dir(['./',test_set,'_vgg19','/','pool5QUERY']);
   fprintf('Extracting vgg19 test features...\n')
   extract_feature(test_set,test_vgg19_pool5_dir,test_vgg19_pool5QUERY_dir,test_image_dir,'19')    
end

% Extract train set features
train_vgg16_pool5_dir = dir(['./',train_set,'_vgg16','/','pool5']);
train_vgg16_pool5QUERY_dir = dir(['./',train_set,'_vgg16','/','pool5QUERY']);
if ~exist(['./',train_set,'_vgg16','/'],'dir')
   mkdir(['./',train_set,'_vgg16','/','pool5'])
   mkdir(['./',train_set,'_vgg16','/','pool5QUERY'])
   train_vgg16_pool5_dir = dir(['./',train_set,'_vgg16','/','pool5']);
   train_vgg16_pool5QUERY_dir = dir(['./',train_set,'_vgg16','/','pool5QUERY']);
   fprintf('Extracting vgg16 train features...\n')
   extract_feature(train_set,train_vgg16_pool5_dir,train_vgg16_pool5QUERY_dir,train_image_dir,'16')    
end

train_vgg19_pool5_dir = dir(['./',train_set,'_vgg19','/','pool5']);
train_vgg19_pool5QUERY_dir = dir(['./',train_set,'_vgg19','/','pool5QUERY']);
if ~exist(['./',train_set,'_vgg19','/'],'dir')
   mkdir(['./',train_set,'_vgg19','/','pool5'])
   mkdir(['./',train_set,'_vgg19','/','pool5QUERY'])
   train_vgg19_pool5_dir = dir(['./',train_set,'_vgg19','/','pool5']);
   train_vgg19_pool5QUERY_dir = dir(['./',train_set,'_vgg19','/','pool5QUERY']);
   fprintf('Extracting vgg19 train features...\n')
   extract_feature(train_set,train_vgg19_pool5_dir,train_vgg19_pool5QUERY_dir,train_image_dir,'19')    
end


% Get pool5 File Path

eval(['load gnd_' test_set '.mat']);

% VGG16
query_files = dir(fullfile([test_vgg16_pool5QUERY_dir(1).folder,'\'],'*.mat'));
test_files = dir(fullfile([test_vgg16_pool5_dir(1).folder,'\'],'*.mat'));
train_files = dir(fullfile([train_vgg16_pool5_dir(1).folder,'\'],'*.mat'));
% VGG19
test_filese = dir(fullfile([test_vgg19_pool5_dir(1).folder,'\'],'*.mat'));
train_filese = dir(fullfile([train_vgg19_pool5_dir(1).folder,'\'],'*.mat'));
query_filese = dir(fullfile([test_vgg19_pool5QUERY_dir(1).folder,'\'],'*.mat'));


% Feature aggregation

warning off
% base_line(net,test_set,train_set,test_files,train_files,query_files);
fprintf('Aggregating test set features...\n')
eval(['load gnd_' test_set '.mat']);
test_features = features_aggregation(test_files,imlist,test_filese);

fprintf('Aggregating train set features...\n')
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

%PCA-whitening and calculating mAP
display_query_result(net,test_set,train_features_normalize,test_features_normalize,query_crop_features_normalize,query_nocrop_features_normalize,gnd,qe);
