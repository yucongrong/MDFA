function mask = AVG_mask(INDEX,X)

number = 20;

M = sum(X(:,:,INDEX(1:number)),3)./number;

Fmean = mean2(M);

M(M<sqrt(Fmean))=0;

M(M~=0)=1;

mask = M;

% mask = ConvexHull(M);% Perform post-processing on the mask

end