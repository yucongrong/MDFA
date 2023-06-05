function Ck = channelFactor(x1,K)

xtsum = sum(x1,[1 2]);

xtsum = reshape(xtsum,[1,K]);

nonzero_counts = sum(sum(x1 ~= 0, 1), 2);

nonzero_counts= reshape(nonzero_counts,[1,K]);

Rk = xtsum./(nonzero_counts+(1e-6));

Ck = log(sum(Rk)./((1e-6)+Rk));

Ck = reshape(Ck,[1,K]);

end