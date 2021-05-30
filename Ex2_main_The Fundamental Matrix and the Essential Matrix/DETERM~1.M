function [ score, inlierIdx ] = DetermineConsensusSet( pointsImg1, pointsImg2, essentialMatrix, calibrationMatrix )
% Determine the quality of an Essential matrix using point correspondences.
% pointsImg1: Matrix containing homogeneous points from the first
% image. (One point per column!)
% pointsImg2: Matrix containing homogeneous points from the second
% image. (One point per column!) 
% Note: pointsImg1 and pointsImg2 have to be equally sorted, so that the
% points corresponding to the same pair have the same index.
% essentialMatrix: Essential matrix
% calibrationMatrix: Calibration matrix
% score: Percentage of points contained in the consensus set.
% inlierIdx: List indices of point correspondences assumed to be inliers.

%--------------------------------------------
%------- Task 1d: Add your code here --------
[~,n] = size(pointsImg1);
F = ((calibrationMatrix')^(-1)) * essentialMatrix * (calibrationMatrix^(-1));

score = 0;
inlierIdx_process = 0;

for i = 1:n
    I_2 = F * pointsImg1(:,i);
    I_H = [I_2(1) I_2(2)];
    d = I_2' * pointsImg2(:,i)/norm(I_H);
    distance(i) = abs(d);
    if  distance(i) < 3
        score = score +1;
        inlierIdx_process(i) = i;
    end
    inlierIdx = find(inlierIdx_process);
end
score = score/n;
% %--------------------------------------------
end