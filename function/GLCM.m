function [x] = GLCM(I)
glcm = graycomatrix(I, 'offset', [0 1], 'Symmetric', true,'NumLevels',8);%'NumLevels',4,'GrayLimits',[]
x = haralickTextureFeatures(glcm);
end