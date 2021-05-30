function [] = VisualiseEpipolarLines(matrix, isFundamental)
% Shows the detected points in the second image together with the
% corresponding epipolar lines.
% matrix: A Fundamental or an Essential matrix
% isFundamental: Boolean variable that indicates if the specified matrix is
% a Fundamental or an Essential matrix.

samples=[10,20];

[pointsLeft, pointsRight, K, ~, imageRight] = ImportData();
if ~isFundamental
    matrix = inv(K')*matrix*inv(K);
end

epipolarLines = epipolarLine(matrix, pointsLeft(1:2,samples(1):samples(2))');
borderPoints = lineToBorderPoints(epipolarLines,size(imageRight));

figure; 
imshow(imageRight); 
title('Points and Epipolar Lines in Second Image'); hold on;
CM = jet(samples(2)-samples(1));
for i=1:samples(2)-samples(1)
    pointIdx = samples(1)+i-1;
    plot(pointsRight(1,pointIdx)', pointsRight(2,pointIdx)','marker','o','color',CM(i,:),'LineWidth',2);
    line(borderPoints(i,[1,3])',borderPoints(i,[2,4])','color',CM(i,:),'LineWidth',2);
end

end
