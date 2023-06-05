function [x] = GLCM(I)

glcm = graycomatrix(I, 'offset', [0 1], 'Symmetric', true,'NumLevels',8);

x = haralickTextureFeatures(glcm);

end