function feature2 = AVGmask(X,Xe)
[h,w,K] = size(X);
[INDEX,INDEX1] = sortmap(X,Xe);
fS = generatiion(INDEX,X);
fN = generatiion(INDEX1,Xe);
for p =1:K
    XS(:,:,p) = X(:,:,p).*fS;  %% VGG16
end
for p =1:K
    XN(:,:,p) = Xe(:,:,p).*fN; %% VGG19
end
%  [INDEXS,INDEXN] = sortmap(XS,XN);
% fS1 = generatiion1(INDEXS,XS);
% fN1 = generatiion1(INDEXN,XN);
% for p =1:K
%     XS1(:,:,p) = XS(:,:,p).*fS1;
% end
% for p =1:K
%     XN1(:,:,p) = XN(:,:,p).*fN1;
% end
for i =1:K
    X(:,:,i) = XS(:,:,i) + XN(:,:,i);
end
feature2 = apply_aggregation(X);
end