function [INDEX,INDEX1] = sortmap(X,Xe)
order = 4;
[hei,wid,K] = size(X);
glcm = zeros(14,K);
rankw = zeros(1,K);
for i=1:K
    glcm(:,i)=  GLCM(X(:,:,i));
    rankw(1,i) = glcm(order,i);
end
for i=1:K
    glcmX(:,i)=  GLCM(Xe(:,:,i));
    rankwX(1,i) = glcmX(order,i);
end
[~,index] = sort(rankw,'descend');
[~,index1] = sort(rankwX,'descend');
INDEX = reshape(index,[1,K]);
INDEX1 = reshape(index1,[1,K]);
end