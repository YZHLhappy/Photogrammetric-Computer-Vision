function [] = VisualisePointCorrespondences()
% Shows the specified point correspondences on the associated RGB images.

[pointsLeft, pointsRight, ~, imageLeft, imageRight] = ImportData();

figure; ax = axes;
showMatchedFeatures(imageLeft,imageRight,pointsLeft(1:2,:)',pointsRight(1:2,:)','montage','Parent',ax);
title(ax, 'Point correspondences');

end