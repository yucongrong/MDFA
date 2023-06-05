function feature = models_aggregation(X,Xe)

[INDEX,INDEX1] = sortmap(X,Xe);

fS = AVG_mask(INDEX,X);

fN = AVG_mask(INDEX1,Xe);

    XS = X.*fS;  % VGG16

    XN= Xe.*fN; % VGG19

    Xstar = XS + XN;

feature = aggregation(Xstar);

end