function features = apply_aggregation(X)
x1 = X;
t = 2;
[h,w,K] = size(x1);
for i = 1:K
    x1(:,:,i) = x1(:,:,i) - mean2(x1(:,:,i));
end
x1t = bsxfun(@power, x1, t);
factor = Cf(X,K);
x1tsum = sum(x1t,[1 2]);
y = reshape(x1tsum,[1,K]);
y1 = bsxfun(@power, y, 1./t).*factor;
y1 = reshape(y1,[1,K]);
features = y1;
end