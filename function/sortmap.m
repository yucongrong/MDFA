function [INDEX,INDEX1] = sortmap(X,Xe)% Sort the feature maps

[~,~,K] = size(X);

rankX = GLCM_var(X);

rankXe = GLCM_var(Xe);

[~,index] = sort(rankX,'descend');

[~,index1] = sort(rankXe,'descend');

INDEX = reshape(index,[1,K]);

INDEX1 = reshape(index1,[1,K]);

end

 