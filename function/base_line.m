function []=base_line(net,test_set,train_set,test_files,train_files,query_files)

eval(['load gnd_' test_set '.mat']);

test_features=sum_pool5(test_files,imlist);

eval(['load gnd_' train_set '.mat']);

train_features=sum_pool5(train_files,imlist);

eval(['load gnd_' test_set '.mat']);

if  ~strcmpi(test_set,'holidays')

    query_features=sum_pool5(query_files,q_name);

    query_nocrop_features=test_features(qidx,:);

    query_nocrop_features_normalize=normalize(query_nocrop_features,2,"norm");

else

    query_features=test_features(qidx,:);

end

test_features_normalize=normalize(test_features,2,'norm');

train_features_normalize=normalize(train_features,2,"norm");

query_features_normalize=normalize(query_features,2,"norm");

for m=1:7

    dim=8*2^(m-1);

    [test_features_pca,query_crop_features_pca]=Hy_whitening(train_features_normalize,test_features_normalize,query_features_normalize,dim);
    
    if  ~strcmpi(test_set,'holidays')
        
        [test_features_pca,query_nocrop_features_pca]=Hy_whitening(train_features_normalize,test_features_normalize,query_nocrop_features_normalize,dim);
    
    end

    dist=pdist2(test_features_pca,query_crop_features_pca,'seuclidean');

    [~, ranks] = sort(dist, 'ascend');

    [sum_cropnorpca_map,~] = compute_map (ranks, gnd);

    dist=pdist2(test_features,query_features,'seuclidean');

    [~, ranks] = sort(dist, 'ascend');

    [sum_crop_map,~] = compute_map (ranks, gnd);

    dist=pdist2(test_features_normalize,query_features_normalize,'seuclidean');

    [~, ranks] = sort(dist, 'ascend');

    [sum_cropnor_map,~] = compute_map (ranks, gnd);

    if  ~strcmpi(test_set,'holidays')

        dist=pdist2(test_features,query_nocrop_features,'seuclidean');
        
        [~, ranks] = sort(dist, 'ascend');

        [sum_nocrop_map,~] = compute_map (ranks, gnd);

        dist=pdist2(test_features_normalize,query_nocrop_features_normalize,'seuclidean');

        [~, ranks] = sort(dist, 'ascend');

        [sum_nocrop_nor_map,~] = compute_map (ranks, gnd);

        dist=pdist2(test_features_pca,query_nocrop_features_pca,'seuclidean');

        [~, ranks] = sort(dist, 'ascend');

        [sum_nocrop_norpca_map,~] = compute_map (ranks, gnd);

    end

    if  strcmpi(test_set,'holidays')

        sum_nocrop_map=0;

        sum_nocrop_nor_map=0;

        sum_nocrop_norpca_map=0;

    end

    fprintf('>> %s: %s: %d dim,\n (base line: sum_crop_map512: %.4f, sum_cropnor_map:%.4f, sum_cropnorpca_map: %.4f)\n    sum_nocrop_map512: %.4f, sum_nocrop_nor_map:%.4f, sum_nocrop_norpca_map: %.4f,\n', ...
        net,test_set, dim, sum_crop_map, sum_cropnor_map,  sum_cropnorpca_map,sum_nocrop_map, sum_nocrop_nor_map,  sum_nocrop_norpca_map);
    fprintf('-------------------------------------------------------------------------------------------------\n')
    fprintf('-------------------------------------------------------------------------------------------------\n')

end

end