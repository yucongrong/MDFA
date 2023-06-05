function rankX = GLCM_var(X)

 [~,~,K] = size(X);

 glcm = arrayfun(@(i) GLCM(X(:,:,i)), 1:K, 'UniformOutput', false);

 glcm = cat(1, glcm{:});

 rankw =  reshape(glcm,14,K);

 rankX = rankw(4,:);

end