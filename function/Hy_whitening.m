function [test_features_pca,query_features_pca] = Hy_whitening(train_features_normalize,test_features_normalize,query_features_normalize,dim)
%  PCA-whitening
[test_features,coeff,mu,u,s]= pca_and_whitening(train_features_normalize,test_features_normalize,dim);
test_features_pca=normalize(test_features,2,"norm");
q_features=normalize(query_features_normalize,2,"norm");
query_features_white=query_pca(q_features,coeff,mu,u,s,dim);
query_features_pca=normalize(query_features_white,2,"norm");
end



