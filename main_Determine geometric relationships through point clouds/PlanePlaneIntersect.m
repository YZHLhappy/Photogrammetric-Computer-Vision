function [ line, covMatrix ] = PlanePlaneIntersect( planeA, covA, planeB, covB )
% Intersects two planes.
% planeA, planeB: Homogeneous representation of 3D planes.
% covA, covB: Covariance matrices corresponding to the planes
% line: 3D line representation via Plücker coordinates.
% covMatrix: Covariance matrix corresponding to the line

%--------------------------------------------
Pi_Omega_planA = [0,-planeA(3),planeA(2),0;
                  planeA(3),0,-planeA(1),0;
                  -planeA(2),planeA(1),0,0;
                  planeA(4),0,0,-planeA(1);
                  0,planeA(4),0,-planeA(2);
                  0,0,planeA(4),-planeA(3)];
Pi_Omega_planB = [0,-planeB(3),planeB(2),0;
                  planeB(3),0,-planeB(1),0;
                  -planeB(2),planeB(1),0,0;
                  planeB(4),0,0,-planeB(1);
                  0,planeB(4),0,-planeB(2);
                  0,0,planeB(4),-planeB(3)];
line = Pi_Omega_planA * planeB;
covMatrix = Pi_Omega_planA * covB * Pi_Omega_planA' + Pi_Omega_planB * covA * Pi_Omega_planB';
%--------------------------------------------
                  
end