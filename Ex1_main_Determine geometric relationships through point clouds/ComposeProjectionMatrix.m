function [ projectionMatrix ] = ComposeProjectionMatrix( projectionCenter, rotationMatrix, ...
    principlePoint, cameraConstant, skewness, scale )
% Compose the projection matrix of the input parameters.
% projectionCenter: 3D point in world coordinate system
% rotationMatrix: 3x3 matrix
% principlePoint: 2D point in image coordinate system
% cameraConstant: Camera constant
% skewness: Skweness of the y-axis
% scale: Scale of the y-axis

%--------------------------------------------
K = [-cameraConstant,-cameraConstant * skewness, principlePoint(1);
     0,-cameraConstant * scale,principlePoint(2);
     0,0,1];
projectionMatrix = K * rotationMatrix'* [1,0,0,projectionCenter(1);
                                         0,1,0,projectionCenter(2);
                                         0,0,1,projectionCenter(3)];
%--------------------------------------------
                 
end
