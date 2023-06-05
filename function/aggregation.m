function feature = aggregation(X)

x1 = X;

t = 2;

[~,~,K] = size(x1);

CK = channelFactor(X,K);% Calculate the channel contribution factor

x1 = x1 - mean(x1,[1 2]);

x1t = bsxfun(@power, x1, t);

x1tsum = sum(x1t,[1 2]);

y = reshape(x1tsum,[1,K]);

y1 = bsxfun(@power, y, 1./t).*CK;

feature = reshape(y1,[1,K]);

end