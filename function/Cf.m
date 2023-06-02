function featureY = Cf(x1,K)
[h,w,K] = size(x1);
xtsum = sum(x1,[1 2]);
xtsum = reshape(xtsum,[1,K]);
for i= 1:K
    A = x1(:,:,i);
    [row,col]=find(A~=0);
    rowNum = size(row);
    vector1(i) = rowNum(1);
end
x1sumMean = xtsum./(vector1+(1e-6));
sumMean =  sum(x1sumMean);
chenal = log((sumMean)./((1e-6)+x1sumMean));
y = reshape(chenal,[1,K]);
featureY = y;
end