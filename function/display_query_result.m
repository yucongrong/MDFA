function display_query_result(net,test_set,train_features_normalize,test_features_normalize,query_crop_features_normalize,query_nocrop_features_normalize,gnd,qe)

delete PW_ranks.mat;

delete ranks_QE.mat;

for m=1:7

    dim=8*2^(m-1);

    if ~strcmpi(test_set,'holidays')

        [~,PW_query_features_pca]=Hy_whitening(train_features_normalize,test_features_normalize,query_crop_features_normalize,dim);
    
    end

    [PW_test_features_pca,PW_query_nocrop_features_pca]=Hy_whitening(train_features_normalize,test_features_normalize,query_nocrop_features_normalize,dim);
    
    PW_dist=pdist2(PW_test_features_pca,PW_query_nocrop_features_pca,'seuclidean');
   
    [~, PW_ranks] = sort(PW_dist, 'ascend');

    [PWnocrop_map,~] = compute_map (PW_ranks, gnd);

    [ranks_QE] = rank_qe(PW_test_features_pca', PW_query_nocrop_features_pca', PW_ranks,qe);

    [PWnocrop_qe_map,~] = compute_map (ranks_QE, gnd);

    if ~strcmpi(test_set,'holidays')

        PW_dist=pdist2(PW_test_features_pca,PW_query_features_pca,'seuclidean');

        [~, PW_ranks] = sort(PW_dist, 'ascend');

        save PW_ranks;

        [PWcrop_map,~] = compute_map (PW_ranks, gnd);

        [ranks_QE] = rank_qe(PW_test_features_pca', PW_query_features_pca', PW_ranks,qe);

        save ranks_QE;

        [PWcrop_qe_map,~] = compute_map (ranks_QE, gnd);

    else

        PWcrop_map=0;

        PWcrop_qe_map=0;

    end

    fprintf(['>> %s: %s: %d dim:\n   crop: PWcrop_map: %.4f, PWcrop_qe_map: %.4f,\n' ...
        ' nocrop:PWnocrop_map:%.4f,PWnocrop_qe_map:%.4f\n\n'], net,test_set, dim, ...
        PWcrop_map,PWcrop_qe_map,PWnocrop_map,PWnocrop_qe_map);

end

end