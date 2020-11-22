function [ point, covMatrix ] = PlaneLineIntersect( plane, covPlane, line, covLine )
% Intersects a plane and a line.
% plane: Homogeneous representation of a 3D plane
% covPlane: Covariance matrix corresponding to the plane
% line: 3D line representation via Plücker coordinates
% covLine: Covariance matrix corresponding to the line
% point: 3D point representation via homogeneous coordinates
% covMatrix: Covariance matrix corresponding to the point

%--------------------------------------------(planeC, covC, line, covLine)
Gamma_line = [0,line(6),-line(5),-line(1);
             -line(6),0,line(4),-line(2);
             line(5),-line(4),0,-line(3);
             line(1),line(2),line(3),0];
Pi_Omega = [plane(4),0,0,-plane(1);
            0,plane(4),0,-plane(2);
            0,0,plane(4),-plane(3);
            0,-plane(3),plane(2),0;
            plane(3),0,-plane(1),0;
            -plane(2),0,0,0];
point = Gamma_line * plane;
covMatrix = Gamma_line'* covPlane * Gamma_line + Pi_Omega'* covLine * Pi_Omega;
%--------------------------------------------

end
