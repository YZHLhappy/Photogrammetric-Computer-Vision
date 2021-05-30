function [ essentialMatrix,score_max ] = EstimateEwithRANSAC( pointsImg1, pointsImg2, calibrationMatrix )
% RANSAC-based estimation of the Essential matrix.
% pointsImg1: Matrix containing homogeneous points from the first
% image. (One point per column!)
% pointsImg2: Matrix containing homogeneous points from the second
% image. (One point per column!) 
% Note: pointsImg1 and pointsImg2 have to be equally sorted, so that the
% points corresponding to the same pair have the same index.
% calibrationMatrix: Calibration matrix
% essentialMatrix: Final Essential matrix

%--------------------------------------------
%------- Task 1c: Add your code here --------
%outliers = 30%
p = 0.995;
inliers = 1-0.3;
w = inliers;
s = 8;
N = ceil(log(1-p) / log(1-w^s));
%--------------------------------------------
%--------------------------------------------
%------- Task 1e: Add your code here --------
[~,n] = size(pointsImg1);

% 2021.02.08
score_max = 0;

% 2021.02.08
inlierIdx_max = 0;
point_random_index_alt = zeros(1,8);
% aaa = 0;
 for i = 1:N
     point_random_index = randi(n,[1,8]);
     %point_random_index = [74,101,82,29,19,29,74,54];
     
     % 2021.02.08
     Lia = ismember(point_random_index,point_random_index_alt,'rows');
     Lia_out(i) = Lia;
    if Lia == 0
        point_random_index_alt(i,:) = point_random_index;
     %if point_random_index_alt ~= point_random_index 
        % point_random_index_alt(i,:) = point_random_index;
         for j = 1:s
            point_random_1(:,j) = pointsImg1(:,point_random_index(j));
            point_random_2(:,j) = pointsImg2(:,point_random_index(j));
         end
         essentialMatrix_compulate = EstimateE(point_random_1,point_random_2,calibrationMatrix);
         [score,inlierIdx] = DetermineConsensusSet(pointsImg1,pointsImg2,essentialMatrix_compulate,calibrationMatrix );

         if score_max <= score
             score_max = score;
             essentialMatrix = essentialMatrix_compulate;
             inlierIdx_max = inlierIdx;
         end
    else
        i =i-1;
%         aaa = aaa+1;
    
    end
 end
%--------------------------------------------
end
