clear all; close all; dbstop error;

% Import parameters
[pointsPlaneA, pointsPlaneB, pointsPlaneC, projectionCenter, ...
    rotationMatrix, principlePoint, cameraConstant, skewness, scale, ...
    imagePoints, covPointA, covPointB, covPointC] = ImportParameters();

% Reconstruct planes
[planeA, covA] = ReconPlane(pointsPlaneA);
[planeB, covB] = ReconPlane(pointsPlaneB);
[planeC, covC] = ReconPlane(pointsPlaneC);

% Intersect first two planes
[line,covLine] = PlanePlaneIntersect(planeA, covA, planeB, covB);

% Intersect resulting line with third plane
[point, covPoint] = PlaneLineIntersect(planeC, covC, line, covLine);

% Compose the projection matrix
projectionMatrix = ComposeProjectionMatrix(projectionCenter, rotationMatrix, ...
    principlePoint, cameraConstant, skewness, scale);

% Decide to which image point the object point probably coincides to

%--------------------------------------------
X_Homogeneous = projectionMatrix * point;
Cov_Homogeneous = projectionMatrix * covPoint * projectionMatrix';

projectedPoint = [X_Homogeneous(1)/X_Homogeneous(3);X_Homogeneous(2)/X_Homogeneous(3)];
Cov_Jacobean_matrix =1/X_Homogeneous(3)* [1,0,-X_Homogeneous(1)/X_Homogeneous(3);
                       0,1,-X_Homogeneous(2)/X_Homogeneous(3);
                       0,0,0];
covProjected = Cov_Jacobean_matrix * Cov_Homogeneous * Cov_Jacobean_matrix';
%--------------------------------------------

%Draw error ellipses
figure
hold on
PlotErrorEllipse(projectedPoint, covProjected);
PlotErrorEllipse(imagePoints(:,1), covPointA);
PlotErrorEllipse(imagePoints(:,2), covPointB);
PlotErrorEllipse(imagePoints(:,3), covPointC);
plot(imagePoints(1,1),imagePoints(2,1),'*')
plot(imagePoints(1,2),imagePoints(2,2),'*')
plot(imagePoints(1,3),imagePoints(2,3),'*')
plot(projectedPoint(1),projectedPoint(2),'--o')
hold off
figure(2)
scatter3(pointsPlaneA(1,:),pointsPlaneA(2,:),pointsPlaneA(3,:))
hold on
scatter3(pointsPlaneB(1,:),pointsPlaneB(2,:),pointsPlaneB(3,:))
hold on
scatter3(pointsPlaneC(1,:),pointsPlaneC(2,:),pointsPlaneC(3,:))
hold on
