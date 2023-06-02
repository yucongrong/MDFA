function filter = generatiion(INDEX,X)
number = 20;
for j = 1:number
    c = INDEX(j);
    SC(:,:,j) = X(:,:,c);
end
S = sum(SC,3);
F = S./number;
Fmean = mean2(F);
for m = 1:size(F,1)
    for n = 1:size(F,2)
        if F(m,n) < Fmean.^(1./2)
            F(m,n) = 0;
        else
            F(m,n) = 1;
        end
    end
end
filter = F;
end